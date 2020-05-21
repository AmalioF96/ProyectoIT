package modelo.DAO;

import java.util.ArrayList;
import modelo.Productos;
import modelo.Usuarios;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class DeseoDAO {

    public static ArrayList<Productos> listarDeseos(String email) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        ArrayList<Productos> lista = null;
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            lista = (ArrayList<Productos>) sesion.createQuery("SELECT u.productoses_1 FROM Usuarios u WHERE u.email=:email").setParameter("email", email).list();
            tx.commit();
        } catch (HibernateException e) {
            if(tx!=null) {
                tx.rollback();
            }
        }
        return lista;
    }

    public static boolean eliminarDeseo(Usuarios u) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        boolean salida = true;
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.update(u);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            salida = false;
        }

        return salida;
    }
}
