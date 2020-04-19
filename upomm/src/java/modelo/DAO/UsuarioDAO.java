/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.DAO;

import modelo.Usuarios;
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
        Transaction tx = sesion.beginTransaction();
        Query q = sesion.createQuery("From Usuarios where email='" + email + "' and password='" + password + "'");
        usu = (Usuarios) q.uniqueResult();
        tx.commit();

        return usu;
    }

    public static boolean existeEmail(String email) {
        Boolean salida = false;
        Usuarios usu = null;
        sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = sesion.beginTransaction();
        Query q = sesion.createQuery("From Usuarios where email='" + email + "'");
        usu = (Usuarios) q.uniqueResult();
        tx.commit();
        if (usu != null) {
            salida = true;
        }
        return salida;
    }

    public static boolean existeNombre(String nombre) {
        Boolean salida = false;
        Usuarios usu = null;
        sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = sesion.beginTransaction();
        Query q = sesion.createQuery("From Usuarios where nombre='" + nombre + "'");
        usu = (Usuarios) q.uniqueResult();
        tx.commit();
        if (usu != null) {
            salida = true;
        }
        return salida;
    }

    public static boolean creaUsuario(Usuarios user) {
        try{
        sesion=HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx=sesion.beginTransaction();
        sesion.save(user);
        tx.commit();
        return true;
        }catch(Exception ex){
            return false;
        }
    }
}
