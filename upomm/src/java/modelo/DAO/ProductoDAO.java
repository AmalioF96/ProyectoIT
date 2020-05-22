package modelo.DAO;

import java.util.List;
import modelo.CaracteristicasProductos;
import modelo.CaracteristicasProductosId;
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

    public static Productos obtenerProducto(int idProducto) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        Productos p = null;

        try {
            tx = sesion.beginTransaction();
            p = (Productos) sesion.get(Productos.class, idProducto);
            tx.commit();
        } catch (HibernateException e) {
            if(tx!=null) {
                tx.rollback();
            }
        }

        return p;
    }

    public static List<Productos> listarProductos() {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("FROM Productos WHERE disponible=true").list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Productos> listarProductos(String emailPropietario) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("FROM Productos as p WHERE p.usuarios='" + emailPropietario + "'").list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Productos> listarProductosPorCategoria(String cat) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("SELECT productos FROM CategoriasProductos c WHERE c.id.nombre LIKE :cat").setParameter("cat", cat).list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Productos> buscarProductosPorCategoria(String busqueda, String cat) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("SELECT productos FROM CategoriasProductos c WHERE c.id.nombre LIKE :cat AND (c.productos.nombre LIKE concat('%',:busqueda,'%') OR c.productos.descripcion LIKE concat('%',:busqueda,'%'))").setParameter("cat", cat).setParameter("busqueda", busqueda).list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static List<Productos> buscarProductos(String busqueda) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        sesion.beginTransaction();

        List<Productos> listaProductos = sesion.createQuery("FROM Productos c WHERE nombre LIKE concat('%',:busqueda,'%') OR descripcion LIKE concat('%',:busqueda,'%')").setParameter("busqueda", busqueda).list();

        sesion.getTransaction().commit();

        return listaProductos;
    }

    public static int crearProducto(Productos p) {
        int id = -1;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = sesion.beginTransaction();
            id = (int) sesion.save(p);
            sesion.flush();
            tx.commit();
        } catch (HibernateException ex) {
            id = -1;
            if (tx != null) {
                tx.rollback();
            }
        }
        return id;
    }

    public static boolean actualizaProducto(Productos p) {
        boolean salida = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.update(p);
            tx.commit();
        } catch (HibernateException ex) {
            salida = false;
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }

    public static boolean crearCaracteristica(CaracteristicasProductos c) {
        boolean salida = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.save(c);
            tx.commit();
        } catch (HibernateException ex) {
            salida = false;
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }

    public static boolean eliminarCaracteristicaProducto(CaracteristicasProductosId cpid) {
        boolean salida = false;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            CaracteristicasProductos cp = (CaracteristicasProductos) sesion.load(CaracteristicasProductos.class, cpid);
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

    public static boolean crearRelacionCategoriaProduto(CategoriasProductos cp) {
        boolean salida = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.save(cp);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }

}
