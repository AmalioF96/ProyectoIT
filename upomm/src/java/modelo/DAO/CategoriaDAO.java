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

        try{
        Transaction tx = sesion.beginTransaction();
        listaCategorias = sesion.createQuery("from Categorias order by nombre ASC").list();
        sesion.getTransaction().commit();
        }catch(HibernateException e) {

        }

        return listaCategorias;
    }

    public static List<Categorias> listarCategoriasCoincidentes(List<String> lista) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        List<Categorias> listaCategorias = null;

        try{
        Transaction tx = sesion.beginTransaction();
        listaCategorias = sesion.createQuery("from Categorias where nombre in :lista order by nombre ASC").setParameterList("lista", lista).list();
        sesion.getTransaction().commit();
        }catch(HibernateException e) {

        }

        return listaCategorias;
    }
}
