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

    private List<Productos> compra = null;

    @Override
    public void validate() {
        Map session = (Map) ActionContext.getContext().get("session");
        List<Productos> carrito = (List<Productos>) session.get("carrito");
        Map<Integer, Integer> cantidades = (Map) session.get("cantidad");

        if (carrito == null || cantidades == null) {
            addFieldError("", ERROR);
            addActionError("ERROR: no se pudo registrar la venta");
        } else if (carrito.size() != cantidades.size()) {
            addFieldError("", ERROR);
            addActionError("ERROR: no se pudo registrar la venta");
        }
    }

    @Override
    public String execute() {
        Map session = (Map) ActionContext.getContext().get("session");
        List<Productos> carrito = (List<Productos>) session.get("carrito");
        Map<Integer, Integer> cantidades = (Map) session.get("cantidad");

        //Variable de salida
        String salida = SUCCESS;
        //Declaracion de variables
        Usuarios u = (Usuarios) session.get("usuario");
        Compras c = new Compras();
        LineasDeCompraId ldcid = new LineasDeCompraId();
        //Seteamos atributos a compra
        c.setUsuarios(u);
        //Guardamos Compra
        c.setIdCompra(modelo.DAO.VentasDAO.insertarCompra(c));

        //Creamos lineas de compra
        for (int i = 0; i < carrito.size(); i++) {
            LineasDeCompra ldc = new LineasDeCompra();
            Productos p = carrito.get(i);
            int cantidad = cantidades.get(p.getIdProducto());
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
            session.put("cantidad", null);
            Usuarios usuario = (Usuarios) session.get("usuario");
            usuario.getComprases().add(c);
            this.setCompra(new ArrayList(carrito));
        } else {
            addActionError("ERROR: se ha podido registrar la compra.");
        }

        return salida;
    }
    
    public List<Productos> getCompra() {
        return compra;
    }

    public void setCompra(List<Productos> compra) {
        this.compra = compra;
    }
}
