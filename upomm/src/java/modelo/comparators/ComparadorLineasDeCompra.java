package modelo.comparators;

import java.util.Comparator;
import modelo.LineasDeCompra;

/**
 *
 * @author marwi
 */
public class ComparadorLineasDeCompra implements Comparator<LineasDeCompra>{

    @Override
    public int compare(LineasDeCompra l1, LineasDeCompra l2) {
        return l1.getProductos().getIdProducto()-l2.getProductos().getIdProducto();
    }
    
}
