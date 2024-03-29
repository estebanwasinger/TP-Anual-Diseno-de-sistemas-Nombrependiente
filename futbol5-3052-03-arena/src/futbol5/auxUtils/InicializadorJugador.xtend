package futbol5.auxUtils

import futbol5.domain.Jugador
import java.util.ArrayList
import calificaciones.Calificacion
import infracciones.Infraccion
import java.text.SimpleDateFormat

class InicializadorJugador {	
	
	def static ArrayList<Jugador> crearListaDejugadores(int max){
		var ArrayList<Jugador> jugadores
		var int a = 0
		jugadores = new ArrayList<Jugador>
		while (a < max) {
			jugadores.add(new Jugador(nombreRandom(), apodoRandom,21,fechaRandom, handicapRandom(), listaAmigos(15), listaCalificaciones(nRan(2,9)),nRan(2,6)))
			crearListaNotificacioens(jugadores.get(a))
			a = a + 1
	}
	return jugadores
	}
	
	def static crearListaNotificacioens(Jugador jugador){
		var int a = 0;
		var SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
		var String[] arrayFechas = #["12/11/2013 13:00:20","12/02/2014 15:21:29","12/09/2014 09:07:59","18/12/2013 12:00:09","09/01/2014 19:32:16","24/11/2013 21:08:20"]
		var String[] arrayMotivos = #["Agresivo","Tramposo","Insulto a un compañero","Golpeo a un compañero","Llego tarde","Ausente - Sin aviso", "Ausente - Con aviso"]
		while(a<5){
			var unMotivo = arrayMotivos.get(nRan(0,7))
			var unaFecha = formateador.parse(arrayFechas.get(nRan(0,6)))
			
			jugador.agregarInfraccion(new Infraccion(unMotivo,unaFecha))
			a = a+1
		}
	}	

	def static String nombreRandom(){
		var String[] arrayNombres = #["Caro","Esteban","Vero","Pau","Jorge","Rodrigo","Jose","Catalina","Luisa","Carlo","Ronaldo","Jean Carlos","Pepe","El Willy","Marcos"]
		arrayNombres.get( 0 + (Math.random()*10)as int)
	}
	
	def static String apodoRandom(){
		var String[] arrayApodos = #["Carolinita","Estabnquito","Saeta","Hacha","Durex","El Mago","El messi","Fantasma","Sanguche","Sin piernas","Tronco","Estaca","El 10","Correcaminos","Saca corchos","Barriga","Colorado","Negro"]
		arrayApodos.get( nRan(0,18))
	}
	
	def static String fechaRandom(){
		var String[] arrayFechas = #["09-01-1991","09-01-1993","09-01-1999","09-01-2000","09-01-2003","09-01-1997","09-01-1987","09-01-2006","09-01-2007","09-01-2009"]
		arrayFechas.get( nRan(0,10))
	}
	
	def static listaAmigos(int max){
		var ArrayList<Jugador> amigos
		var int a = 0
		amigos = new ArrayList<Jugador>
		while (a < max) {
			amigos.add(new Jugador(nombreRandom(), apodoRandom, handicapRandom(),listaCalificaciones(nRan(2,9))))
			a = a + 1
	}
	return amigos
	}
	
		def static int handicapRandom(){
		 nRan(1,10)
	}
	
	def static int nRan(int min, int max){
		 min + (Math.random()*max)as int
	}
	
	def static listaCalificaciones(int max){
		var int a=0
		var calificaciones = new ArrayList<Calificacion>
		while (a<max){
			calificaciones.add(new Calificacion(nRan(1,9)))
			a=a+1
		}
		return calificaciones
		}
}
