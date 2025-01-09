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
public class Proceso {
    private String nombre;
    private int tiempoRestante;
    private int tiempoLlegada;

    public Proceso(String nombre, int tiempoRestante, int tiempoLlegada) {
        this.nombre = nombre;
        this.tiempoRestante = tiempoRestante;
        this.tiempoLlegada = tiempoLlegada;
    }

    public String getNombre() {
        return nombre;
    }

    public int getTiempoLlegada() {
        return tiempoLlegada;
    }

    public int getTiempoRestante() {
        return tiempoRestante;
    }

    public void disminuirTiempoRestante(int tiempo) {
        this.tiempoRestante -= tiempo;
    }
    
    @Override
    public String toString() {
        return "Proceso{nombre='" + nombre + "', tiempoRestante=" + tiempoRestante + "}";
    }
}