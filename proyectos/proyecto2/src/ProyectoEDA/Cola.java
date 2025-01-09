/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ProyectoEDA;

/**
 *
 * @author leo-f
 */
public class Cola {
    private Nodo frente;
    private Nodo fin;

    public Cola() {
        this.frente = null;
        this.fin = null;
    }

    public boolean estaVacia() {
        return frente == null;
    }

    public void encolar(Proceso proceso) {
        Nodo nuevoNodo = new Nodo(proceso);
        if (estaVacia()) {
            frente = nuevoNodo;
            fin = nuevoNodo;
        } else {
            fin.setSiguiente(nuevoNodo);
            fin = nuevoNodo;
        }
    }

    public Proceso desencolar() {
        if (estaVacia()) {
            System.out.println("La cola está vacía.");
            return null;
        } else {
            Proceso procesoDesencolado = frente.getProceso();
            frente = frente.getSiguiente();
            if (frente == null) {
                fin = null;
            }
            return procesoDesencolado;
        }
    }
}