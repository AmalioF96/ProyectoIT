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

    public static Usuarios obtenerUsuario(String email) {
        Transaction tx = null;
        Usuarios usu = null;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();

        try {
            tx = sesion.beginTransaction();
            Query q = sesion.createQuery("FROM Usuarios WHERE email=:email").setParameter("email", email);
            usu = (Usuarios) q.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }

        return usu;
    }

    public static boolean existeEmail(String email) {
        boolean salida = true;
        Transaction tx = null;
        Usuarios usu = null;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();

        try {
            tx = sesion.beginTransaction();
            Query q = sesion.createQuery("FROM Usuarios WHERE email=:email").setParameter("email", email);
            usu = (Usuarios) q.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }

        if (usu != null) {
            salida = true;
        }
        else{
            salida = false;
        }

        return salida;
    }

    public static boolean existeNombre(String nombre) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        boolean salida = true;
        Transaction tx = null;
        Usuarios usu = null;

        try {
            tx = sesion.beginTransaction();
            Query q = sesion.createQuery("FROM Usuarios WHERE nombre='" + nombre + "'");
            usu = (Usuarios) q.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }

        if (usu != null) {
            salida = true;
        }
        else{
            salida = false;
        }

        return salida;
    }

    public static boolean creaUsuario(Usuarios user) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        boolean salida = true;
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            sesion.save(user);
            tx.commit();
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
            salida = false;
        }

        return salida;
    }

    public static boolean actualizaUsuario(Usuarios user) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        boolean salida = true;
        Transaction tx = null;
        try {
            tx = sesion.beginTransaction();
            sesion.update(user);
            tx.commit();
        } catch (Exception ex) {
            if (tx != null) {
                tx.rollback();
            }
            salida = false;
        }

        return salida;
    }
}
