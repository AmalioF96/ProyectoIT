package controlador.ventas;

import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import modelo.Compras;
import modelo.LineasDeCompra;
import modelo.LineasDeCompraId;
import modelo.Productos;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionVenta extends ActionSupport {

    private List<String> listaCantidad = null;
    private List<Productos> carrito = null;
    private boolean terminosYCondiciones;

    private float total;

    @Override
    public void validate() {
        Map session = (Map) ActionContext.getContext().get("session");
        this.setCarrito((List<Productos>) session.get("carrito"));
        this.setListaCantidad((List<String>) session.get("cantidad"));

        if (this.getCarrito() == null || this.getListaCantidad() == null) {
            addFieldError("", ERROR);
        }
        if (!this.isTerminosYCondiciones()) {
            addFieldError("terminosYCondiciones", "termsConditions.relleno");
        }

    }

    @Override
    public String execute() {
        System.out.println("===========================================================");
        //Variable de salida
        String salida = ERROR;
        //Recogida de datos
        Map session = (Map) ActionContext.getContext().get("session");
        //Declaracion de variables
        Set<LineasDeCompra> listaldc = new HashSet<>();
        Usuarios u = (Usuarios) session.get("usuario");
        Compras c = new Compras();
        LineasDeCompraId ldcid = new LineasDeCompraId();
        LineasDeCompra ldc;
        for (int i = 0; i < this.getCarrito().size(); i++) {
            ldc = new LineasDeCompra();
            int cantidad = Integer.parseInt(this.getListaCantidad().get(i));
            Productos p = this.getCarrito().get(i);
            ldcid.setIdProducto(p.getIdProducto());
            //ldcid.setIdCompra(c.getIdCompra());

            ldc.setCantidad(cantidad);
            ldc.setCompras(c);
            ldc.setProductos(this.getCarrito().get(i));
            ldc.setId(ldcid);

            listaldc.add(ldc);
        }

        c.setLineasDeCompras(listaldc);
        c.setUsuarios(u);
        c.setFecha(new Date());

        if (modelo.DAO.VentasDAO.insertarCompra(c)) {
            System.out.println("\n\n\n\nID:" + c.getIdCompra() + "\n-\n-\n-\n-\n-");
            salida = SUCCESS;
        }

        return salida;
    }

    public List<String> getListaCantidad() {
        return listaCantidad;
    }

    public void setListaCantidad(List<String> listaCantidad) {
        this.listaCantidad = listaCantidad;
    }

    public List<Productos> getCarrito() {
        return carrito;
    }

    public void setCarrito(List<Productos> carrito) {
        this.carrito = carrito;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public boolean isTerminosYCondiciones() {
        return terminosYCondiciones;
    }

    public void setTerminosYCondiciones(boolean terminosYCondiciones) {
        this.terminosYCondiciones = terminosYCondiciones;
    }
}
