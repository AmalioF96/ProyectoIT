/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.ventas;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import modelo.Compras;

/**
 *
 * @author Amalio
 */
public class AccionVentasUsuario extends ActionSupport {

    private ArrayList<Compras> listaCompras = null;
    private Compras compra = null;
    private Integer idCompra = null;

    public AccionVentasUsuario() {
    }

    public String listarVentas() {
        String salida = SUCCESS;

        this.listaCompras = (ArrayList<Compras>) modelo.DAO.VentasDAO.listarVentas();
        if (listaCompras.size() <= 0) {
            salida = ERROR;
        }

        return salida;
    }

    public ArrayList<Compras> getListaCompras() {
        return listaCompras;
    }

    public void setListaCompras(ArrayList<Compras> listaCompras) {
        this.listaCompras = listaCompras;
    }

    public Compras getCompra() {
        return compra;
    }

    public void setCompra(Compras compra) {
        this.compra = compra;
    }

    public Integer getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(Integer idCompra) {
        this.idCompra = idCompra;
    }

}
