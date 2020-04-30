/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.ventas;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Map;
import modelo.Compras;
import modelo.LineasDeCompra;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionVentasUsuario extends ActionSupport {

    private ArrayList<Object[]> listaVentas = null;
    private LineasDeCompra venta = null;
    private Integer idVenta = null;
    private Integer idProducto = null;

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public AccionVentasUsuario() {
    }

    public String listarVentas() {
        String salida = SUCCESS;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        this.listaVentas = (ArrayList<Object[]>) modelo.DAO.VentasDAO.listarVentas(user.getEmail());

        if (listaVentas.size() <= 0) {
            this.listaVentas = new ArrayList<Object[]>();
        }

        return salida;
    }

    public String seleccionarVenta() {
        String salida = ERROR;

        if (this.getIdVenta() != null) {
            LineasDeCompra c = modelo.DAO.VentasDAO.obtenerVenta(this.getIdVenta(), this.getIdProducto());
            if (c != null) {
                this.setVenta(c);
                salida = SUCCESS;
            }
        }
        return salida;
    }

    public ArrayList<Object[]> getListaVentas() {
        return listaVentas;
    }

    public void setListaVentas(ArrayList<Object[]> listaVentas) {
        this.listaVentas = listaVentas;
    }

    public LineasDeCompra getVenta() {
        return venta;
    }

    public void setVenta(LineasDeCompra venta) {
        this.venta = venta;
    }

    public Integer getIdVenta() {
        return this.idVenta;
    }

    public void setIdVenta(Integer idCompra) {
        this.idVenta = idCompra;
    }

}
