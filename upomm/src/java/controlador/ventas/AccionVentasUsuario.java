package controlador.ventas;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import modelo.Compras;
import modelo.LineasDeCompra;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionVentasUsuario extends ActionSupport {

    private List<Compras> listaVentas = null;
    private List<LineasDeCompra> venta = null;
    private Integer idVenta = null;

    public AccionVentasUsuario() {
    }

    public String listarVentas() {
        String salida = SUCCESS;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        this.listaVentas = modelo.DAO.VentasDAO.listarVentas(user.getEmail());

        if (listaVentas.size() <= 0) {
            this.listaVentas = new ArrayList();
        }

        return salida;
    }

    public String seleccionarVenta() {
        String salida = ERROR;

        if (this.getIdVenta() != null) {
            Map session = (Map) ActionContext.getContext().get("session");
            Usuarios user = (Usuarios) session.get("usuario");
            List<LineasDeCompra> ldc = modelo.DAO.VentasDAO.obtenerVenta(this.getIdVenta(), user.getEmail());
            if (ldc != null) {
                this.setVenta(ldc);
                salida = SUCCESS;
            }
        }
        return salida;
    }

    public List<Compras> getListaVentas() {
        return listaVentas;
    }

    public void setListaVentas(List<Compras> listaVentas) {
        this.listaVentas = listaVentas;
    }

    public List<LineasDeCompra> getVenta() {
        return venta;
    }

    public void setVenta(List<LineasDeCompra> venta) {
        this.venta = venta;
    }

    public Integer getIdVenta() {
        return this.idVenta;
    }

    public void setIdVenta(Integer idCompra) {
        this.idVenta = idCompra;
    }

}
