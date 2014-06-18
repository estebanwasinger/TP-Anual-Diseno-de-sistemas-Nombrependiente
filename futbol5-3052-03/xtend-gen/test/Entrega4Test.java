package test;

import commands.AlgoritmoImparPar;
import commands.AlgoritmoLoco;
import commands.CriterioCalifiUltimoPartido;
import commands.CriterioHandicap;
import commands.CriterioNCalificaciones;
import commands.CriteriosCommand;
import excepciones.BusinessException;
import futbol5.Jugador;
import futbol5.Partido;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings("all")
public class Entrega4Test {
  private Jugador jugador1;
  
  private Jugador jugador2;
  
  private Jugador jugador3;
  
  private Jugador jugador4;
  
  private Jugador jugador5;
  
  private Jugador jugador6;
  
  private Jugador jugador7;
  
  private Jugador jugador8;
  
  private Jugador jugador9;
  
  private Jugador jugador10;
  
  private Jugador jugadorCalificado;
  
  private Partido partido;
  
  private Partido partido2;
  
  private Partido partido3;
  
  private CriterioHandicap handicap;
  
  private AlgoritmoImparPar algoritmoImparPar;
  
  private AlgoritmoLoco algoritmoLoco;
  
  private CriterioCalifiUltimoPartido criterioCalificacionUltimoPartido;
  
  private CriterioNCalificaciones criterioNCalificaciones;
  
  @Before
  public void setUP() {
    Jugador _jugador = new Jugador();
    this.jugador1 = _jugador;
    Jugador _jugador_1 = new Jugador();
    this.jugador2 = _jugador_1;
    Jugador _jugador_2 = new Jugador();
    this.jugador3 = _jugador_2;
    Jugador _jugador_3 = new Jugador();
    this.jugador4 = _jugador_3;
    Jugador _jugador_4 = new Jugador();
    this.jugador5 = _jugador_4;
    Jugador _jugador_5 = new Jugador();
    this.jugador6 = _jugador_5;
    Jugador _jugador_6 = new Jugador();
    this.jugador7 = _jugador_6;
    Jugador _jugador_7 = new Jugador();
    this.jugador8 = _jugador_7;
    Jugador _jugador_8 = new Jugador();
    this.jugador9 = _jugador_8;
    Jugador _jugador_9 = new Jugador();
    this.jugador10 = _jugador_9;
    this.jugador1.setNivelDeJuego(5);
    this.jugador2.setNivelDeJuego(9);
    this.jugador3.setNivelDeJuego(10);
    this.jugador4.setNivelDeJuego(7);
    this.jugador5.setNivelDeJuego(8);
    this.jugador6.setNivelDeJuego(6);
    this.jugador7.setNivelDeJuego(7);
    this.jugador8.setNivelDeJuego(4);
    this.jugador9.setNivelDeJuego(8);
    this.jugador10.setNivelDeJuego(3);
    Partido _partido = new Partido("CABA");
    this.partido = _partido;
    CriterioHandicap _criterioHandicap = new CriterioHandicap();
    this.handicap = _criterioHandicap;
    Partido _partido_1 = new Partido("CABA");
    this.partido2 = _partido_1;
    Partido _partido_2 = new Partido("Burzaco");
    this.partido3 = _partido_2;
    AlgoritmoImparPar _algoritmoImparPar = new AlgoritmoImparPar();
    this.algoritmoImparPar = _algoritmoImparPar;
    AlgoritmoLoco _algoritmoLoco = new AlgoritmoLoco();
    this.algoritmoLoco = _algoritmoLoco;
    CriterioCalifiUltimoPartido _criterioCalifiUltimoPartido = new CriterioCalifiUltimoPartido();
    this.criterioCalificacionUltimoPartido = _criterioCalifiUltimoPartido;
    CriterioNCalificaciones _criterioNCalificaciones = new CriterioNCalificaciones();
    this.criterioNCalificaciones = _criterioNCalificaciones;
    this.partido.inscribir(this.jugador1);
    this.partido.inscribir(this.jugador2);
    this.partido.inscribir(this.jugador3);
    this.partido.inscribir(this.jugador4);
    this.partido.inscribir(this.jugador5);
    this.partido.inscribir(this.jugador6);
    this.partido.inscribir(this.jugador7);
    this.partido.inscribir(this.jugador8);
    this.partido.inscribir(this.jugador9);
    this.partido.inscribir(this.jugador10);
  }
  
