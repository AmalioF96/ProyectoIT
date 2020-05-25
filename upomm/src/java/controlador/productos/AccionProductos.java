package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import modelo.Productos;
import modelo.Usuarios;
import modelo.Valoraciones;

/**
 *
 * @author marwi
 */
public class AccionProductos extends ActionSupport {

    private List<Productos> productos;
    private Map<Integer, Float> puntuaciones;
    private Integer idProducto;
    private Productos producto;
    private String origin;
    private String categoria;
    private String busqueda;
    private String recurso;
    private String time;

    public AccionProductos() {
        this.puntuaciones = new HashMap();
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String listar() {
        List<Productos> lp = null;
        if ((this.getCategoria() == null || this.getCategoria().trim().length() < 1) && (this.getBusqueda() == null || this.getBusqueda().trim().length() < 1)) {
            lp = modelo.DAO.ProductoDAO.listarProductos();
        } else if (this.getCategoria() != null && this.getCategoria().trim().length() > 0 && this.getBusqueda() != null && this.getBusqueda().trim().length() > 0) {
            lp = modelo.DAO.ProductoDAO.buscarProductosPorCategoria(this.getBusqueda(), this.getCategoria());
        } else if (this.getBusqueda() != null && this.getBusqueda().trim().length() > 0) {
            lp = modelo.DAO.ProductoDAO.buscarProductos(this.getBusqueda());
        } else {
            lp = modelo.DAO.ProductoDAO.listarProductosPorCategoria(this.getCategoria());
        }

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

    public String seleccionarProducto() {

        String salida = ERROR;
        if (this.getIdProducto() != null) {
            if (this.getOrigin() != null && this.getOrigin().equals("crearProducto")) {
                Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getIdProducto());
                if (p != null) {
                    this.setProducto(p);
                    salida = "editar";
                }
            } else {
                Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getIdProducto());

                if (p != null) {
                    this.producto = p;

                    Set<Valoraciones> lv = p.getValoracioneses();
                    float puntuacion = 0;

                    if (lv != null && !lv.isEmpty()) {
                        Iterator<Valoraciones> it2 = lv.iterator();
                        while (it2.hasNext()) {
                            puntuacion += it2.next().getPuntuacion();
                        }
                        puntuacion /= lv.size();
                    }
                    puntuaciones.put(idProducto, puntuacion);
                    salida = SUCCESS;
                } else {
                    Map request = (Map) ActionContext.getContext().get("request");
                    request.put("error", true);
                    this.setIdProducto(null);
                }
            }
        }
        return salida;
    }

    public String agregarCarrito() {

        String salida = ERROR;

        if (this.getIdProducto() != null) {
            System.out.println(this.getIdProducto());

            Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getIdProducto());

            if (p != null) {
                Map session = (Map) ActionContext.getContext().get("session");
                List<Productos> carrito = (List<Productos>) session.get("carrito");

                if (carrito == null) {
                    carrito = new ArrayList();
                    session.put("carrito", carrito);
                }
                if (!carrito.contains(p)) {
                    carrito.add(p);
                }
                if (this.origin != null && this.origin.equals("deseos")) {
                    salida = "deseos";
                } else {
                    salida = SUCCESS;
                }
            }
        }
        return salida;
    }

    public String eliminarCarrito() {

        String salida = ERROR;
        if (this.getIdProducto() != null) {

            Map session = (Map) ActionContext.getContext().get("session");
            List<Productos> carrito = (List<Productos>) session.get("carrito");
            Map<Integer, Integer> cantidad = (Map) session.get("cantidad");
            Productos p = new Productos();
            p.setIdProducto(this.getIdProducto());

            if (carrito.remove(p)) {
                if (cantidad != null && cantidad.containsKey(p.getIdProducto())) {
                    cantidad.remove(p.getIdProducto());
                }
                if (origin != null && origin.equals("carrito")) {
                    salida = "carrito";
                } else if (this.origin != null && this.origin.equals("deseos")) {
                    salida = "deseos";
                } else {
                    salida = SUCCESS;
                }
            }
        }

        return salida;
    }

    public String retirar() {
        String salida = ERROR;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios u = (Usuarios) session.get("usuario");

        if (this.getIdProducto() != null && u.getTipo().equals("admin")) {
            Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getIdProducto());
            p.setDisponible(false);
            if (modelo.DAO.ProductoDAO.actualizaProducto(p)) {
                salida = SUCCESS;
            }
        }

        return salida;
    }

    public String descargar() {
        String salida = ERROR;
        if (this.getIdProducto() != null && this.getTime() != null) {
            long t = Long.parseLong(this.getTime());
            Date d = new Date();
            long current = d.getTime();
            if ((current - t) < 1800000) {
                Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getIdProducto());
                if (p != null) {
                    this.setRecurso("enlace");
                    salida = SUCCESS;
                }
            }
        }
        return salida;
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

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        try {
            this.idProducto = idProducto;
        } catch (Exception e) {
        }
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getOrigin() {
        return origin;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getBusqueda() {
        return busqueda;
    }

    public void setBusqueda(String busqueda) {
        this.busqueda = busqueda;
    }

    public String getRecurso() {
        return recurso;
    }

    public void setRecurso(String recurso) {
        this.recurso = recurso;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
