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
        return p1.getLineasDeCompras().size() - p2.getLineasDeCompras().size();
    }
}
