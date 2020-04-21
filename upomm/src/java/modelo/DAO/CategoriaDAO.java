package modelo.DAO;

import java.util.List;
import modelo.Categorias;
import org.hibernate.Session;

/**
 *
 * @author marwi
 */
public class CategoriaDAO {

    public static List<Categorias> listaCategorias() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Categorias> listaCategorias = sesion.createQuery("from Categorias order by nombre ASC").list();

        sesion.getTransaction().commit();

        return listaCategorias;
    }

}
