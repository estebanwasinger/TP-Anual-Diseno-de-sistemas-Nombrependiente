package futbol5.applicationModel;

import futbol5.domain.Jugador;
import futbol5.homes.HomeJugadores;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.uqbar.commons.utils.ApplicationContext;
import org.uqbar.commons.utils.Observable;

@Observable
@SuppressWarnings("all")
public class BusquedaJugadoresAppModel implements Serializable {
  private Jugador _jugadorEjemplo;
  
  public Jugador getJugadorEjemplo() {
    return this._jugadorEjemplo;
  }
  
  public void setJugadorEjemplo(final Jugador jugadorEjemplo) {
    this._jugadorEjemplo = jugadorEjemplo;
  }
  
  private ArrayList<Jugador> _jugadores;
  
  public ArrayList<Jugador> getJugadores() {
    return this._jugadores;
  }
  
  public void setJugadores(final ArrayList<Jugador> jugadores) {
    this._jugadores = jugadores;
  }
  
  private List<Jugador> _resultados;
  
  public List<Jugador> getResultados() {
    return this._resultados;
  }
  
  public void setResultados(final List<Jugador> resultados) {
    this._resultados = resultados;
  }
  
  private Jugador _jugadorSeleccionado;
  
  public Jugador getJugadorSeleccionado() {
    return this._jugadorSeleccionado;
  }
  
  public void setJugadorSeleccionado(final Jugador jugadorSeleccionado) {
    this._jugadorSeleccionado = jugadorSeleccionado;
  }
  
  private String _tipoHandicap;
  
  public String getTipoHandicap() {
    return this._tipoHandicap;
  }
  
  public void setTipoHandicap(final String tipoHandicap) {
    this._tipoHandicap = tipoHandicap;
  }
  
  public BusquedaJugadoresAppModel() {
    ArrayList<Jugador> _arrayList = new ArrayList<Jugador>();
    this.setJugadores(_arrayList);
    HomeJugadores _homeJugadores = this.getHomeJugadores();
    ArrayList<Jugador> _jugadoresAceptados = _homeJugadores.getJugadoresAceptados();
    this.setJugadores(_jugadoresAceptados);
  }
  
  public void search() {
    this.getHomeJugadores();
    String _tipoHandicap = this.getTipoHandicap();
    this.setTipoHandicap(_tipoHandicap);
    ArrayList<Jugador> _arrayList = new ArrayList<Jugador>();
    this.setResultados(_arrayList);
    HomeJugadores _homeJugadores = this.getHomeJugadores();
    Jugador _jugadorEjemplo = this.getJugadorEjemplo();
    List<Jugador> _search = _homeJugadores.search(_jugadorEjemplo);
    this.setResultados(_search);
  }
  
  public void clear() {
    this.setJugadorEjemplo(null);
  }
  
  public HomeJugadores getHomeJugadores() {
    ApplicationContext _instance = ApplicationContext.getInstance();
    return _instance.<HomeJugadores>getSingleton(Jugador.class);
  }
}
