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

    public AccionCategorias() {
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String listar() {
        List<Categorias> listaCategorias = modelo.DAO.CategoriaDAO.listarCategorias();
        setCategorias(listaCategorias);
        return SUCCESS;
    }

    public List<Categorias> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<Categorias> categorias) {
        this.categorias = categorias;
    }
}
