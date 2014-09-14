package futbol5.ui

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import org.uqbar.commons.utils.ApplicationContext
import futbol5.domain.Partido
import futbol5.domain.Jugador

class RunnableBusquedaJugadores extends Application {
	
	static def void main(String[] args) { 
		new RunnableBusquedaJugadores().start()
	}

	override protected Window<?> createMainWindow() {
		//ApplicationContext.instance.configureSingleton(typeof(Modelo), new HomeModelos)
		//ApplicationContext.instance.configureSingleton(typeof(Celular), new HomeCelulares)
	//	var Partido partidoEjemplo = new Partido("San Miguel")
	//	partidoEjemplo.agregarJugador(new Jugador("Esteban"))
	//	partidoEjemplo.agregarJugador(new Jugador("Carolina"))
		
		
		
		return new BusquedaJugadoresWindow(this)
	}
}
	