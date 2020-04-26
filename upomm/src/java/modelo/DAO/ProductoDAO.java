package modelo.DAO;

import java.util.Iterator;
import java.util.List;
import modelo.CaracteristicasProductos;
import modelo.CaracteristicasProductosId;
import modelo.Categorias;
import modelo.CategoriasProductos;
import modelo.Productos;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class ProductoDAO {

    private static Session sesion = null;

    public static Productos obtenerProducto(int idProducto) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        Productos p = null;
        try {
            tx = sesion.beginTransaction();

            p = (Productos) sesion.createQuery("from Productos where idProducto= :id").setParameter("id", idProducto).uniqueResult();

            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
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

    public static List<Productos> listarProductosPorCategoria(String cat) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("select productos from CategoriasProductos c where c.id.nombre like :cat").setParameter("cat", cat).list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Productos> buscarProductosPorCategoria(String busqueda, String cat) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("select productos from CategoriasProductos c where c.id.nombre like :cat and (c.productos.nombre like concat('%',:busqueda,'%') or c.productos.descripcion like concat('%',:busqueda,'%'))").setParameter("cat", cat).setParameter("busqueda", busqueda).list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Productos> buscarProductos(String busqueda) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("from Productos c where nombre like concat('%',:busqueda,'%') or descripcion like concat('%',:busqueda,'%')").setParameter("busqueda", busqueda).list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static int crearProducto(Productos p) {
        int id = -1;
        try {
            sesion = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = sesion.beginTransaction();
            id = (int)sesion.save(p);
            sesion.flush();
            tx.commit();
        } catch (Exception ex) {
            id = -1;
        }
        return id;
    }
    
    public static boolean actualizaProducto(Productos p) {
        boolean salida = true;
        try {
            sesion = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = sesion.beginTransaction();
            sesion.update(p);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
        }
        return salida;
    }

    
    public static boolean crearCaracteristica(CaracteristicasProductos c){
        boolean salida = true;
        try {
            sesion = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = sesion.beginTransaction();
            sesion.save(c);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
        }
        return salida;
    }
    
    
    
    public static boolean crearRelacionCategoriaProduto(CategoriasProductos cp){
        boolean salida = true;
        try {
            sesion = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = sesion.beginTransaction();
            sesion.save(cp);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
        }
        return salida;
    }

}
