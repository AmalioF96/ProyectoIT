package modelo.DAO;

import java.util.List;
import modelo.Reclamaciones;
import modelo.Usuarios;
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

    public static List<Reclamaciones> listarReclamacionesCliente(Usuarios u) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Reclamaciones> l = null;
        try {
            tx = sesion.beginTransaction();
            l = sesion.createQuery("select reclamacioneses from Compras c where c.usuarios.email like :email").setParameter("email", u.getEmail()).list();
            tx.commit();
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
        }
        return l;
    }

}
