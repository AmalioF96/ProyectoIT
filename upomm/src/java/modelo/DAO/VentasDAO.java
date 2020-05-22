package modelo.DAO;

import java.util.List;
import modelo.Compras;
import modelo.LineasDeCompra;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Amalio
 */
public class VentasDAO {

    public static int insertarCompra(Compras c) {
        int x = -1;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            x = (int) sesion.save(c);
            tx.commit();

        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }
        return x;
    }

    public static boolean insertarLineaDeCompra(LineasDeCompra ldc) {
        boolean x = false;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.save(ldc);
            tx.commit();
            x = true;
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }
        return x;
    }

    public static List<Compras> listarCompras() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Compras> listaCompras = null;
        try {
            tx = sesion.beginTransaction();
            listaCompras = sesion.createQuery("FROM Compras").list();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        }

        return listaCompras;

    }

    public static List<Compras> listarCompras(String emailCliente) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Compras> listaCompras = null;

        try {
            tx = sesion.beginTransaction();
            listaCompras = sesion.createQuery("FROM Compras c WHERE c.usuarios='" + emailCliente + "'").list();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        }

        return listaCompras;
    }

    public static List<Compras> listarVentas(String emailVendedor) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Compras> listaCompras = sesion.createQuery("SELECT ldc.compras FROM LineasDeCompra ldc WHERE ldc.productos.usuarios.email LIKE :email GROUP BY ldc.compras").setParameter("email", emailVendedor).list();

        sesion.getTransaction().commit();

        return listaCompras;

    }

    public static Compras obtenerCompra(int idCompra) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        Compras c = (Compras) sesion.load(Compras.class, idCompra);

        sesion.getTransaction().commit();

        return c;

    }

    public static List<LineasDeCompra> obtenerVenta(Integer idVenta, String emailVendedor) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<LineasDeCompra> ldc = sesion.createQuery("FROM LineasDeCompra WHERE compras.idCompra=:id AND productos.usuarios.email LIKE :email").setParameter("id", idVenta).setParameter("email", emailVendedor).list();

        sesion.getTransaction().commit();

        return ldc;
    }

}
