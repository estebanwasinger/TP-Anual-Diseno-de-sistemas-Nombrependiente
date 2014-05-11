package test

import futbol5.Jugador
import futbol5.Partido
import inscripciones.Estandar
import org.junit.Before
import org.junit.Test
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import observers.EquipoCompletoObserver
import auxiliares.MessageSender
import observers.Notificacion
import observers.InscripcionObserver

class NotificacionesTest {
		Jugador jugador 
		Jugador amigo1
		Jugador amigo2
		Jugador amigo3
		Partido partido	
		
	@Before
	def void setUP() {
			jugador = new Jugador
			jugador.setTipoInscripcion(new Estandar)
			amigo1 = new Jugador
			amigo2 = new Jugador
			amigo3 = new Jugador
			jugador.agregarAmigo(amigo1)
			jugador.agregarAmigo(amigo2)
			jugador.agregarAmigo(amigo3)			
			partido = new Partido("Berazategui")
	}
		
	def armarPartido(int max) {
		var int a = 0
		while (a < max) {
			partido.inscribir(new Jugador)
			a = a + 1
		}
	}
	
	@Test
	def testJugadorSeInscribeYSeNotificaASusAmigos(){
		var mockMessageSender = mock(typeof(MessageSender))
		partido.agregarObserver(new InscripcionObserver(mockMessageSender))
		
		verify(mockMessageSender, times(0)).send(any(typeof(Notificacion)))
		partido.inscribir(jugador)
		verify(mockMessageSender, times(3)).send(any(typeof(Notificacion)))
	}
	
		@Test
	def testSeInscribeDecimoJugadorYSeNotificaAAdministrador(){
		var mockMessageSender = mock(typeof(MessageSender))
		partido.agregarObserver(new EquipoCompletoObserver(mockMessageSender))
		
		verify(mockMessageSender, times(0)).send(any(typeof(Notificacion)))
		armarPartido(9)
		partido.inscribir(jugador)
		verify(mockMessageSender, times(1)).send(any(typeof(Notificacion)))
	}
	
	@Test
	def testSeInscribeUnJugadorYNoSeNotificaAAdministrador(){
		var mockMessageSender = mock(typeof(MessageSender))
		partido.agregarObserver(new EquipoCompletoObserver(mockMessageSender))
		
		partido.inscribir(jugador)
		verify(mockMessageSender, times(0)).send(any(typeof(Notificacion))) // no se debe enviar notificacion
	}

	@Test
	def void testPartidoCon10JugadoresYSeBaja1(){
		var mockMessageSender = mock(typeof(MessageSender))
		partido.agregarObserver(new EquipoCompletoObserver(mockMessageSender))
		
		verify(mockMessageSender, times(0)).send(any(typeof(Notificacion)))
		armarPartido(9)
		partido.inscribir(jugador)
		verify(mockMessageSender, times(1)).send(any(typeof(Notificacion)))
		partido.bajaSinReemplazo(jugador)
		verify(mockMessageSender, times(2)).send(any(typeof(Notificacion))) 
		}
	}