/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.usuarios;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Map;
import modelo.DAO.DeseoDAO;
import modelo.Productos;
import modelo.Usuarios;

/**
 *
 * @author Amalio
 */
public class AccionListaDeseos extends ActionSupport {

    private Integer idProducto = null;
    private ArrayList<Productos> deseos = null;

    public AccionListaDeseos() {
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public ArrayList<Productos> getDeseos() {
        return deseos;
    }

    public void setDeseos(ArrayList<Productos> deseos) {
        this.deseos = deseos;
    }

    public String recogerDeseos() {
        String salida = ERROR;
        Map session = (Map) ActionContext.getContext().get("session");
        //Declaracion de variables
        System.out.println("\na\na\na\na\na\na\na\na\na\na\na\na");
        Usuarios u = (Usuarios) session.get("usuario");

        this.setDeseos(DeseoDAO.listarDeseos(u.getEmail()));
        salida = SUCCESS;

        return salida;
    }

    public String eliminarDeseo() {
        String salida = ERROR;
        boolean eliminado = false;
        Map session = (Map) ActionContext.getContext().get("session");
        //Declaracion de variables
        Usuarios u = (Usuarios) session.get("usuario");
        Productos p;
        int i = 0;
        Object[] prods = u.getProductoses_1().toArray();
        while (i < prods.length && !eliminado) {
            p = (Productos) prods[i];
            if (p.getIdProducto() == this.getIdProducto()) {
                u.getProductoses_1().remove(p);
                eliminado = true;
            } else {
                i++;
            }
        }
        if (this.getIdProducto() != null && eliminado) {
            DeseoDAO.eliminarDeseo(u);
            salida = SUCCESS;
        }
        return salida;
    }
}
