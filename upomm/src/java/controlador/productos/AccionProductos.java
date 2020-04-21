package controlador.productos;

import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import modelo.Productos;

/**
 *
 * @author marwi
 */
public class AccionProductos extends ActionSupport {
    private List<Productos> productos = null;
    
    public AccionProductos() {
    }
    
    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    public String listar() {
        List<Productos> listaProductos = modelo.DAO.ProductoDAO.listarProductos();
        setProductos(listaProductos);
        return SUCCESS;
    }

    public List<Productos> getProductos() {
        return productos;
    }

    public void setProductos(List<Productos> productos) {
        this.productos = productos;
    }
    
    
    
}
