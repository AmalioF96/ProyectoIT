package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import modelo.Productos;
import modelo.Usuarios;
import modelo.Valoraciones;
import modelo.ValoracionesId;

/**
 *
 * @author marwi
 */
public class AccionValoraciones extends ActionSupport {

    private Integer idProducto;
    private String valoracion;
    private Integer puntuacion;
    private String operacion;

    public AccionValoraciones() {
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void validate() {
        if (this.getOperacion() != null && this.getOperacion().equals("insertar")) {
            if (this.getPuntuacion() == null) {
                addFieldError("puntuacion", ERROR);
            } else if (this.getPuntuacion() < 1 || this.getPuntuacion() > 5) {
                addFieldError("puntuacion", ERROR);
            }
            if (this.getValoracion() == null || this.getValoracion().trim().length() < 1) {
                addFieldError("valoracion", ERROR);
            }
        }
        if (this.getIdProducto() == null) {
            addFieldError("idProducto", ERROR);
        }
    }

    public String insertar() {

        String salida = ERROR;

        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");

        ValoracionesId vid = new ValoracionesId();
        vid.setIdProducto(this.getIdProducto());
        vid.setEmailCliente(u.getEmail());

        Valoraciones v = new Valoraciones();
        v.setDescripcion(this.getValoracion());
        v.setPuntuacion(this.getPuntuacion());
        v.setId(vid);

        if (modelo.DAO.ValoracionDAO.insertarValoracion(v)) {
            salida = SUCCESS;
        }

        return salida;
    }

    public String modificar() {

        String salida = ERROR;

        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");

        ValoracionesId vid = new ValoracionesId();
        vid.setIdProducto(this.getIdProducto());
        vid.setEmailCliente(u.getEmail());

        Valoraciones v = new Valoraciones();
        v.setDescripcion(this.getValoracion());
        v.setPuntuacion(this.getPuntuacion());
        v.setFecha(new Date());
        v.setId(vid);

        if (modelo.DAO.ValoracionDAO.modificarValoracion(v)) {
            salida = SUCCESS;
        }

        return salida;
    }

    public String eliminar() {

        String salida = ERROR;

        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");

        Productos p = new Productos();
        p.setIdProducto(this.getIdProducto());

        ValoracionesId vid = new ValoracionesId();
        vid.setIdProducto(this.getIdProducto());
        vid.setEmailCliente(u.getEmail());

        if(modelo.DAO.ValoracionDAO.eliminarValoracion(vid)){
            salida=SUCCESS;
        }

        return salida;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public String getValoracion() {
        return valoracion;
    }

    public void setValoracion(String valoracion) {
        this.valoracion = valoracion;
    }

    public Integer getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(Integer puntuacion) {
        this.puntuacion = puntuacion;
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

}
