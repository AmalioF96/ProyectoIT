/*Con este comparador podemos ordenar las valoraciones de forma dinamica en funcion
del usuario que accede al producto, de manera que si este ha valorado el producto,
su valoracion siempre aparece la primera para poder editarla o eliminarla de forma
eficiente. El segundo criterio de ordenacion (o el principal si el usuario no ha
iniciado sesion) sera el de la fecha de publicacion de la valoracion, mostrando
primero las mas recientes*/

package modelo.comparators;

import java.util.Comparator;
import modelo.Valoraciones;

/**
 *
 * @author marwi
 */
public class ComparadorValoraciones implements Comparator<Valoraciones> {

    private String emailCliente;

    public String getEmailCliente() {
        return emailCliente;
    }

    public void setEmailCliente(String emailCliente) {
        this.emailCliente = emailCliente;
    }

    @Override
    public int compare(Valoraciones v1, Valoraciones v2) {
        int cmp = 0;
        if (this.getEmailCliente() != null) {
            if (v1.getUsuarios().getEmail().compareTo(this.getEmailCliente()) == 0) {
                cmp = -1;
            } else if (v2.getUsuarios().getEmail().compareTo(this.getEmailCliente()) == 0) {
                cmp = 1;
            } else {
                cmp = -(v1.getFecha().compareTo(v2.getFecha()));
            }
        } else {
            cmp = -(v1.getFecha().compareTo(v2.getFecha()));
        }
        return cmp;
    }

}
