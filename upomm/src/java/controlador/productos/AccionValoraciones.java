package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;
import modelo.Productos;
import modelo.Usuarios;
import modelo.ValoracionesId;

/**
 *
 * @author marwi
 */
public class AccionValoraciones extends ActionSupport {

    private Integer idProducto;

    public AccionValoraciones() {
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String eliminar() {

        String salida = ERROR;

        if (this.getIdProducto() != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            Usuarios u = (Usuarios) session.get("usuario");

            Productos p = new Productos();
            p.setIdProducto(this.getIdProducto());

            ValoracionesId vid = new ValoracionesId();
            vid.setIdProducto(this.getIdProducto());
            vid.setEmailCliente(u.getEmail());
            
            modelo.DAO.ValoracionDAO.eliminarValoracion(vid);

            salida = SUCCESS;
        }

        return salida;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

}
