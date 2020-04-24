package controlador.usuarios;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static modelo.DAO.UsuarioDAO.comprobarUsuario;
import modelo.Productos;
import modelo.Usuarios;

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

    @Override
    public void validate() {
        if (this.getEmail() != null && this.getPassword() != null) {
            if (this.email.trim().length() < 1) {
                addFieldError("email", getText("email.relleno"));
            }

            if (this.password.trim().length() < 1) {
                addFieldError("password", getText("password.rellena"));
            }
        }
    }

    @Override
    public String execute() throws Exception {
        Usuarios u = comprobarUsuario(email, password);
        if (u != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            session.put("usuario", u);
            List<Productos> carrito = new ArrayList();
            session.put("carrito", carrito);
            Map request = (Map) ActionContext.getContext().get("request");
            request.put("error", false);
            return SUCCESS;
        } else {
            Map request = (Map) ActionContext.getContext().get("request");
            request.put("error", true);
            return ERROR;
        }
    }

    public String logout() {
        Map session = (Map) ActionContext.getContext().get("session");
        session.clear();
        return SUCCESS;
    }

}
