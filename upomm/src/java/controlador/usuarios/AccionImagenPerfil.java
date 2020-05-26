package controlador.usuarios;

import static com.opensymphony.xwork2.Action.ERROR;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.FilenameFilter;
import java.util.Map;
import modelo.DAO.UsuarioDAO;
import modelo.Usuarios;
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
        String nuevoNombre;
        Map session = (Map) ActionContext.getContext().get("session");
        Usuarios user = (Usuarios) session.get("usuario");
        if (imagenPerfil == null) {
            salida = ERROR;
        } else {
            path = ServletActionContext.getServletContext().getInitParameter("upload.location")+"imagenes/";
            File dir = new File(path);
            File[] matches = dir.listFiles(new FilenameFilter() {
                public boolean accept(File dir, String name) {
                    return name.startsWith("user_"+user.getEmail());
                }
            });
            if (matches.length > 0) {
                for (File match : matches) {
                    match.delete();
                }
            }
            //path = ServletActionContext.getServletContext().getRealPath("/imagenes");
            nuevoNombre = "user_" + user.getEmail() + "_" + System.currentTimeMillis() + "."
                    + getImagenPerfilContentType().substring(getImagenPerfilContentType().indexOf("/") + 1);

            this.getImagenPerfil().renameTo(new File(path + nuevoNombre));
            user.setFoto("/upomm/imagenes/"+nuevoNombre);

            if (UsuarioDAO.actualizaUsuario(user)) {
                session.put("usuario", user);
                Map request = (Map) ActionContext.getContext().get("request");
                request.put("error", false);
            } else {
                salida = ERROR;
            }
        }
        return salida;
    }

}
