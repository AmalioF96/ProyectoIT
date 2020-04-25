package modelo.DAO;

import modelo.Valoraciones;
import modelo.ValoracionesId;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class ValoracionDAO {

    public static boolean insertarValoracion(Valoraciones v) {
        boolean correcto = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.save(v);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
                correcto = false;
            }
        }
        return correcto;
    }

    public static boolean modificarValoracion(Valoraciones v) {
        boolean correcto = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        
        try {
            tx = sesion.beginTransaction();
            sesion.update(v);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
                correcto = false;
            }
        }

        return correcto;
    }

    public static boolean eliminarValoracion(ValoracionesId vid) {
        boolean correcto = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            Valoraciones v = (Valoraciones) sesion.load(Valoraciones.class, vid);
            sesion.delete(v);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
                correcto = false;
            }
        }
        return correcto;
    }

}
