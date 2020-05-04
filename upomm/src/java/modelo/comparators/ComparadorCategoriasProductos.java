package modelo.comparators;

import java.util.Comparator;
import modelo.CategoriasProductos;

/**
 *
 * @author marwi
 */
public class ComparadorCategoriasProductos implements Comparator<CategoriasProductos>{

    @Override
    public int compare(CategoriasProductos c1, CategoriasProductos c2) {
        return c1.getId().getNombre().compareTo(c2.getId().getNombre());
    }
    
}
