package modelo.DAO;

import java.util.List;
import modelo.Productos;
import org.hibernate.Session;

/**
 *
 * @author marwi
 */
public class ProductoDAO {

    public static List<Productos> listarProductos() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("from Productos").list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

}
