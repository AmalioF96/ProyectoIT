package controlador.usuarios;

import static com.opensymphony.xwork2.Action.ERROR;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import controlador.productos.AccionProductos;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.DAO.UsuarioDAO;
import modelo.Usuarios;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

public class AccionImagenPerfil extends ActionSupport {

    private File imagenPerfil;
    private String imagenPerfilFileName;
    private String imagenPerfilContentType;

    public AccionImagenPerfil() {
    }

    public File getImagenPerfil() {
        return imagenPerfil;
    }

    public void setImagenPerfil(File imagenPerfil) {
        this.imagenPerfil = imagenPerfil;
    }

    public String getImagenPerfilFileName() {
        return imagenPerfilFileName;
    }

    public void setImagenPerfilFileName(String imagenPerfilFileName) {
        this.imagenPerfilFileName = imagenPerfilFileName;
    }

    public String getImagenPerfilContentType() {
        return imagenPerfilContentType;
    }

    public void setImagenPerfilContentType(String imagenPerfilContentType) {
        this.imagenPerfilContentType = imagenPerfilContentType;
    }

    public void validate() {
        if (imagenPerfil == null) {
            addFieldError("imagenPerfil", "Archivo no válido");
        }
    }

    public String execute() throws Exception {
        String salida = SUCCESS;
        String path;
        String path_rel;
        String nuevoNombre;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        if (imagenPerfil == null) {
            salida = ERROR;
        } else {
            path = ServletActionContext.getServletContext().getInitParameter("upload.location") + "imagenes/";
            path_rel = ServletActionContext.getServletContext().getRealPath("/imagenes/");
            String name = user.getFoto().split("/upomm/imagenes/")[1];
            File f = new File(path + name);
            f.delete();
            f = new File(path_rel + name);
            f.delete();
            //File dir = new File(path);
            /*File[] matches = dir.listFiles(new FilenameFilter() {
                public boolean accept(File dir, String name) {
                    return name.startsWith("user_" + user.getEmail());
                }
            });
            if (matches.length > 0) {
                for (File match : matches) {
                    match.delete();
                }
            }*/
            File src = this.getImagenPerfil();
            String ext = this.getImagenPerfilFileName().substring(this.getImagenPerfilFileName().lastIndexOf("."));
            nuevoNombre = "user_" + user.getEmail() + "_" + System.currentTimeMillis() + ext;
            File abs = new File(path + nuevoNombre);
            File rel = new File(path_rel + nuevoNombre);
            try {
                FileUtils.copyFile(src, abs);
                FileUtils.copyFile(src, rel);
            } catch (IOException ex) {
                Logger.getLogger(AccionProductos.class.getName()).log(Level.SEVERE, null, ex);
            }
            user.setFoto("/upomm/imagenes/" + nuevoNombre);

            if (UsuarioDAO.actualizaUsuario(user)) {
                session.put("usuario", user);
            } else {
                addActionError("ERROR: no se pudo completar la operación");
                salida = ERROR;
            }
        }
        return salida;
    }

}
