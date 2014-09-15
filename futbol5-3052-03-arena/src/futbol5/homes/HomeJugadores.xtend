package futbol5.homes

import auxiliares.RegistroRechazo
import calificaciones.Calificacion
import futbol5.domain.Jugador
import infracciones.Infraccion
import inscripciones.TipoInscripcion
import java.util.LinkedList
import java.util.List
import org.uqbar.commons.model.CollectionBasedHome
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import java.util.Date
import inscripciones.Estandarimport java.text.SimpleDateFormat

@Observable
class HomeJugadores extends CollectionBasedHome<Jugador> {
	
	@Property var List<Jugador> jugadoresAceptados
	@Property var List<RegistroRechazo> jugadoresRechazados
	@Property var LinkedList<Jugador> jugadoresRecomendados
	SimpleDateFormat formateador = new SimpleDateFormat("dd-MM-yyyy");

	new() {
		this.init
	}

	def void init() {
 		jugadoresAceptados = new LinkedList<Jugador>
		jugadoresRechazados = new LinkedList<RegistroRechazo>
		jugadoresRecomendados = new LinkedList<Jugador>
	}

	def void createJugadorCompleto(String nombre, TipoInscripcion tipoInscripcion, int edad, List<Infraccion> infracciones, List<Jugador> amigos, List <Calificacion> calificaciones,float nivelDeJuego,int criterioComparacion, String apodo, Date fechaDeNacimiento){
		var jugador = new Jugador
		jugador.nombre = nombre
		jugador.tipoInscripcion = tipoInscripcion
		jugador.edad = edad
		jugador.infracciones = infracciones
		jugador.amigos = amigos
		jugador.calificaciones = calificaciones
		jugador.nivelDeJuego = nivelDeJuego
		jugador.criterioComparacion = criterioComparacion
		jugador.apodo = apodo
		jugador.fechaNacimiento = fechaDeNacimiento
		
		jugadoresAceptados.add(jugador)
	}
	
	
	def void create(String nombre,String apodo, int edad, String fechaDeNacimientoStr){
		var jugador = new Jugador
		jugador.nombre = nombre
		jugador.apodo = apodo
		jugador.edad = edad
		jugador.fechaNacimiento = formateador.parse(fechaDeNacimientoStr)	
		
		jugadoresAceptados.add(jugador)
	}
	
	def void agregarAceptado(Jugador jugador){
		jugadoresAceptados.add(jugador)
	}
	
//	override void validateCreate(Jugador jugador) {
//		jugador.validarNombre()
//		validarMateriasDuplicadas(jugador)
//	}
	
//	def void validarMateriasDuplicadas(Jugador jugador) {
//		val nombre = jugador.nombre
//		if (!this.search(nombre).isEmpty) {
//			throw new UserException("Ya existe una jugador con el nombre " + nombre)
//		}
//	}

	def List<Jugador> getJugadores(){
		jugadoresAceptados
	}
	
	def search(Jugador jugadorBuscado) {
		jugadoresAceptados.filter[jugador|this.match(jugador,jugadorBuscado)].toList
	}
	
	def match(Jugador jugadorEnLista, Jugador jugadorBuscado) {
		if (jugadorBuscado.nombre == null) {
		} 
		else {
			if(!jugadorEnLista.nombre.toLowerCase.startsWith(jugadorBuscado.nombre.toLowerCase)) return false
		}
		
		if (jugadorBuscado.apodo == null) {
		} 
		else {
			if(!jugadorEnLista.apodo.toLowerCase.contains(jugadorBuscado.apodo.toLowerCase)) return false
		}
		
		if(jugadorBuscado.fechaNacimiento == null){}else{
		if(jugadorBuscado.fechaNacimiento < jugadorEnLista.fechaNacimiento) {
			return false
			}
		}
		return true
	}

	override def getEntityType() {
		typeof(Jugador)
	}

	override def createExample() {
	new Jugador
	}

	override def getCriterio(Jugador example) {
		null
	}
	
	
}