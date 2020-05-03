package modelo.DAO;

import java.util.List;
import modelo.Categorias;
import modelo.CategoriasProductos;
import modelo.CategoriasProductosId;
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

        try {
            Transaction tx = sesion.beginTransaction();
            listaCategorias = sesion.createQuery("from Categorias order by nombre ASC").list();
            sesion.getTransaction().commit();
        } catch (HibernateException e) {

        }

        return listaCategorias;
    }

    public static List<Categorias> listarCategoriasCoincidentes(List<String> lista) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        List<Categorias> listaCategorias = null;

        try {
            Transaction tx = sesion.beginTransaction();
            listaCategorias = sesion.createQuery("from Categorias where nombre in :lista").setParameterList("lista", lista).list();
            sesion.getTransaction().commit();
        } catch (HibernateException ex) {
        }

        return listaCategorias;
    }

    public static List<Categorias> listarCategoriasProducto(int id) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        List<Categorias> listaCategorias = null;
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            listaCategorias = sesion.createQuery("select c from Categorias c, CategoriasProductos cp where c.nombre=cp.id.nombre and cp.id.idProducto=:id").setParameter("id", id).list();
            sesion.getTransaction().commit();
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        }

        return listaCategorias;
    }

    public static boolean eliminarCategoriasProducto(CategoriasProductosId cpid) {
        boolean salida = false;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            CategoriasProductos cp = (CategoriasProductos) sesion.load(CategoriasProductos.class, cpid);
            sesion.delete(cp);
            tx.commit();
            salida = true;
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }
}
