package modelo.DAO;

import java.util.List;
import modelo.Productos;
import modelo.Valoraciones;
import org.hibernate.Session;

/**
 *
 * @author marwi
 */
public class ProductoDAO {

    public static Productos obtenerProducto(int idProducto) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        Productos p = (Productos) sesion.createQuery("from Productos where idProducto= :id").setParameter("id", idProducto).uniqueResult();

        sesion.getTransaction().commit();
        return p;
    }

    public static List<Productos> listarProductos() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("from Productos").list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Valoraciones> obtenerValoracionesProducto(int idProducto) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Valoraciones> listaValoraciones = sesion.createQuery("from Valoraciones where id.idProducto= :id").setParameter("id", idProducto).list();

        sesion.getTransaction().commit();

        return listaValoraciones;
    }

}
