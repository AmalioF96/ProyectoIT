package controlador.productos;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.ArrayList;
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
    private List<String> categoriasProducto;
    private List<Categorias> categorias;
    private List<Categorias> categoriasActuales;
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
    private Productos producto;
    private String operacion;

    public AccionCrearProducto() {
    }

    public void validate() {
        this.setCategorias(CategoriaDAO.listarCategorias());
        if (this.getOperacion() != null && this.getIdProducto() != null && this.getOperacion().equals("modificar")) {
            this.setProducto(ProductoDAO.obtenerProducto(this.getIdProducto()));
        }
        if (this.getNombre() == null || this.getNombre().equals("")) {
            addFieldError("nombre", "El nombre debe estar relleno");
        }
        if (this.getDescripcion() == null || this.getDescripcion().equals("")) {
            addFieldError("descripcion", "La descripción debe estar rellena");
        }
        if (this.getCategoriasProducto() == null || this.getCategoriasProducto().isEmpty()) {
            addFieldError("categoriasProducto", "Debe seleccionar al menos una categoría");
        } else {
            this.categoriasActuales = CategoriaDAO.listarCategoriasCoincidentes(this.getCategoriasProducto());
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
        if (this.nombreCaracteristica == null || this.nombreCaracteristica.isEmpty()) {
            this.setNombreCaracteristica(new ArrayList<>());
            addFieldError("nombreCaracteristica", "Debe incluir al menos una característica");
        }
        if (this.descripcionCaracteristica == null || this.descripcionCaracteristica.isEmpty()) {
            this.setDescripcionCaracteristica(new ArrayList<>());
            addFieldError("descripcionCaracteristica", "Las descripciones deben estar rellenas");
        }
        if (this.nombreCaracteristica.size() > this.descripcionCaracteristica.size()) {
            while (this.nombreCaracteristica.size() > this.descripcionCaracteristica.size()) {
                this.descripcionCaracteristica.add("");
            }
            addFieldError("descripcionCaracteristica", "Debe proporcionar una descripción para cada característica");
        } else if (this.nombreCaracteristica.size() < this.descripcionCaracteristica.size()) {
            while (this.nombreCaracteristica.size() < this.descripcionCaracteristica.size()) {
                this.nombreCaracteristica.add("");
            }
            addFieldError("nombreCaracteristica", "Debe proporcionar un nombre para cada característica");
        }

        if (this.archivoVenta == null && this.getOperacion().equals("crear")) {
            addFieldError("archivoVenta", "Debe subir el archivo a vender");
        }

        if (!isTerminos()) {
            Map request = (Map) ActionContext.getContext().get("request");
            request.put("errorTerminos", true);
            addFieldError("terminos", ERROR);
        }
    }

    public String execute() throws Exception {
        String salida = ERROR;
        String nuevaRuta;
        String nuevoNombre;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        try {
            Productos prod = new Productos();
            prod.setUsuarios(user);
            prod.setNombre(this.getNombre());
            prod.setDescripcion(this.getDescripcion());
            prod.setPrecio(Float.parseFloat(this.getPrecio()));
            prod.setDisponible(this.isDisponible());
            nuevaRuta = ServletActionContext.getServletContext().getRealPath("/imagenes");
            nuevoNombre = "/" + user.getNombre() + "_" + this.getNombre() + "_" + System.currentTimeMillis() + "."
                    + getImagenContentType().substring(getImagenContentType().indexOf("/") + 1);
            this.getImagen().renameTo(new File(nuevaRuta + nuevoNombre));
            prod.setImagen("/upomm/imagenes" + nuevoNombre);

            prod.setIdProducto(ProductoDAO.crearProducto(prod));

            if (prod.getIdProducto() > 0) {
                List<Categorias> lc = CategoriaDAO.listarCategoriasCoincidentes(this.getCategoriasProducto());

                Iterator it = lc.iterator();
                Set<CategoriasProductos> cats = new HashSet();
                while (it.hasNext()) {
                    Categorias c = (Categorias) it.next();
                    CategoriasProductosId cpId = new CategoriasProductosId(c.getNombre(), prod.getIdProducto());
                    CategoriasProductos cp = new CategoriasProductos(cpId, prod);
                    cats.add(cp);
                }
                prod.setCategoriasProductoses(cats);

                Set<CaracteristicasProductos> cars = new HashSet();
                for (int i = 0; i < this.getNombreCaracteristica().size(); i++) {
                    CaracteristicasProductosId cId = new CaracteristicasProductosId(prod.getIdProducto(), this.getNombreCaracteristica().get(i));
                    CaracteristicasProductos c = new CaracteristicasProductos(cId, prod, this.getDescripcionCaracteristica().get(i));
                    cars.add(c);
                }
                prod.setCaracteristicasProductoses(cars);
                if (ProductoDAO.actualizaProducto(prod)) {
                    salida = SUCCESS;
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
            try {
                Productos p = this.getProducto();
                p.setNombre(this.getNombre());
                p.setDescripcion(this.getDescripcion());
                p.setPrecio(Float.parseFloat(this.getPrecio()));
                p.setDisponible(this.isDisponible());

                Iterator<CategoriasProductos> it = p.getCategoriasProductoses().iterator();
                while (it.hasNext()) {
                    CategoriasProductos cp = it.next();
                    CategoriaDAO.eliminarCategoriasProducto(cp.getId());
                }
                List<Categorias> lc = CategoriaDAO.listarCategoriasCoincidentes(this.getCategoriasProducto());
                Iterator<Categorias> it2 = lc.iterator();
                Set<CategoriasProductos> nuevasCats = new HashSet();
                while (it2.hasNext()) {
                    Categorias c = it2.next();
                    CategoriasProductosId cpId = new CategoriasProductosId(c.getNombre(), p.getIdProducto());
                    CategoriasProductos cp = new CategoriasProductos(cpId, p);
                    nuevasCats.add(cp);
                }
                p.setCategoriasProductoses(nuevasCats);

                Iterator<CaracteristicasProductos> it3 = p.getCaracteristicasProductoses().iterator();
                while (it3.hasNext()) {
                    CaracteristicasProductos cp = it3.next();
                    ProductoDAO.eliminarCaracteristicaProducto(cp.getId());
                }

                Set<CaracteristicasProductos> cars = new HashSet();
                for (int i = 0; i < this.getNombreCaracteristica().size(); i++) {
                    CaracteristicasProductosId cId = new CaracteristicasProductosId(p.getIdProducto(), this.getNombreCaracteristica().get(i));
                    CaracteristicasProductos c = new CaracteristicasProductos(cId, p, this.getDescripcionCaracteristica().get(i));
                    cars.add(c);
                }
                p.setCaracteristicasProductoses(cars);
                if (ProductoDAO.actualizaProducto(p)) {
                    salida = SUCCESS;
                }
            } catch (Exception e) {
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

    public List<String> getCategoriasProducto() {
        return categoriasProducto;
    }

    public void setCategoriasProducto(List<String> categoriasProductos) {
        this.categoriasProducto = categoriasProductos;
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
        List<String> l = new ArrayList();
        for (String nc : nombreCaracteristica) {
            if (nc.trim().length() > 0) {
                l.add(nc.trim());
            }
        }
        this.nombreCaracteristica = l;
    }

    public List<String> getDescripcionCaracteristica() {
        return descripcionCaracteristica;
    }

    public void setDescripcionCaracteristica(List<String> descripcionCaracteristica) {
        List<String> l = new ArrayList();
        for (String dc : descripcionCaracteristica) {
            if (dc.trim().length() > 0) {
                l.add(dc.trim());
            }
        }
        this.descripcionCaracteristica = l;
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

    public List<Categorias> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<Categorias> categorias) {
        this.categorias = categorias;
    }

    public List<Categorias> getCategoriasActuales() {
        return categoriasActuales;
    }

    public void setCategoriasActuales(List<Categorias> categoriasActuales) {
        this.categoriasActuales = categoriasActuales;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }

}
