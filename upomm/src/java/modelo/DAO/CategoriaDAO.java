package modelo.DAO;

import java.util.List;
import modelo.Categorias;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class CategoriaDAO {

    public static List<Categorias> listarCategorias() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        List<Categorias> listaCategorias = null;
        Transaction tx = null;
        try{
        sesion.beginTransaction();
        listaCategorias = sesion.createQuery("from Categorias order by nombre ASC").list();
        sesion.getTransaction().commit();
        }catch(HibernateException e) {
            if(tx != null) {
                tx.rollback();
            }
        }

        return listaCategorias;
    }

}
