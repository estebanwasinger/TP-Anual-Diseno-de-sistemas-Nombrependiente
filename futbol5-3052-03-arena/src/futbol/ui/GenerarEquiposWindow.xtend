package futbol.ui

import futbol5.Partido
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import java.util.List
import materias.applicationModel.SeguidorCarrera
import materias.domain.Materia
import materias.domain.Nota
import materias.home.HomeMaterias
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.MainWindow
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable
import futbol5.Jugador

@Observable
class GenerarEquiposWindow extends SimpleWindow<Partido> {
	
	new(WindowOwner parent, Partido model) {
		super(parent, model)
	}
	
	new(RunnableTest parent) {
		super(parent, new Partido)
	}
	
	override protected addActions(Panel actionPanel) {
		actionPanel.layout = new HorizontalLayout
		new Button(actionPanel)
			.setCaption("Cancelar")
			
		new Button(actionPanel)
			.setCaption("Aceptar")
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Generar Equipo"

		/* Creacion panel GENERAR EQUIPOS */
		mainPanel.layout = new VerticalLayout
		val botoneraSuperior = new Panel(mainPanel)
		botoneraSuperior.layout = new HorizontalLayout
		val panelListaJugadores = new Panel(mainPanel)
		panelListaJugadores.layout = new ColumnLayout(2)
		
		createBotonera(botoneraSuperior)
		createListaJugadores(panelListaJugadores)
	}
	
	def void createBotonera(Panel botoneraSuperior){
		val selectorOrdenamiento = new Selector(botoneraSuperior)=>[width = 200
			title ="hola"
		]
		val selectorOrdenamiento2 = new Selector(botoneraSuperior).width = 200
		val botonGenerar = new Button(botoneraSuperior) => [
			width = 200
			caption = "Generar Equipos"
		]
	}
	
	def void createListaJugadores(Panel panelJugadores){
		var table = new Table<Jugador>(panelJugadores, typeof(Jugador))
		table.heigth = 200
		table.width = 450
		new Column<Jugador>(table) //
			.setTitle("Nombre")
			.setFixedSize(150)
		//	.bindContentsToProperty("nombre")
		new Column<Jugador>(table) //
			.setTitle("Nombre")
			.setFixedSize(150)
		//	.bindContentsToProperty("nombre")
	}
}
