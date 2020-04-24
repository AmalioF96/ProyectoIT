package controlador.productos;

import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import modelo.Categorias;

/**
 *
 * @author marwi
 */
public class AccionCategorias extends ActionSupport {

    private List<Categorias> categorias = null;
    private String origin = null;

    public AccionCategorias() {
    }

    public List<Categorias> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<Categorias> categorias) {
        this.categorias = categorias;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String listar() {
        String salida = SUCCESS;
        List<Categorias> listaCategorias = modelo.DAO.CategoriaDAO.listarCategorias();
        setCategorias(listaCategorias);
        if (origin != null && origin.equals("crearProducto")) {
            salida = "crearProducto";
        }
        return salida;
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
