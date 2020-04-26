package controlador.ventas;

import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import modelo.Compras;
import static modelo.DAO.VentasDAO.insertarLineaDeCompra;
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
        //Variable de salida
        String salida = SUCCESS;
        //Recogida de datos
        Map session = (Map) ActionContext.getContext().get("session");
        //Declaracion de variables
        Usuarios u = (Usuarios) session.get("usuario");
        Compras c = new Compras();
        LineasDeCompraId ldcid = new LineasDeCompraId();
        LineasDeCompra ldc;
        //Seteamos atributos a compra
        c.setUsuarios(u);
        //Guardamos Compra
        c.setIdCompra(modelo.DAO.VentasDAO.insertarCompra(c));

        //Creamos lineas de compra
        for (int i = 0; i < this.getCarrito().size(); i++) {
            ldc = new LineasDeCompra();
            int cantidad = Integer.parseInt(this.getListaCantidad().get(i));
            Productos p = this.getCarrito().get(i);
            ldcid.setIdProducto(p.getIdProducto());
            ldcid.setIdCompra(c.getIdCompra());

            ldc.setCantidad(cantidad);
            ldc.setCompras(c);
            ldc.setProductos(p);
            ldc.setId(ldcid);

            //Guardamos lineas de compra
            if (!insertarLineaDeCompra(ldc)) {
                salida = ERROR;
            }
            c.getLineasDeCompras().add(ldc);
        }
        if (salida.equals(SUCCESS)) {
            session.put("carrito", new ArrayList());
        }
        Usuarios usuario = (Usuarios) session.get("usuario");
        usuario.getComprases().add(c);
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
