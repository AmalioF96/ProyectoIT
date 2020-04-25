/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.ventas;

import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static modelo.DAO.UsuarioDAO.comprobarUsuario;
import modelo.Productos;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionCarrito extends ActionSupport {

    List<String> cantidad = null;
    List<Productos> carrito = null;

    public AccionCarrito() {
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

    @Override
    public void validate() {
        if (this.getCantidad() != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            carrito = (List<Productos>) session.get("carrito");

            if (this.carrito.size() != this.cantidad.size()) {
                addFieldError("cabtidad", getText("cantidad.faltanElementos"));
            }

            for (String c : cantidad) {
                try {
                    int x = Integer.parseInt(c);
                    if (x <= 0) {
                        addFieldError("cantidad", getText("cantidad.mayoQueCero"));
                    }
                } catch (Exception e) {
                    addFieldError("cantidad", getText("cantidad.debeSerNumerico"));
                }
            }
        } else {
            addFieldError("cantidad", getText("cantidad.vacia"));
        }

    }

    @Override
    public String execute() throws Exception {
        Map session = (Map) ActionContext.getContext().get("session");
        carrito = (List<Productos>) session.get("carrito");
        session.put("cantidad", this.getCantidad());
        
        return SUCCESS;
    }
}
