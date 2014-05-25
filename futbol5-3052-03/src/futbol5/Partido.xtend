package futbol5

import java.util.List
import java.util.LinkedList
import excepciones.BusinessException
import observers.PartidoObserver
import calificaciones.Calificacion
import auxiliares.RegistroRechazo

class Partido {

	@Property var String localidad
	@Property var LinkedList<Jugador> jugadores
	@Property var List<PartidoObserver> altasObservers
	@Property var List<PartidoObserver> bajasObservers
	@Property var Administrador administrador
	@Property var Sistema sistema
	@Property var LinkedList<Jugador> jugadoresRecomendados

	/****************/
	/*CONSTRUCTORES*/
	/****************/
	new(String localidad) {
		this.localidad = localidad
		jugadores = new LinkedList<Jugador>
		altasObservers = new LinkedList<PartidoObserver>
		bajasObservers = new LinkedList<PartidoObserver>
		jugadoresRecomendados = new LinkedList<Jugador>
		administrador = Administrador::getInstance()
		sistema = new Sistema
	}

	/********************/
	/*METODOS AUXILIARES*/
	/********************/
	def void notificarInscripcion(Jugador jugador) {
		altasObservers.forEach[observador|observador.notificarInscripcion(this, jugador)]
	}

	def void notificarBaja(Jugador jugador, Jugador reemplazo) {
		bajasObservers.forEach[observador|observador.notificarBaja(this, jugador, reemplazo)]
	}

	def int cantJugadores() {
		jugadores.size
	}

	def void agregarJugador(Jugador jugador) {
		this.jugadores.add(jugador)
	}

	def void eliminarJugador(Jugador jugador) {
		this.jugadores.remove(jugador)
	}

	def estaInscripto(Jugador jugador) {
		this.jugadores.contains(jugador)
	}

	def agregarObserverAlta(PartidoObserver observer) {
		this.altasObservers.add(observer)
	}

	def agregarObserverBaja(PartidoObserver observer) {
		this.bajasObservers.add(observer)
	}

	def quitarObserverAlta(PartidoObserver observer) {
		this.altasObservers.remove(observer)
	}

	def quitarObserverBaja(PartidoObserver observer) {
		this.bajasObservers.remove(observer)
	}
		
	/*******************************/
	/*CASO DE USO: NUEVOS JUGADORES */
	/*******************************/
def jugadorProponeA(Jugador jugador){
		this.jugadoresRecomendados.add(jugador)
	}
			
	/*******************************/
	/****CASO DE USO: CALIFICACIONES ****/
	/*******************************/
		def calificar (Jugador calificador, Jugador calificado, int nota, String critica){
		var Calificacion calificacion
		
		if (!estaInscripto(calificado)){
				throw new BusinessException("El jugador que se quiere calificar no jugo el partido indicado")
				}
		if (!estaInscripto(calificador)){
				throw new BusinessException("No podes calificar a un jugador de un partido si no estas inscripto al mismo")
				}
		calificacion.generar(calificador, calificado, nota, critica, this)
		calificado.calificaciones.add(calificacion)
	}

	/*******************************/
	/*CASO DE USO: BAJA DE UN JUGADOR*/
	/*******************************/
	def baja(Jugador jugador, Jugador reemplazo) {
		if (!estaInscripto(jugador)) {
			throw new BusinessException("El jugador no esta inscripto en este partido, no se puede dar de baja")
		}
		if (reemplazo != null && this.estaInscripto(reemplazo)) {
			throw new BusinessException("El reemplazo ya esta inscripto en el partido")
		}
		eliminarJugador(jugador)
		if (reemplazo != null) {
			jugadores.add(reemplazo)
		}
		notificarBaja(jugador, reemplazo)
		notificarInscripcion(reemplazo)
	}

	def bajaSinReemplazo(Jugador jugador) {
		baja(jugador, null)
	}

	/**************************************/
	/*CASO DE USO: INSCRIPCION DE UN JUGADOR */
	/**************************************/
	def inscribir(Jugador jugador) {
		if (this.estaInscripto(jugador)) {
			throw new BusinessException("El jugador ya se inscribio")
		}
		if (!jugador.tipoInscripcion.cumpleCondicion(jugador, this)) {
			throw new BusinessException("El jugador no cumple con la condicion, no se puede inscribir")
		}
		if (this.cantJugadores < 10) {
			this.agregarJugador(jugador)
			notificarInscripcion(jugador)
			return
		}
		if (!this.jugadores.exists[inscripto|jugador.tieneMasPrioridadQue(inscripto)]) {
			throw new BusinessException("No hay mas cupo")
		}

		val quien = this.jugadores.filter[unJugador|unJugador.prioridad > jugador.prioridad].head
		this.eliminarJugador(quien)
		this.agregarJugador(jugador)
		this.notificarInscripcion(jugador)
	}
}
