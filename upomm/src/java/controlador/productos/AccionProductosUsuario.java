/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.productos;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Map;
import modelo.Productos;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionProductosUsuario extends ActionSupport {

    private ArrayList<Productos> listaProductos = null;

    private Integer idProducto = null;

    public String listarProductos() {
        String salida = SUCCESS;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        this.listaProductos = (ArrayList<Productos>) modelo.DAO.ProductoDAO.listarProductos(user.getEmail());
        if (this.listaProductos.size() <= 0) {
            this.listaProductos = new ArrayList<>();
        }

        return salida;
    }

    public AccionProductosUsuario() {
    }

    public ArrayList<Productos> getListaProductos() {
        return listaProductos;
    }

    public void setListaProductos(ArrayList<Productos> listaProductos) {
        this.listaProductos = listaProductos;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

}
