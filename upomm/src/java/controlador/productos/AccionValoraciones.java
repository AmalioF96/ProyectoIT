package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
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

    public AccionValoraciones() {
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String insertar() {
        
        String salida = ERROR;

        if (this.getIdProducto() != null && this.getValoracion() != null && this.getPuntuacion() != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            Usuarios u = (Usuarios) session.get("usuario");
            
            ValoracionesId vid = new ValoracionesId();
            vid.setIdProducto(this.getIdProducto());
            vid.setEmailCliente(u.getEmail());
            
            Valoraciones v = new Valoraciones();
            v.setDescripcion(this.getValoracion());
            v.setPuntuacion(this.getPuntuacion());
            v.setId(vid);
            
            if(modelo.DAO.ValoracionDAO.insertarValoracion(v) != null){
                salida = SUCCESS;
            }
        }
        
        return salida;
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
    
    

}
