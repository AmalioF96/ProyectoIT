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
        sesion.beginTransaction();

        List<Compras> listaCompras = sesion.createQuery("from Compras").list();

        sesion.getTransaction().commit();

        return listaCompras;

    }

    public static List<Compras> listarCompras(String emailCliente) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Compras> listaCompras = sesion.createQuery("From Compras as c where c.usuarios='" + emailCliente + "'").list();

        sesion.getTransaction().commit();

        return listaCompras;

    }

    public static List<Object> listarVentas(String emailVendedor) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Object> listaCompras = sesion.createQuery(" SELECT p.idCompra as id, p.usuarios.email as comprador, count(p.id) as num_productos, sum(lp.cantidad*prod.precio) as importe, p.fecha FROM Compras as  p, LineasDeCompra as lp, Productos as prod WHERE prod.usuarios='"+emailVendedor+"' AND lp.compras = p.idCompra AND lp.productos = prod.idProducto GROUP BY lp ").list();

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

}
