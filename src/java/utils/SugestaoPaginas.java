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
import iot.jcypher.query.JcQuery;
import iot.jcypher.query.api.IClause;
import iot.jcypher.query.factories.clause.DO;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;
import java.util.List;
import java.util.Properties;

/**
 *
 * @author Antonio Mateus
 */
public class SugestaoPaginas {
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
    
    public static List<GrNode> retornaPaginasMaisSemelhantes (int numeroPaginas) {
        final String SERVER_ROOT_URI = "http://localhost:7474/";
        final String user = "neo4j";
        final String passwd = "dba";
        
        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, user, passwd);
        JcNode pagina = new JcNode("Pagina");
        JcNode usuario = new JcNode("Usuario");
        String username = ControleLogin.getUsernameLogado();
        JcQuery obtencaoUsuario = new JcQuery();
        obtencaoUsuario.setClauses(new IClause[] {
            MATCH.node(usuario).label("Usuario").property("username").value(username),
            RETURN.value(usuario)
        });
        String interessesUsuario = remote.execute(obtencaoUsuario).resultOf(usuario).get(0).getProperty("interesses").getValue().toString();
        JcQuery obtencaoPaginas = new JcQuery();
        obtencaoPaginas.setClauses(new IClause[] {
            MATCH.node(pagina).label("Pagina"),
            RETURN.value(pagina)
        });
        List<GrNode> paginas = remote.execute(obtencaoPaginas).resultOf(pagina);
        JcQuery atualizacaoDistancias; 
        for (GrNode pagina1 : paginas) {
            atualizacaoDistancias = new JcQuery();
            atualizacaoDistancias.setClauses(new IClause[]{
                MATCH.node(pagina).label("Pagina").property("nome").value(pagina1.getProperty("nome").getValue().toString()), 
                DO.SET(pagina.property("distancia")).to(distanciaEuclidiana(interessesUsuario, pagina1.getProperty("interesses").getValue().toString()))
            });
            remote.execute(atualizacaoDistancias);
        }
        JcQuery obtencaoPaginasMaisProximas = new JcQuery();
        obtencaoPaginasMaisProximas.setClauses(new IClause[] {
            MATCH.node(pagina).label("Pagina"),
            RETURN.value(pagina).ORDER_BY_DESC("distancia").LIMIT(numeroPaginas)
        });
        List<GrNode> paginasARetornar = remote.execute(obtencaoPaginasMaisProximas).resultOf(pagina);
        atualizacaoDistancias = new JcQuery(); 
        atualizacaoDistancias.setClauses(new IClause[] {
            MATCH.node(pagina).label("Pagina"),
            DO.SET(pagina.property("distancia")).to(0)
        });
        return paginasARetornar;
    }
}