  public void armarPartido(final int max, final Partido partido) {
    int a = 0;
    boolean _while = (a < max);
    while (_while) {
      {
        Jugador _jugador = new Jugador();
        this.jugadorCalificado = _jugador;
        partido.inscribir(this.jugadorCalificado);
        this.jugadorCalificado.calificar(partido, 8, "muy bueno");
        a = (a + 1);
      }
      _while = (a < max);
    }
  }
  
  @Test
  public void testPartidoOrdenaPorHandicap() {
    this.partido.ordenarJugadores(this.handicap);
    List<Jugador> _jugadoresOrdenados = this.partido.getJugadoresOrdenados();
    final Consumer<Jugador> _function = new Consumer<Jugador>() {
      public void accept(final Jugador jugador) {
        float _nivelDeJuego = jugador.getNivelDeJuego();
        InputOutput.<Float>println(Float.valueOf(_nivelDeJuego));
      }
    };
    _jugadoresOrdenados.forEach(_function);
  }
  
  @Test(expected = BusinessException.class)
  public void testPartidoOrdenaPorHandicapExcepcion() {
    this.jugador10.setNivelDeJuego(0);
    this.partido.ordenarJugadores(this.handicap);
  }
  
  @Test
  public void testPartidoMixDeCriterios() {
    List<CriteriosCommand> criterios = new ArrayList<CriteriosCommand>();
    criterios.add(this.handicap);
    criterios.add(this.handicap);
    this.partido.ordenarJugadores(criterios, 3);
    List<Jugador> _jugadoresOrdenados = this.partido.getJugadoresOrdenados();
    final Consumer<Jugador> _function = new Consumer<Jugador>() {
      public void accept(final Jugador jugador) {
        float _nivelDeJuego = jugador.getNivelDeJuego();
        InputOutput.<Float>println(Float.valueOf(_nivelDeJuego));
      }
    };
    _jugadoresOrdenados.forEach(_function);
  }
  
  @Test(expected = BusinessException.class)
  public void testOrdenarJugadoresMenoresADiez() {
    this.armarPartido(9, this.partido2);
    this.partido2.ordenarJugadores(this.handicap);
  }
  
  /**
   * @Test
   * def void testDividirGrupoCasoLoco(){
   * armarPartido(10, partido3)
   * partido3.dividirEquipos(algoritmoLoco)
   * }
   */
  @Test(expected = BusinessException.class)
  public void testDividirGrupoMenor10() {
    this.armarPartido(9, this.partido2);
    this.partido2.dividirEquipos(this.algoritmoImparPar);
  }
  
  @Test(expected = BusinessException.class)
  public void testDividirGrupoMenor10CasoLoco() {
    this.armarPartido(9, this.partido2);
    this.partido2.dividirEquipos(this.algoritmoLoco);
  }
  
  @Test
  public void testOrdenarJugadoresPorUltimoPromedio() {
    this.armarPartido(10, this.partido2);
    this.partido2.ordenarJugadores(this.criterioCalificacionUltimoPartido);
  }
  
  @Test
  public void testOrdenarJugadoresPorPromedioNPartidos() {
    this.armarPartido(10, this.partido2);
    this.armarPartido(10, this.partido);
    this.armarPartido(10, this.partido3);
    this.partido2.ordenarJugadores(this.criterioNCalificaciones);
  }
}
