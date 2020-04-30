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
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionVentasUsuario extends ActionSupport {

    private ArrayList<Object> listaCompras = null;
    private Compras compra = null;
    private Integer idCompra = null;

    public AccionVentasUsuario() {
    }

    public String listarVentas() {
        String salida = SUCCESS;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        this.listaCompras = (ArrayList<Object>) modelo.DAO.VentasDAO.listarVentas(user.getEmail());
        System.out.println("\n\n\nLISTAAAAAA");
        for (Object l : listaCompras) {
            System.out.println(l);
            System.out.println(l.toString());
        }
        System.out.println("\n\n\n");
        if (listaCompras.size() <= 0) {
            salida = ERROR;
        }

        return salida;
    }

    public ArrayList<Object> getListaCompras() {
        return listaCompras;
    }

    public void setListaCompras(ArrayList<Object> listaCompras) {
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
