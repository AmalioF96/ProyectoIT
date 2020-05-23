package controlador.ventas;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import java.util.Map;
import modelo.Productos;

/**
 *
 * @author Amalio
 */
public class AccionCarrito extends ActionSupport {

    List<String> cantidad = null;
    List<Productos> carrito = null;
    String items = null;

    @Override
    public void validate() {
        if (this.getCantidad() != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            carrito = (List<Productos>) session.get("carrito");

            if (this.carrito.size() != this.cantidad.size()) {
                addActionError("ERROR: Faltan elementos del carrito.");
            }

            for (String c : cantidad) {
                try {
                    int x = Integer.parseInt(c);
                    if (x <= 0) {
                        addActionError("ERROR: La cantidad debe ser mayor que cero.");
                    }
                } catch (Exception e) {
                    addActionError("ERROR: La cantidad debe ser un número.");
                }
            }
        } else {
            addActionError("La cantidad no puede estar vacía.");
        }

    }

    @Override
    public String execute() throws Exception {
        Map session = (Map) ActionContext.getContext().get("session");
       this.setCarrito((List<Productos>) session.get("carrito"));
        session.put("cantidad", this.getCantidad());
        
        String items = "[";
        for(int i = 0; i< this.getCarrito().size(); i++){
            items += "{name: '"+this.getCarrito().get(i).getNombre()+"', description: '"+this.getCarrito().get(i).getDescripcion()+"', sku: 'id-"+this.getCarrito().get(i).getIdProducto()+"', unit_amount: {currency_code: 'EUR', value: '"+this.getCarrito().get(i).getPrecio()+"'}, quantity: '"+this.getCantidad().get(i)+"'},";
        }
        items += "]";
        this.setItems(items);
        
        return SUCCESS;
    }

    public List<String> getCantidad() {
        return cantidad;
    }

    public void setCantidad(List<String> cantidad) {
        this.cantidad = cantidad;
    }

    public List<Productos> getCarrito() {
        return carrito;
    }

    public void setCarrito(List<Productos> carrito) {
        this.carrito = carrito;
    }

    public String getItems() {
        return items;
    }

    public void setItems(String items) {
        this.items = items;
    }
}
