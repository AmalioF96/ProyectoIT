package modelo.comparators;

import java.util.Comparator;
import modelo.Productos;

/**
 *
 * @author marwi
 */
public class ComparadorProductosMasVendidos implements Comparator<Productos> {

    @Override
    public int compare(Productos p1, Productos p2) {
        int cmp;
        if(p1.getLineasDeCompras().size() > p2.getLineasDeCompras().size()) {
            cmp = 1;
        }
        else if (p1.getLineasDeCompras().size() > p2.getLineasDeCompras().size()) {
            cmp = -1;
        }
        else {
            cmp = 0;
        }
        return cmp;
    }
}
