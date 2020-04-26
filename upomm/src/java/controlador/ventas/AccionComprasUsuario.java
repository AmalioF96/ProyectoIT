/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.ventas;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import modelo.Compras;

/**
 *
 * @author Amalio
 */
public class AccionComprasUsuario extends ActionSupport {

    private ArrayList<Compras> listaCompras = null;

    public String listarCompras() {
        String salida = SUCCESS;

        this.listaCompras = (ArrayList<Compras>) modelo.DAO.VentasDAO.listarCompras();
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

}
