/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.usuarios;

import modelo.DAO.UsuarioDAO;
import com.opensymphony.xwork2.ActionSupport;

/**
 *
 * @author Amalio
 */
public class AccionLogin extends ActionSupport {

    String email;
    String password;

    public AccionLogin() {
    }

    public AccionLogin(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void validate() {

        boolean errores = false;

        if (this.email == null || this.email.trim().length() < 1) {
            addFieldError("email", getText("email.relleno"));
            errores = true;
        }

        if (this.password == null || this.password.trim().length() < 1) {
            addFieldError("password", getText("password.rellena"));
            errores = true;
        }

        if (!errores) {
            if (UsuarioDAO.comprobarUsuario(email, password) == null) {
                addFieldError("password", getText("Error en los datos"));

            }
        }
    }

    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }

}
