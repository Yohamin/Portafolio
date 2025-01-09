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
public class Lista {
    private Nodo cabeza;

    public Lista() {
        this.cabeza = null;
    }

    public boolean estaVacia() {
        return cabeza == null;
    }

    public void agregarAlFinal(Proceso proceso) {
        Nodo nuevoNodo = new Nodo(proceso);

        if (estaVacia()) {
            cabeza = nuevoNodo;
        } else {
            Nodo actual = cabeza;
            while (actual.getSiguiente() != null) {
                actual = actual.getSiguiente();
            }
            actual.setSiguiente(nuevoNodo);
        }
    }
      public void eliminarProceso(String nombreProceso) {
        Nodo actual = cabeza;
        Nodo anterior = null;

        // Buscar el nodo a eliminar
        while (actual != null && !actual.getProceso().getNombre().equals(nombreProceso)) {
            anterior = actual;
            actual = actual.getSiguiente();
        }

        // Si se encontró el nodo, eliminarlo
        if (actual != null) {
            // Si es el primer nodo de la lista
            if (anterior == null) {
                cabeza = actual.getSiguiente();
            } else {
                anterior.setSiguiente(actual.getSiguiente());
            }
        }
        // No se imprime ningún mensaje, simplemente se elimina el proceso
    }

    public void mostrarLista() {
        Nodo actual = cabeza;
        while (actual != null) {
            System.out.println(actual.getProceso().toString());
            actual = actual.getSiguiente();
        }
    }
    
    public Cola Encolar(){
        Nodo actual = cabeza;
        Cola Procesos = new Cola();
        while (actual != null) {
            Procesos.encolar(actual.getProceso());
            actual = actual.getSiguiente();
        }
        return Procesos;
    }
    public void ordenarPorTiempoLlegada() {
        boolean intercambiado;
        do {
            intercambiado = false;
            Nodo actual = cabeza;
            Nodo siguiente = cabeza.getSiguiente();

            while (siguiente != null) {
                if (actual.getProceso().getTiempoLlegada() > siguiente.getProceso().getTiempoLlegada()) {
                    // Intercambiar los nodos
                    Proceso temp = actual.getProceso();
                    actual.setProceso(siguiente.getProceso());
                    siguiente.setProceso(temp);

                    intercambiado = true;
                }
                actual = siguiente;
                siguiente = siguiente.getSiguiente();
            }
        } while (intercambiado);
    }
    
    public Nodo buscar(String nombreProceso) {
        Nodo actual = cabeza;
        while (actual != null) {
            if (actual.getProceso().getNombre().equals(nombreProceso)) {
                return actual;
            }
            actual = actual.getSiguiente();
        }
        return null; // Si no se encuentra el proceso con el nombre dado
    }
    
    public Proceso buscarProcesoMenorTiempoRestante(int tiempo) {
        if (estaVacia()) {
            return null; // Retorna null si la lista está vacía
        }

        Nodo actual = cabeza;
        Proceso procesoMenorTiempo = actual.getProceso();

        while (actual != null) {
            if (actual.getProceso().getTiempoRestante() < procesoMenorTiempo.getTiempoRestante() && actual.getProceso().getTiempoLlegada()<= tiempo) {
                procesoMenorTiempo = actual.getProceso();
            }
            actual = actual.getSiguiente();
        }

        return procesoMenorTiempo;
    }
}
