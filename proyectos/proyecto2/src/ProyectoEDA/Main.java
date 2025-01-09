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
public class Main {
   
    public static void ejecutarRoundRobin(Cola procesos, int quantum) {
       int tiempo = 0; // Inicializar la variable tiempo

       while (!procesos.estaVacia()) {
            Proceso procesoActual = (Proceso) procesos.desencolar();
            int tiempoEjecucion = Math.min(quantum, procesoActual.getTiempoRestante());

            // Verificar si el proceso ha llegado antes de continuar
            if (procesoActual.getTiempoLlegada() <= tiempo) {
                System.out.println("Ejecutando " + procesoActual.getNombre() + " por " + tiempoEjecucion + " unidades de tiempo.");

                procesoActual.disminuirTiempoRestante(tiempoEjecucion);

                // Reevaluar el mismo proceso después de encolarlo nuevamente
                if (procesoActual.getTiempoRestante() > 0) {
                   procesos.encolar(procesoActual);
                } else {
                    System.out.println(procesoActual.getNombre() + " ha terminado su ejecución.");
                }
            } else {
                // Volver a encolar el proceso si no ha llegado
                procesos.encolar(procesoActual);
            }

            // Incrementar el tiempo solo si ha ocurrido alguna ejecución
            tiempo += procesoActual.getTiempoRestante() > 0 ? tiempoEjecucion : 0;
        }
    }
    
    public static void ejecutarSJF(Lista lista){
        int tiempo = 0;
        while (!lista.estaVacia()) {
            Proceso procesoActual = lista.buscarProcesoMenorTiempoRestante(tiempo);

            // Verificar si el proceso ha llegado antes de continuar
            if (procesoActual.getTiempoLlegada() <= tiempo) {
                if (procesoActual.getTiempoRestante() != 0) {
                    procesoActual.disminuirTiempoRestante(1);
                    System.out.println("Ejecutando " + procesoActual.getNombre() + " en el tiempo " + tiempo+" tiempo restante:" +procesoActual.getTiempoRestante());
                    tiempo++;
                } else {
                    lista.eliminarProceso(procesoActual.getNombre());
                }
            } else {
                System.out.println("No hay proceso a ejecutar en el tiempo " + tiempo + " tiempo restante:" +procesoActual.getTiempoRestante());
                tiempo++;
            }
        }
    }
}