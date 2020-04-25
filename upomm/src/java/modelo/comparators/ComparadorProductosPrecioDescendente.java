package modelo.comparators;

import java.util.Comparator;
import modelo.Productos;

/**
 *
 * @author marwi
 */
public class ComparadorProductosPrecioDescendente implements Comparator<Productos> {

    @Override
    public int compare(Productos p1, Productos p2) {
        int cmp;
        if(p1.getPrecio() < p2.getPrecio()) {
            cmp = 1;
        }
        else if (p1.getPrecio() > p2.getPrecio()) {
            cmp = -1;
        }
        else {
            cmp = 0;
        }
        return cmp;
    }

}
