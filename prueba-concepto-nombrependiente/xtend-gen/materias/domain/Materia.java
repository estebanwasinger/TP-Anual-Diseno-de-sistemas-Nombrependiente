package materias.domain;

import com.google.common.base.Objects;
import org.uqbar.commons.model.Entity;
import org.uqbar.commons.model.UserException;
import org.uqbar.commons.utils.Observable;

@Observable
@SuppressWarnings("all")
public class Materia extends Entity {
  private Integer _id;
  
  public Integer getId() {
    return this._id;
  }
  
  public void setId(final Integer id) {
    this._id = id;
  }
  
  private String _nombre;
  
  public String getNombre() {
    return this._nombre;
  }
  
  public void setNombre(final String nombre) {
    this._nombre = nombre;
  }
  
  public void validar() {
    String _nombre = this.getNombre();
    boolean _equals = Objects.equal(_nombre, null);
    if (_equals) {
      throw new UserException("Debe ingresar un nombre de materia");
    }
  }
  
  public boolean ingresoNombre() {
    boolean _and = false;
    String _nombre = this.getNombre();
    boolean _notEquals = (!Objects.equal(_nombre, null));
    if (!_notEquals) {
      _and = false;
    } else {
      String _nombre_1 = this.getNombre();
      String _trim = _nombre_1.trim();
      boolean _equals = _trim.equals("");
      boolean _not = (!_equals);
      _and = _not;
    }
    return _and;
  }
}
