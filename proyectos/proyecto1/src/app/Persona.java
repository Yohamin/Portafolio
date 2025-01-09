package app;

public class Persona {
    // Atributos
    protected int dni;
    protected String nombres;
    protected int ID;
    protected String prioridad;
    protected int edad;
    protected String carrera;       
    protected String asunto;
    protected String documento;        

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }
    
    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }
    

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
    // Metodos
    // Constructor
    public Persona() {
        this.dni = 0;
        this.nombres = "";
    }

    public Persona(int dni, String nombres,int ID, String prioridad,int edad,String carrera,String asunto, String documento) {
        this.dni = dni;
        this.nombres = nombres;
        this.ID = ID;
        this.prioridad = prioridad;
        this.edad = edad;
        this.carrera = carrera;
        this.asunto = asunto;
        this.documento=documento;    
    }
    // Getter and setter

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    @Override
    public String toString() {
        return nombres;
    }
}
