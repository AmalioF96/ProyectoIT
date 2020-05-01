package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;
import modelo.CaracteristicasProductos;
import modelo.CaracteristicasProductosId;
import modelo.Categorias;
import modelo.CategoriasProductos;
import modelo.CategoriasProductosId;
import modelo.DAO.CategoriaDAO;
import modelo.DAO.ProductoDAO;
import modelo.Productos;
import modelo.Usuarios;
import org.apache.struts2.ServletActionContext;

public class AccionCrearProducto extends ActionSupport {

    private String nombre;
    private String descripcion;
    private List<String> categorias;
    private File imagen;
    private String imagenFileName;
    private String imagenContentType;
    private String precio;
    private List<String> nombreCaracteristica;
    private List<String> descripcionCaracteristica;
    private File archivoVenta;
    private String archivoVentaFileName;
    private String archivoVentaContentType;
    private boolean disponible;
    private boolean terminos;
    private Integer idProducto;
    private String operacion;

    public AccionCrearProducto() {
    }

    public void validate() {
        if (this.getNombre() == null || this.getNombre().equals("")) {
            addFieldError("nombre", "El nombre debe estar relleno");
        }
        if (this.getDescripcion() == null || this.getDescripcion().equals("")) {
            addFieldError("descripcion", "La descripción debe estar rellena");
        }
        if (this.categorias == null || this.categorias.isEmpty()) {
            System.out.println("-------------------------------" + this.categorias);
            addFieldError("categorias", "Debe seleccionar al menos una categoría");
        }
        if (this.getImagen() == null && this.getOperacion().equals("crear")) {
            addFieldError("imagen", "Debe incluir una imagen");
        }
        if (!Pattern.matches("^\\d+([,.]\\d+)?$", this.getPrecio())) {
            addFieldError("precio", "El precio debe ser numérico");
        } else {
            if (Float.parseFloat(this.precio) < 0) {
                addFieldError("precio", "El precio debe ser mayor que 0");
            }
        }
        if (this.nombreCaracteristica == null || this.nombreCaracteristica.isEmpty()
                || this.descripcionCaracteristica == null || this.descripcionCaracteristica.isEmpty()
                || this.nombreCaracteristica.size() != this.descripcionCaracteristica.size()) {
            addFieldError("nombreCaracteristica", "Las características deben estar rellenas");
        } else {
            String nc;
            String dc;

            for (int i = 0; i < this.nombreCaracteristica.size(); i++) {
                nc = this.nombreCaracteristica.get(i);
                dc = this.descripcionCaracteristica.get(i);
                if (nc == null || nc.equals("")) {
                    addFieldError("nombreCaracteristica", "Los nombres de las características deben estar rellenos");
                }
                if (dc == null || dc.equals("")) {
                    addFieldError("descripcionCaracteristica", "Las descripciones de las características deben estar rellenas");
                }
            }
        }

        if (this.archivoVenta == null && this.getOperacion().equals("crear")) {
            addFieldError("archivoVenta", "Debe subir el archivo a vender");
        }

        if (!isTerminos()) {
            addFieldError("terminos", "Debe aceptar los términos y condiciones");
        }
    }

    public String execute() throws Exception {
        String salida = SUCCESS;
        String nuevaRuta;
        String nuevoNombre;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        try {
            Productos prod = new Productos();
            prod.setNombre(this.getNombre());
            prod.setDescripcion(this.getDescripcion());
            prod.setPrecio(Float.parseFloat(this.getPrecio()));
            prod.setUsuarios(user);
            prod.setDisponible(this.isDisponible());
            nuevaRuta = ServletActionContext.getServletContext().getRealPath("/imagenes");

            nuevoNombre = "/" + user.getNombre() + "_" + this.getNombre() + "_" + System.currentTimeMillis() + "."
                    + getImagenContentType().substring(getImagenContentType().indexOf("/") + 1);
            imagen.renameTo(new File(nuevaRuta + nuevoNombre));

            prod.setImagen("/upomm/imagenes" + nuevoNombre);
            Set setCat = new HashSet(CategoriaDAO.listarCategoriasCoincidentes(this.getCategorias()));
            prod.setCategoriasProductoses(setCat);
            prod.setIdProducto(ProductoDAO.crearProducto(prod));
            if (prod.getIdProducto() < 0) {
                salida = ERROR;
            }
            Iterator it = prod.getCategoriasProductoses().iterator();
            Categorias categoria;
            while (it.hasNext()) {
                categoria = (Categorias) it.next();
                CategoriasProductosId cpId = new CategoriasProductosId(categoria.getNombre(), prod.getIdProducto());
                CategoriasProductos cp = new CategoriasProductos(cpId, prod);
                ProductoDAO.crearRelacionCategoriaProduto(cp);
            }

            CaracteristicasProductos c;
            CaracteristicasProductosId cId;
            for (int i = 0; i < this.getNombreCaracteristica().size(); i++) {
                cId = new CaracteristicasProductosId(prod.getIdProducto(), this.getNombreCaracteristica().get(i));
                c = new CaracteristicasProductos(cId, prod, this.getDescripcionCaracteristica().get(i));

                if (!ProductoDAO.crearCaracteristica(c)) {
                    salida = ERROR;
                }
            }

        } catch (Exception ex) {
            salida = ERROR;
        }
        return salida;
    }

    public String modificar() {
        String salida = ERROR;
        if (this.getOperacion() != null && this.getIdProducto() != null && this.getOperacion().equals("modificar")) {
            Productos p = modelo.DAO.ProductoDAO.obtenerProductoVendido(this.getIdProducto());
            p.setNombre(this.getNombre());
            if (modelo.DAO.ProductoDAO.actualizaProducto(p)) {
                salida = SUCCESS;
            }
        }

        return salida;

    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public List<String> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<String> categorias) {
        this.categorias = categorias;
    }

    public File getImagen() {
        return imagen;
    }

    public void setImagen(File imagen) {
        this.imagen = imagen;
    }

    public String getImagenFileName() {
        return imagenFileName;
    }

    public void setImagenFileName(String imagenFileName) {
        this.imagenFileName = imagenFileName;
    }

    public String getImagenContentType() {
        return imagenContentType;
    }

    public void setImagenContentType(String imagenContentType) {
        this.imagenContentType = imagenContentType;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public List<String> getNombreCaracteristica() {
        return nombreCaracteristica;
    }

    public void setNombreCaracteristica(List<String> nombreCaracteristica) {
        this.nombreCaracteristica = nombreCaracteristica;
    }

    public List<String> getDescripcionCaracteristica() {
        return descripcionCaracteristica;
    }

    public void setDescripcionCaracteristica(List<String> descripcionCaracteristica) {
        this.descripcionCaracteristica = descripcionCaracteristica;
    }

    public File getArchivoVenta() {
        return archivoVenta;
    }

    public void setArchivoVenta(File archivoVenta) {
        this.archivoVenta = archivoVenta;
    }

    public String getArchivoVentaFileName() {
        return archivoVentaFileName;
    }

    public void setArchivoVentaFileName(String archivoVentaFileName) {
        this.archivoVentaFileName = archivoVentaFileName;
    }

    public String getArchivoVentaContentType() {
        return archivoVentaContentType;
    }

    public void setArchivoVentaContentType(String archivoVentaContentType) {
        this.archivoVentaContentType = archivoVentaContentType;
    }

    public boolean isTerminos() {
        return terminos;
    }

    public void setTerminos(boolean terminos) {
        this.terminos = terminos;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }
}
