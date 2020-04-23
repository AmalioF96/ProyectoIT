package modelo.DAO;

import modelo.Valoraciones;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marwi
 */
public class ValoracionDAO {

    public static void eliminarValoracion(Valoraciones v) {
        Session sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        tx = sesion.beginTransaction();
        System.out.println(v.getProductos().getIdProducto() + " " + v.getUsuarios().getEmail());
        sesion.delete(v);
        sesion.flush();
        tx.commit();
    }

}
