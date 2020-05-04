package modelo.comparators;

import java.util.Comparator;
import modelo.CaracteristicasProductos;

/**
 *
 * @author marwi
 */
public class ComparadorCaracteristicasProductos implements Comparator<CaracteristicasProductos> {

    @Override
    public int compare(CaracteristicasProductos c1, CaracteristicasProductos c2) {
        return c1.getId().getNombre().compareTo(c2.getId().getNombre());
    }

}
