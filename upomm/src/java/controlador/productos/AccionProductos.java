package controlador.productos;

import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import modelo.Productos;

/**
 *
 * @author marwi
 */
public class AccionProductos extends ActionSupport {
    private int id;
    private List<Productos> productos = null;
    private Productos producto = null;

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

    public String seleccionarProducto() {

        String salida = ERROR;
        int i = 0;
        while (i < productos.size() && salida.equals(ERROR)) {
            if (this.productos.get(i).getIdProducto() == this.id) {
                this.producto = this.productos.get(i);
                salida = SUCCESS;
            }
            i++;
        }

        return salida;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }
}
