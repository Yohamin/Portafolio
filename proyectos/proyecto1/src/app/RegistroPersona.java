package app;

import tda.Lista;


public class RegistroPersona {
    private Lista<Persona> lista;
    
    public RegistroPersona(){
        this.lista = new Lista();
    }
    // Agregar Persona
    public void agregar(int ID, int dni, String nombres, String prioridad, int edad,String carrera, String asunto,String documento){
        Persona persona = new Persona(dni,nombres,ID,prioridad,edad,carrera,asunto,documento);
        lista.agregar(persona);
    }
    public int ubicacion(int dni){
        for (int i = 1; i <= lista.longitud(); i++) {
            if (lista.iesimo(i).getDni()==dni){
                return i;
            }
        }
        return -1;        
    }
    // eliminar del registro a una Persona
    public boolean eliminar(int dni) {
    int pos = ubicacion(dni);
    if (pos != -1) {
        lista.eliminar(pos); // Suponiendo que `eliminar` es un método en tu clase `Lista` que elimina el elemento en la posición dada.
        return true;
    }
    return false;
    }


    public int longitud(){
        return lista.longitud();
    }
    public Persona iesimo(int pos){
        return lista.iesimo(pos);
    }
    

    
}
