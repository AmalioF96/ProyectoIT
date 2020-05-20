package modelo.DAO;

import modelo.Usuarios;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Amalio
 */
public class UsuarioDAO {

    private static Session sesion = null;

    public static Usuarios comprobarUsuario(String email, String password) {
        Usuarios usu = null;
        sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        
        try {
            Transaction tx = sesion.beginTransaction();
            Query q = sesion.createQuery("FROM Usuarios WHERE email='" + email + "' AND password='" + password + "'");
            usu = (Usuarios) q.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
        }

        return usu;
    }

    public static boolean existeEmail(String email) {
        Boolean salida = false;
        Usuarios usu = null;
        sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        
        try {
            Transaction tx = sesion.beginTransaction();
            Query q = sesion.createQuery("FROM Usuarios WHERE email='" + email + "'");
            usu = (Usuarios) q.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
        }

        if (usu != null) {
            salida = true;
        }
        return salida;
    }

    public static boolean existeNombre(String nombre) {
        Boolean salida = false;
        Usuarios usu = null;
        sesion = HibernateUtil.getSessionFactory().getCurrentSession();

        try {
            Transaction tx = sesion.beginTransaction();
            Query q = sesion.createQuery("FROM Usuarios WHERE nombre='" + nombre + "'");
            usu = (Usuarios) q.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
        }
        
        if (usu != null) {
            salida = true;
        }
        return salida;
    }

    public static boolean creaUsuario(Usuarios user) {
        try {
            sesion = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = sesion.beginTransaction();
            sesion.save(user);
            tx.commit();
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public static boolean actualizaUsuario(Usuarios user) {
        try {
            sesion = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = sesion.beginTransaction();
            sesion.update(user);
            tx.commit();
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
}
