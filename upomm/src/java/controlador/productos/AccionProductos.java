package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.transaction.Transactional;
import modelo.Productos;
import modelo.Valoraciones;

/**
 *
 * @author marwi
 */
public class AccionProductos extends ActionSupport {

    private List<Productos> productos = null;
    private Map<Integer, Float> puntuaciones;
    private int id;
    private Productos producto = null;
    private boolean estaEnCarrito = false;

    public AccionProductos() {
        this.puntuaciones = new HashMap();
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String listar() {
        List<Productos> lp = modelo.DAO.ProductoDAO.listarProductos();
        if (lp != null && !lp.isEmpty()) {
            Iterator<Productos> it = lp.iterator();
            while (it.hasNext()) {
                Productos p = it.next();
                int id = p.getIdProducto();
                Set<Valoraciones> lv = p.getValoracioneses();
                float puntuacion = 0;
                if (lv != null && !lv.isEmpty()) {
                    Iterator<Valoraciones> it2 = lv.iterator();
                    while (it2.hasNext()) {
                        puntuacion += it2.next().getPuntuacion();
                    }
                    puntuacion /= lv.size();
                }
                puntuaciones.put(id, puntuacion);

            }
        }
        setProductos(lp);
        return SUCCESS;
    }

    public List<Productos> getProductos() {
        return productos;
    }

    public void setProductos(List<Productos> productos) {
        this.productos = productos;
    }

    public Map getPuntuaciones() {
        return puntuaciones;
    }

    public void setPuntuaciones(Map puntuaciones) {
        this.puntuaciones = puntuaciones;
    }
    @Transactional
    public String seleccionarProducto() {

        String salida = ERROR;

        Productos p = modelo.DAO.ProductoDAO.obtenerProducto(id);
        if (p != null) {
            this.producto = p;
            salida = SUCCESS;

            Set<Valoraciones> lv = p.getValoracioneses();
            float puntuacion = 0;
            if (lv != null && !lv.isEmpty()) {
                Iterator<Valoraciones> it2 = lv.iterator();
                while (it2.hasNext()) {
                    puntuacion += it2.next().getPuntuacion();
                }
                puntuacion /= lv.size();
            }
            puntuaciones.put(id, puntuacion);

            Map session = (Map) ActionContext.getContext().get("session");
            List<Productos> carrito = (List<Productos>) session.get("carrito");
            if (carrito != null && carrito.contains(p)) {
                this.estaEnCarrito = true;
            } else {
                this.estaEnCarrito = false;
            }
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
