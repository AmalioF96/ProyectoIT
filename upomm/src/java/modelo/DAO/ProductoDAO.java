package modelo.DAO;

import java.util.List;
import modelo.Productos;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class ProductoDAO {

    public static Productos obtenerProducto(int idProducto) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        Productos p = null;
        try{
        tx = sesion.beginTransaction();

        p = (Productos) sesion.createQuery("from Productos where idProducto= :id").setParameter("id", idProducto).uniqueResult();

        tx.commit();
        }catch(HibernateException e){
            if(tx != null) {
                tx.rollback();
            }
        }
            
        return p;
    }

    public static List<Productos> listarProductos() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("from Productos").list();

        sesion.getTransaction().commit();

        return listaProductos;
    }
}
