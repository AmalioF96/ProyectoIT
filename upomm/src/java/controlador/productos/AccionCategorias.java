package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.I18nInterceptor;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import modelo.Categorias;

public class AccionCategorias extends ActionSupport {

    private List<Categorias> categorias = null;
    private String categoria;
    private String nuevaCategoria;
    private String origin;
    private String operacion;

    public String listar() {
        Map session = (Map) ActionContext.getContext().get("session");
        Locale l = new Locale("de", "DE");
        ActionContext.getContext().setLocale(l);
        session.put(I18nInterceptor.DEFAULT_SESSION_ATTRIBUTE, l);
        String salida = SUCCESS;
        List<Categorias> listaCategorias = modelo.DAO.CategoriaDAO.listarCategorias();
        setCategorias(listaCategorias);
        if (this.getOrigin() != null && this.getOrigin().equals("crearProducto")) {
            salida = "crearProducto";
        } else if (this.getOrigin() != null && this.getOrigin().equals("crearCategoria")) {
            salida = "crearCategoria";
        }
        return salida;
    }

    public void validate() {
        if (this.getOperacion() != null) {
            if (this.getOperacion().equals("eliminar")) {
                if (this.getCategoria() == null || this.getCategoria().trim().equals("")) {
                    addFieldError("categoria", "Debe seleccionar una categoría");
                }
            } else if (this.getOperacion().equals("crear")) {
                if (this.getNuevaCategoria() == null || this.getNuevaCategoria().trim().equals("")) {
                    addFieldError("nuevaCategoria", "El nombre de la categoría no puede estar vacío");
                }
            }
            listar();
        }
    }

    public String eliminar() {
        String salida = ERROR;

        if (this.getOperacion() != null && this.getOperacion().equals("eliminar")) {
            Categorias c = new Categorias(this.getCategoria());
            if (modelo.DAO.CategoriaDAO.eliminarCategoria(c)) {
                addActionMessage("Se ha eliminado la categoría -" + this.getCategoria() + "-");
                salida = SUCCESS;
            }
        }
        listar();
        return salida;
    }

    public String crear() {
        String salida = ERROR;

        if (this.getOperacion() != null && this.getOperacion().equals("crear")) {
            Categorias c = new Categorias(this.getNuevaCategoria());
            if (modelo.DAO.CategoriaDAO.crearCategoria(c)) {
                addActionMessage("Se ha creado la categoría -" + this.getNuevaCategoria() + "-");
                salida = SUCCESS;
            }
        }
        listar();
        return salida;
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public List<Categorias> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<Categorias> categorias) {
        this.categorias = categorias;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getNuevaCategoria() {
        return nuevaCategoria;
    }

    public void setNuevaCategoria(String nuevaCategoria) {
        this.nuevaCategoria = nuevaCategoria;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }
}
