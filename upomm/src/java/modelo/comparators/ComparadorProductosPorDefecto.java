package modelo.comparators;

import java.util.Comparator;
import modelo.Productos;

/**
 *
 * @author marwi
 */
public class ComparadorProductosPorDefecto implements Comparator<Productos> {
    @Override
    public int compare(Productos p1, Productos p2) {
        return p1.getIdProducto()-p2.getIdProducto();
    }
    
}
