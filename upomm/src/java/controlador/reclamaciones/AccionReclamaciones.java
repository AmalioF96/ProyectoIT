package controlador.reclamaciones;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import java.util.Map;
import modelo.Reclamaciones;
import modelo.ReclamacionesId;
import modelo.Usuarios;

/**
 *
 * @author marwi
 */
public class AccionReclamaciones extends ActionSupport {

    private Integer idCompra;
    private Integer idProducto;
    private String descripcion;
    private String estado;
    private String operacion;
    private List<Reclamaciones> listaReclamaciones = null;

    public AccionReclamaciones() {
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void validate() {
        if (this.getOperacion() != null && this.getOperacion().equals("insertar")) {
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
                addActionError("ERROR: los datos introducidos no son válidos.");
            }
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
        if (salida.equals(SUCCESS)) {
            addActionMessage("Se ha creado la reclamación.");
        } else {
            addActionError("ERROR: no se pudo crear la reclamación.");
        }
        return salida;
    }

    public String listarCliente() {
        String salida = ERROR;

        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");
        this.setListaReclamaciones(modelo.DAO.ReclamacionDAO.listarReclamacionesCliente(u));

        if (this.getListaReclamaciones() != null) {
            salida = SUCCESS;
        }

        return salida;
    }

    public String listarVendedor() {
        String salida = ERROR;

        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");
        this.setListaReclamaciones(modelo.DAO.ReclamacionDAO.listarReclamacionesVendedor(u));

        if (this.getListaReclamaciones() != null) {
            salida = SUCCESS;
        }

        return salida;
    }

    public String modificar() {
        String salida = ERROR;
        if (this.getIdCompra() != null && this.getIdProducto() != null) {
            ReclamacionesId rid = new ReclamacionesId(this.getIdCompra(), this.getIdProducto());
            if (this.getOperacion() != null && this.getOperacion().equals("aceptar")) {
                modelo.DAO.ReclamacionDAO.modificarReclamacion(rid, "resuelta");
                salida = SUCCESS;
            } else if (this.getOperacion() != null && this.getOperacion().equals("rechazar")) {
                modelo.DAO.ReclamacionDAO.modificarReclamacion(rid, "disputa");
                salida = SUCCESS;
            }
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

    public List<Reclamaciones> getListaReclamaciones() {
        return listaReclamaciones;
    }

    public void setListaReclamaciones(List<Reclamaciones> listaReclamaciones) {
        this.listaReclamaciones = listaReclamaciones;
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }
}
