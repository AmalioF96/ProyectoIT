package controlador.usuarios;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import modelo.DAO.UsuarioDAO;
import modelo.Productos;
import modelo.Usuarios;
import modelo.util.PasswordAuthentication;

/**
 *
 * @author Propietario
 */
public class AccionSignUp extends ActionSupport {

    private String usuario;
    private String email;
    private String password;
    private String passwordConfirm;
    private boolean vendedor;
    private Integer idProducto;

    public AccionSignUp() {
    }

    @Override
    public void validate() {
        String patronEmail = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
        Pattern patron = Pattern.compile(patronEmail);
        Matcher matcher = patron.matcher(this.getEmail());

        if (this.getUsuario().equals("")) {
            addFieldError("usuario", "El nombre de usuario es obligatorio");
        } else if (this.getUsuario().length() < 4) {
            addFieldError("usuario", "El nombre de usuario debe tener 4 o más caracteres");
        }

        if (this.getPassword().equals("")) {
            addFieldError("password", "La contraseña es obligatoria");
        } else if (this.getPassword().length() < 8) {
            addFieldError("password", "La contraseña debe tener un mínimo de 8 caractares");
        }

        if (this.getPasswordConfirm().equals("")) {
            addFieldError("passwordConfirm", "La contraseña es obligatoria");
        } else if (this.getPasswordConfirm().length() < 8) {
            addFieldError("passwordConfirm", "La contraseña debe tener un mínimo de 8 caractares");
        }

        if (!this.getPassword().equals(this.getPasswordConfirm())) {
            addFieldError("passwordConfirm", "las contraseñas no coinciden");
        }
        if (this.getEmail().equals("")) {
            addFieldError("email", "El email es obligatorio");
        } else if (!matcher.matches()) {
            addFieldError("email", "El formato del email no es correcto");
        }
    }

    public String execute() throws Exception {
        String salida = SUCCESS;
        String tipo;
        if (this.isVendedor()) {
            tipo = "vendedor";
        } else {
            tipo = "cliente";
        }
        PasswordAuthentication pa = new PasswordAuthentication();
        String passHash = pa.hash(this.getPassword().toCharArray());
        Usuarios newUser = new Usuarios(this.getEmail(), this.getUsuario(), passHash, "/upomm/imagenes/defaultProfile.png", tipo);
        if (UsuarioDAO.existeEmail(this.getEmail())) {
            addFieldError("email", "Ya existe un usuario asociado al Email");
            salida = ERROR;
        } else {
            if (UsuarioDAO.existeNombre(this.getUsuario())) {
                addFieldError("usuario", "Ya existe un usuario asociado al nombre");
                salida = ERROR;
            } else {
                UsuarioDAO.creaUsuario(newUser);
                Map session = (Map) ActionContext.getContext().get("session");
                session.put("usuario", newUser);
                List<Productos> carrito = new ArrayList();
                session.put("carrito", carrito);
                Map request = (Map) ActionContext.getContext().get("request");
                request.put("error", false);
                if (this.getIdProducto() != null && this.getIdProducto() > 0) {
                    salida = "producto";
                }
            }
        }
        return salida;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password.trim();
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

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

}
