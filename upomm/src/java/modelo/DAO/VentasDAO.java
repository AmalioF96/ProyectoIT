/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.DAO;

import java.io.Serializable;
import modelo.Compras;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Amalio
 */
public class VentasDAO {

    public static boolean insertarCompra(Compras c) {
        boolean correcto = true;
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        try {
            tx = sesion.beginTransaction();
            int x =(int)sesion.save(c);
            tx.commit();
            
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
                correcto = false;
            }
        }
        return correcto;
    }

}
