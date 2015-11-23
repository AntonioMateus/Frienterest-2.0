/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author Antonio Mateus
 */
public class SugestaoPaginas {
    private double distanciaEuclidiana (String interesses1, String interesses2) {
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
}