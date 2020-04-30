package controlador.reclamaciones;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;
import modelo.Reclamaciones;
import modelo.ReclamacionesId;

/**
 *
 * @author marwi
 */
public class AccionReclamaciones extends ActionSupport {

    private Integer idCompra;
    private Integer idProducto;
    private String descripcion;
    private String estado;

    public AccionReclamaciones() {
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void validate() {
        boolean errores = false;
        if (this.getIdCompra() == null) {
            addFieldError("idCompra", ERROR);
            errores = true;
        }
        if (this.getIdProducto() == null) {
            addFieldError("idProducto", ERROR);
            errores = true;
        }
        if (this.getDescripcion() == null || this.getDescripcion().length() <= 0) {
            addFieldError("descripcion", ERROR);
            errores = true;
        }
        if (errores) {
            Map request = (Map) ActionContext.getContext().get("request");
            request.put("error", true);
        }
    }

    public String crear() {
        String salida = ERROR;
        ReclamacionesId rid = new ReclamacionesId();
        rid.setIdCompra(this.getIdCompra());
        rid.setIdProducto(this.getIdProducto());

        Reclamaciones r = new Reclamaciones();
        r.setId(rid);
        r.setDescripcion(this.getDescripcion());
        r.setEstado("creada");
        if (modelo.DAO.ReclamacionDAO.crearReclamacion(r)) {
            salida = SUCCESS;
        }
        Map request = (Map) ActionContext.getContext().get("request");
        if (salida.equals(SUCCESS)) {
            request.put("error", false);
        } else {
            request.put("error", true);
        }
        return salida;
    }

    public Integer getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(Integer idCompra) {
        this.idCompra = idCompra;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

}
