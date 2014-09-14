package observers

import auxiliares.MessageSender
import futbol5.domain.Jugador
import futbol5.domain.Partido

class InscripcionObserver extends PartidoObserver{
	
	new(MessageSender unMessageSender) {
		super(unMessageSender)
	}
	
	def  avisarle(Jugador emisor, Jugador receptor){
		val asunto=	"Inscripcion de un amigo"
		val mensaje= emisor.email + "se inscribio al partido"
		enviarNotificacion(receptor.email, asunto, mensaje)
	}
	
	override notificarInscripcion(Partido partido, Jugador jugador) {
        	jugador.amigos.forEach[ amigo | (avisarle(jugador, amigo)) ]
		}
	}
