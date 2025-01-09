/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app;

import java.util.HashMap;
import java.util.Map;
/**
 *
 * @author Yohamin
 */
public class BaseDatosUsuarios {
    private static Map<String, RegistrarUsuarioNuevo> usuarios = new HashMap<>();

    public static void registrarUsuario(String nombreUsuario, String contrasena) {
        usuarios.put(nombreUsuario, new RegistrarUsuarioNuevo(nombreUsuario, contrasena));
    }

    public static boolean verificarUsuario(String nombreUsuario, String contrasena) {
        RegistrarUsuarioNuevo usuario = usuarios.get(nombreUsuario);
        return usuario != null && usuario.getContrasena().equals(contrasena);
    }
}
