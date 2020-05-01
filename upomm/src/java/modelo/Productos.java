package modelo;
// Generated 18-abr-2020 20:41:47 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;
import java.util.SortedSet;

/**
 * Productos generated by hbm2java
 */
public class Productos  implements java.io.Serializable {


     private int idProducto;
     private Usuarios usuarios;
     private String nombre;
     private String descripcion;
     private float precio;
     private String imagen;
     private boolean disponible;
     private Set<Valoraciones> valoracioneses = new HashSet(0);
     private Set categoriasProductoses = new HashSet();
     private Set reclamacioneses = new HashSet(0);
     private Set caracteristicasProductoses = new HashSet(0);
     private Set usuarioses = new HashSet(0);
     private Set lineasDeCompras = new HashSet(0);

    public Productos() {
    }

	
    public Productos(int idProducto, Usuarios usuarios, String nombre, String descripcion, float precio, String imagen, boolean disponible) {
        this.idProducto = idProducto;
        this.usuarios = usuarios;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.imagen = imagen;
        this.disponible = disponible;
    }
    public Productos(int idProducto, Usuarios usuarios, String nombre, String descripcion, float precio, String imagen, boolean disponible, Set valoracioneses, SortedSet categoriasProductoses, Set reclamacioneses, Set caracteristicasProductoses, Set usuarioses, Set lineasDeCompras) {
       this.idProducto = idProducto;
       this.usuarios = usuarios;
       this.nombre = nombre;
       this.descripcion = descripcion;
       this.precio = precio;
       this.imagen = imagen;
       this.disponible = disponible;
       this.valoracioneses = valoracioneses;
       this.categoriasProductoses = categoriasProductoses;
       this.reclamacioneses = reclamacioneses;
       this.caracteristicasProductoses = caracteristicasProductoses;
       this.usuarioses = usuarioses;
       this.lineasDeCompras = lineasDeCompras;
    }
   
    public int getIdProducto() {
        return this.idProducto;
    }
    
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }
    public Usuarios getUsuarios() {
        return this.usuarios;
    }
    
    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }
    public String getNombre() {
        return this.nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public float getPrecio() {
        return this.precio;
    }
    
    public void setPrecio(float precio) {
        this.precio = precio;
    }
    public String getImagen() {
        return this.imagen;
    }
    
    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    public boolean isDisponible() {
        return this.disponible;
    }
    
    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
    public Set getValoracioneses() {
        return this.valoracioneses;
    }
    
    public void setValoracioneses(Set valoracioneses) {
        this.valoracioneses = valoracioneses;
    }
    public Set getCategoriasProductoses() {
        return this.categoriasProductoses;
    }
    
    public void setCategoriasProductoses(Set categoriasProductoses) {
        this.categoriasProductoses = categoriasProductoses;
    }
    public Set getReclamacioneses() {
        return this.reclamacioneses;
    }
    
    public void setReclamacioneses(Set reclamacioneses) {
        this.reclamacioneses = reclamacioneses;
    }
    public Set getCaracteristicasProductoses() {
        return this.caracteristicasProductoses;
    }
    
    public void setCaracteristicasProductoses(Set caracteristicasProductoses) {
        this.caracteristicasProductoses = caracteristicasProductoses;
    }
    public Set getUsuarioses() {
        return this.usuarioses;
    }
    
    public void setUsuarioses(Set usuarioses) {
        this.usuarioses = usuarioses;
    }
    public Set getLineasDeCompras() {
        return this.lineasDeCompras;
    }
    
    public void setLineasDeCompras(Set lineasDeCompras) {
        this.lineasDeCompras = lineasDeCompras;
    }
    
     @Override
    public boolean equals(Object o) {
        Productos p = (Productos) o;
        
        return this.idProducto==p.getIdProducto();
    }
    
}


