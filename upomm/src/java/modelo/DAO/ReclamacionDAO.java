package modelo.DAO;

import modelo.Reclamaciones;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class ReclamacionDAO {

    public static boolean crearReclamacion(Reclamaciones r) {
        boolean salida = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = sesion.beginTransaction();
            sesion.save(r);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }

}
