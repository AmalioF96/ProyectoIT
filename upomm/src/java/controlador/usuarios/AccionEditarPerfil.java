/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.usuarios;

import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import modelo.DAO.UsuarioDAO;
import modelo.Usuarios;

/**
 *
 * @author Propietario
 */
public class AccionEditarPerfil extends ActionSupport {

    private String nombre;
    private String password;
    private String newPassword;
    private String passwordConfirm;
    private boolean vendedor;

    public AccionEditarPerfil() {
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public boolean isVendedor() {
        return vendedor;
    }

    public void setVendedor(boolean vendedor) {
        this.vendedor = vendedor;
    }

    public void validate() {

        if (this.getNombre().equals("")) {
            addFieldError("nombre", "El nombre de usuario debe estar relleno");
        } else if (this.getNombre().length() < 4) {
            addFieldError("nombre", "El nombre de usuario debe tener 4 o más caracteres");
        }

        if (this.getPassword().equals("")) {
            addFieldError("password", "La contraseña debe estar rellena");
        } else if (this.getPassword().length() < 8) {
            addFieldError("password", "La contraseña debe tener un mínimo de 8 caractares");
        }

        if (this.getNewPassword().equals("")) {
            addFieldError("newPassword", "La contraseña debe estar rellena");
        } else if (this.getNewPassword().length() < 8) {
            addFieldError("newPassword", "La contraseña debe tener un mínimo de 8 caractares");
        }

        if (this.getPasswordConfirm().equals("")) {
            addFieldError("passwordConfirm", "La contraseña debe estar rellena");
        } else if (this.getPasswordConfirm().length() < 8) {
            addFieldError("passwordConfirm", "La contraseña debe tener un mínimo de 8 caractares");
        }

        if (!this.getNewPassword().equals(this.getPasswordConfirm())) {
            addFieldError("passwordConfirm", "las contraseñas no coinciden");
        }

    }

    public String execute() throws Exception {
        String salida = SUCCESS;
        String tipo;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        if (this.isVendedor()) {
            tipo = "vendedor";
        } else {
            tipo = "cliente";
        }
        if (UsuarioDAO.comprobarUsuario(user.getEmail(), this.getPassword()) == null) {
            addFieldError("password", "Contraseña errónea");
            salida = ERROR;
        } else {
            if (UsuarioDAO.existeNombre(this.getNombre())) {
                addFieldError("usuario", "Ya existe un usuario asociado al nombre");
                salida = ERROR;
            } else {

                user.setNombre(this.getNombre());
                user.setPassword(this.getNewPassword());
                user.setTipo(tipo);

                if (UsuarioDAO.actualizaUsuario(user)) {
                    session.put("usuario", user);
                    Map request = (Map) ActionContext.getContext().get("request");
                    request.put("error", false);
                } else {
                    salida = ERROR;
                }

            }
        }
        return salida;
    }

}