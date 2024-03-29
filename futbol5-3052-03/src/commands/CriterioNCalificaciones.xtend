package commands

import futbol5.Jugador

class CriterioNCalificaciones extends CriteriosCommand{
	
	int n
	
	new(int n) {
		this.n = n
	}
		
	override (Jugador) => float criterioComparacion(){
		return [Jugador jugador | jugador.promedioNPartidos(n)]
	}
	
}