package modelo.DAO;

import java.util.List;
import modelo.Reclamaciones;
import modelo.ReclamacionesId;
import modelo.Usuarios;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class ReclamacionDAO {

    public static boolean crearReclamacion(Reclamaciones r) {
        boolean salida = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = sesion.beginTransaction();
            sesion.save(r);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }
    
    public static boolean modificarReclamacion(ReclamacionesId rid, String estado) {
        boolean salida = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = sesion.beginTransaction();
            Reclamaciones r = (Reclamaciones) sesion.get(Reclamaciones.class, rid);
            r.setEstado(estado);
            sesion.update(r);
            tx.commit();
        } catch (Exception ex) {
            salida = false;
            if (tx != null) {
                tx.rollback();
            }
        }
        return salida;
    }

    public static List<Reclamaciones> listarReclamacionesCliente(Usuarios u) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Reclamaciones> l = null;
        try {
            tx = sesion.beginTransaction();
            l = sesion.createQuery("SELECT reclamacioneses FROM Compras c WHERE c.usuarios.email LIKE :email").setParameter("email", u.getEmail()).list();
            tx.commit();
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
        }
        return l;
    }

    public static List<Reclamaciones> listarReclamacionesVendedor(Usuarios u) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Reclamaciones> l = null;
        try {
            tx = sesion.beginTransaction();
            l = sesion.createQuery("FROM Reclamaciones r WHERE r.productos.usuarios.email LIKE :email").setParameter("email", u.getEmail()).list();
            tx.commit();
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
        }
        return l;
    }
}
