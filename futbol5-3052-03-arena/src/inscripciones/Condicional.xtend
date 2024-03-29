package inscripciones

import condiciones.Condicion
import futbol5.domain.Jugador
import futbol5.domain.Partido

class Condicional implements TipoInscripcion {
	@Property Condicion condicion
	@Property Partido partidoAInscribirse
		
	new(Partido partido, Condicion laCondicion) {
		this.partidoAInscribirse = partido
		this.condicion = laCondicion		
	}
		
override cumpleCondicion(Jugador jugador, Partido partidoAInscribirse){
		condicion.seCumple(jugador, partidoAInscribirse)
	}

	override prioridad() {
		3
	}

}
