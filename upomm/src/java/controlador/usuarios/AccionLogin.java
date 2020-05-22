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

    private String email;
    private String password;
    private Integer idProducto;

    public AccionLogin() {
    }

    @Override
    public void validate() {
        if (this.getEmail() != null && this.getPassword() != null) {
            if (this.getEmail().trim().length() < 1) {
                addFieldError("email", getText("Este campo es obligatorio"));
            }

            if (this.getPassword().trim().length() < 1) {
                addFieldError("password", getText("Este campo es obligatorio"));
            }
        }
    }

    @Override
    public String execute() throws Exception {
        Usuarios u = comprobarUsuario(email, password);
        String salida = ERROR;
        if (u != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            session.put("usuario", u);
            List<Productos> carrito = new ArrayList();
            session.put("carrito", carrito);
            Map request = (Map) ActionContext.getContext().get("request");
            request.put("error", false);
            if(this.getIdProducto() != null && this.getIdProducto() > 0) {
                salida = "producto";
            }else {
            salida = SUCCESS;
            }
        } else {
            addActionError("Las credenciales introducidas no son válidas");
        }
        return salida;
    }

    public String logout() {
        Map session = (Map) ActionContext.getContext().get("session");
        session.clear();
        return SUCCESS;
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

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }


    

}
