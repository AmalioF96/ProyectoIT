package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;
import modelo.CaracteristicasProductos;
import modelo.CategoriasProductos;
import modelo.Productos;
import modelo.Valoraciones;

/**
 *
 * @author marwi
 */
public class AccionProductos extends ActionSupport {

    private List<Productos> productos = null;
    private Map<Integer, Float> puntuaciones;
    private Integer id;
    private Productos producto = null;
    private String origin = null;
    //private boolean estaEnCarrito = false;

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
        ActionContext.getContext().setLocale(Locale.US);
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

    public String seleccionarProducto() {

        String salida = ERROR;

        Productos p = modelo.DAO.ProductoDAO.obtenerProducto(id);
        
        if (p != null) {
            this.producto = p;
            Set<CategoriasProductos> s1 = p.getCategoriasProductoses();
            SortedSet ss1 = new TreeSet((Set) s1);
            p.setCategoriasProductoses(ss1);
            
            Set<CaracteristicasProductos> s2 = p.getCaracteristicasProductoses();
            SortedSet ss2 = new TreeSet((Set) s2);
            p.setCaracteristicasProductoses(ss2);
            
            Set<CaracteristicasProductos> s3 = p.getValoracioneses();
            SortedSet ss3 = new TreeSet((Set) s3);
            p.setValoracioneses(ss3);
            
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

        }
        ActionContext.getContext().setLocale(Locale.US);
        return salida;
    }

    public String agregarCarrito() {

        String salida = ERROR;
        
        if (this.getId() != null) {
            System.out.println(this.getId());
            Productos p = modelo.DAO.ProductoDAO.obtenerProducto(this.getId());
            
            if (p != null) {
                Map session = (Map) ActionContext.getContext().get("session");
                List<Productos> carrito = (List<Productos>) session.get("carrito");
                
                if (carrito == null) {
                    carrito = new ArrayList();
                    session.put("carrito", carrito);
                }
                carrito.add(p);
                salida = SUCCESS;
            }
        }
        return salida;
    }

    public String eliminarCarrito() {

        String salida = ERROR;
        
        if (this.getId() != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            List<Productos> carrito = (List<Productos>) session.get("carrito");
            Productos p = new Productos();
            p.setIdProducto(this.getId());
            
            if (carrito.remove(p)) {
                if(origin!=null && origin.equals("carrito")){
                    salida = "carrito";
                }else{
                    salida=SUCCESS;
                }
            }
        }

        return salida;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

}
