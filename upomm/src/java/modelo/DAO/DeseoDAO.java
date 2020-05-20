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
        try {
            Transaction tx = sesion.beginTransaction();
            lista = (ArrayList<Productos>) sesion.createQuery("SELECT u.productoses_1 FROM Usuarios u WHERE u.email=:email").setParameter("email", email).list();
            sesion.getTransaction().commit();
        } catch (HibernateException e) {

        }
        return lista;
    }

    public static void eliminarDeseo(Usuarios u) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();

        try {
            Transaction tx = sesion.beginTransaction();
            sesion.update(u);
            sesion.getTransaction().commit();
        } catch (HibernateException e) {

        }

    }
}
