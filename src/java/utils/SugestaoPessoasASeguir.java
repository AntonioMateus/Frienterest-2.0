/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import iot.jcypher.database.DBAccessFactory;
import iot.jcypher.database.DBProperties;
import iot.jcypher.database.DBType;
import iot.jcypher.database.IDBAccess;
import iot.jcypher.graph.GrNode;
import iot.jcypher.graph.GrRelation;
import iot.jcypher.query.JcQuery;
import iot.jcypher.query.api.IClause;
import iot.jcypher.query.factories.clause.DO;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;
import iot.jcypher.query.values.JcRelation;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

/**
 *
 * @author Antonio Mateus
 */
public class SugestaoPessoasASeguir {
    private static double distanciaEuclidiana (String interesses1, String interesses2) {
        String[] vetorInteresses1 = interesses1.split("");
        String[] vetorInteresses2 = interesses2.split("");
        
        double[] vetor1 = new double[20];
        double[] vetor2 = new double[20];
        
        for (int i = 0; i < 20; i++) {
            vetor1[i] = Double.valueOf(vetorInteresses1[i]);
            vetor2[i] = Double.valueOf(vetorInteresses2[i]);
        }
        
        double soma = 0; 
        for (int j = 0; j < 20; j++) {
            soma = soma + vetor1[j]*vetor2[j];
        }
        return Math.sqrt(soma);
    }
    
    public static List<GrNode> retornaPessoasMaisSemelhantes (int numeroPessoas) {
        final String SERVER_ROOT_URI = "http://localhost:7474/";
        final String user = "neo4j";
        final String passwd = "dba";
        
        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, user, passwd);
        JcNode usuarioSeguidor = new JcNode("Usuario");
        JcNode usuarioSeguido = new JcNode("Usuario");
        String usernameSeguidor = ControleLogin.getUsernameLogado();
        JcQuery obtencaoUsuarioSeguidor = new JcQuery();
        obtencaoUsuarioSeguidor.setClauses(new IClause[] {
            MATCH.node(usuarioSeguidor).label("Usuario").property("username").value(usernameSeguidor),
            RETURN.value(usuarioSeguidor)
        });
        String interessesUsuarioSeguidor = remote.execute(obtencaoUsuarioSeguidor).resultOf(usuarioSeguidor).get(0).getProperty("interesses").getValue().toString();
        JcQuery obtencaoUsuarios = new JcQuery();
        obtencaoUsuarios.setClauses(new IClause[] {
            MATCH.node(usuarioSeguido).label("Pagina"),
            RETURN.value(usuarioSeguido)
        });
        List<GrNode> usuarios = remote.execute(obtencaoUsuarios).resultOf(usuarioSeguido);
        JcQuery atualizaDistancia;
        for (GrNode usuario: usuarios) {
            atualizaDistancia = new JcQuery(); 
            atualizaDistancia.setClauses(new IClause[] {
                MATCH.node(usuarioSeguido).label("Usuario").property("username").value(usuario.getProperty("username").getValue().toString()),
                DO.SET(usuarioSeguido.property("distancia")).to(distanciaEuclidiana(usuario.getProperty("interesses").getValue().toString(),interessesUsuarioSeguidor))
            });
            remote.execute(atualizaDistancia);
        }
        JcQuery obtencaoUsuariosAtualizados = new JcQuery(); 
        obtencaoUsuariosAtualizados.setClauses(new IClause[] {
            MATCH.node(usuarioSeguido).label("Usuario"),
            RETURN.value(usuarioSeguido).ORDER_BY_DESC("distancia")
        });
        List<GrNode> usuariosPossivelmenteInteressantes = remote.execute(obtencaoUsuariosAtualizados).resultOf(usuarioSeguido); 
        List<GrNode> usuariosInteressantes = new LinkedList<>(); 
        JcQuery verificaSeJahSegue; 
        int contador = 0; 
        JcRelation relacao = new JcRelation("Segue");
        for (GrNode usuario: usuariosPossivelmenteInteressantes) {
            if (!usuario.getProperty("username").getValue().toString().equals(usernameSeguidor) && contador < numeroPessoas) {
                verificaSeJahSegue = new JcQuery();
                verificaSeJahSegue.setClauses(new IClause[] {
                    MATCH.node(usuarioSeguidor).label("Usuario").property("username").value(usernameSeguidor).relation(relacao).out().node(usuarioSeguido).label("Usuario")
                    .property("username").value(usuario.getProperty("username").getValue().toString()),
                    RETURN.value(relacao)
                }); 
                List<GrRelation> relacoes = remote.execute(verificaSeJahSegue).resultOf(relacao);
                if (relacoes.isEmpty()) {
                    usuariosInteressantes.add(usuario);
                    contador++;
                }
            }
        }        
        return usuariosInteressantes; 
    }
}