package modelo.comparators;

import java.util.Comparator;
import java.util.Iterator;
import java.util.Set;
import modelo.Productos;
import modelo.Valoraciones;

/**
 *
 * @author marwi
 */
public class ComparadorProductosMejorValorados implements Comparator<Productos> {

    @Override
    public int compare(Productos p1, Productos p2) {
        int cmp;
        if(calculaPuntuacion(p1) < calculaPuntuacion(p2)) {
            cmp = 1;
        }
        else if (calculaPuntuacion(p1) > calculaPuntuacion(p2)) {
            cmp = -1;
        }
        else {
            cmp = 0;
        }
        return cmp;
    }

    public float calculaPuntuacion(Productos p) {
        Set<Valoraciones> lv = p.getValoracioneses();
        float puntuacion = 0;
        if (lv != null && !lv.isEmpty()) {
            Iterator<Valoraciones> it = lv.iterator();
            while (it.hasNext()) {
                puntuacion += it.next().getPuntuacion();
            }
            puntuacion /= lv.size();
        }
        return puntuacion;
    }

}
