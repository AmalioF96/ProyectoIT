package controlador.usuarios;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Map;
import modelo.DAO.DeseoDAO;
import modelo.Productos;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionListaDeseos extends ActionSupport {

    private Integer idProducto;
    private ArrayList<Productos> deseos = null;
    private String origin;

    public String recogerDeseos() {
        String salida = ERROR;
        Map session = (Map) ActionContext.getContext().get("session");
        //Declaracion de variables
        Usuarios u = (Usuarios) session.get("usuario");

        this.setDeseos(DeseoDAO.listarDeseos(u.getEmail()));
        salida = SUCCESS;

        return salida;
    }

    public String crear() {
        String salida = ERROR;

        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");

        if (this.getIdProducto() != null) {
            Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getIdProducto());
            if (p != null && !u.getProductoses_1().contains(p)) {
                u.getProductoses_1().add(p);
                if (modelo.DAO.UsuarioDAO.actualizaUsuario(u)) {
                    session.remove(u);
                    session.put("usuario", u);
                    salida = SUCCESS;
                }
            }
        }
        return salida;
    }

    public String eliminar() {
        String salida = ERROR;
        boolean eliminado = false;
        Map session = (Map) ActionContext.getContext().get("session");
        //Declaracion de variables
        Usuarios u = (Usuarios) session.get("usuario");
        if (this.getIdProducto() != null) {
            Productos p = new Productos();
            p.setIdProducto(this.getIdProducto());
            if (u.getProductoses_1().remove(p)) {
                if (modelo.DAO.UsuarioDAO.actualizaUsuario(u)) {
                    session.remove(u);
                    session.put("usuario", u);
                    if (this.getOrigin() != null && this.origin.equals("producto")) {
                        salida = "producto";
                    } else {
                        salida = SUCCESS;
                    }
                }
            }

        }
        return salida;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public ArrayList<Productos> getDeseos() {
        return deseos;
    }

    public void setDeseos(ArrayList<Productos> deseos) {
        this.deseos = deseos;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }
}
