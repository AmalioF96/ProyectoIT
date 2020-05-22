package controlador.ventas;

import com.google.gson.Gson;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
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
                    addActionError("ERROR: La cantidad debe ser mayor un número.");
                }
            }
        } else {
            addActionError("La cantidad no puede estar vacía.");
        }

    }

    @Override
    public String execute() throws Exception {
        Map session = (Map) ActionContext.getContext().get("session");
        carrito = (List<Productos>) session.get("carrito");
        session.put("cantidad", this.getCantidad());
        /*
        PRUEBA PARA CONSTRUIR JSON
        ArrayList compra = new ArrayList();
        int[] numbers = {1, 2, 3, 4};
        Gson gson = new Gson();
        String numbersJson = gson.toJson(numbers);
         */
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
}
