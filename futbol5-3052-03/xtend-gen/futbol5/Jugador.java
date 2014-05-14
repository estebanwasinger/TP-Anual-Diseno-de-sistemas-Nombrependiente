package futbol5;

import futbol5.Administrador;
import helper.Notificacion;
import inscripciones.Estandar;
import inscripciones.TipoInscripcion;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("all")
public class Jugador {
  private TipoInscripcion _tipoInscripcion;
  
  public TipoInscripcion getTipoInscripcion() {
    return this._tipoInscripcion;
  }
  
  public void setTipoInscripcion(final TipoInscripcion tipoInscripcion) {
    this._tipoInscripcion = tipoInscripcion;
  }
  
  private String _nombre;
  
  public String getNombre() {
    return this._nombre;
  }
  
  public void setNombre(final String nombre) {
    this._nombre = nombre;
  }
  
  private int _edad;
  
  public int getEdad() {
    return this._edad;
  }
  
  public void setEdad(final int edad) {
    this._edad = edad;
  }
  
  private String _email;
  
  public String getEmail() {
    return this._email;
  }
  
  public void setEmail(final String email) {
    this._email = email;
  }
  
  private List<Jugador> _amigos;
  
  public List<Jugador> getAmigos() {
    return this._amigos;
  }
  
  public void setAmigos(final List<Jugador> amigos) {
    this._amigos = amigos;
  }
  
  private List<Notificacion> _notificaciones;
  
  public List<Notificacion> getNotificaciones() {
    return this._notificaciones;
  }
  
  public void setNotificaciones(final List<Notificacion> notificaciones) {
    this._notificaciones = notificaciones;
  }
  
  private Administrador _administrador;
  
  public Administrador getAdministrador() {
    return this._administrador;
  }
  
  public void setAdministrador(final Administrador administrador) {
    this._administrador = administrador;
  }
  
  private int _diasDeInfraccion;
  
  public int getDiasDeInfraccion() {
    return this._diasDeInfraccion;
  }
  
  public void setDiasDeInfraccion(final int diasDeInfraccion) {
    this._diasDeInfraccion = diasDeInfraccion;
  }
  
  public void initialize() {
    ArrayList<Jugador> _arrayList = new ArrayList<Jugador>();
    this.setAmigos(_arrayList);
    this.setDiasDeInfraccion(0);
  }
  
  public void initializeTipoEstandar() {
    Estandar _estandar = new Estandar();
    this.setTipoInscripcion(_estandar);
    ArrayList<Jugador> _arrayList = new ArrayList<Jugador>();
    this.setAmigos(_arrayList);
    this.setDiasDeInfraccion(0);
  }
  
  public Jugador(final TipoInscripcion inscripcion, final String pNombre) {
    this.initialize();
    this.setTipoInscripcion(inscripcion);
    this.setNombre(pNombre);
  }
  
  public Jugador() {
    this.initializeTipoEstandar();
  }
  
  public boolean menorA(final int edad) {
    int _edad = this.getEdad();
    return (_edad < edad);
  }
  
  public boolean tieneMasPrioridadQue(final Jugador jugador) {
    int _prioridad = this.prioridad();
    int _prioridad_1 = jugador.prioridad();
    return (_prioridad < _prioridad_1);
  }
  
  public int prioridad() {
    TipoInscripcion _tipoInscripcion = this.getTipoInscripcion();
    return _tipoInscripcion.prioridad();
  }
  
  public void nuevaInfraccion(final int cantidadDeDias) {
    this.setDiasDeInfraccion(cantidadDeDias);
  }
}
