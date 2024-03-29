package futbol5.ui

import commands.AlgoritmoImparPar
import commands.AlgoritmoLoco
import commands.CriterioCalifiUltimoPartido
import commands.CriterioHandicap
import commands.CriterioNCalificaciones
import commands.CriteriosCommand
import commands.DivisionDeEquiposCommand
import futbol5.domain.Jugador
import futbol5.domain.Partido
import java.util.ArrayList
import java.util.LinkedList
import java.util.List
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.windows.SimpleWindow

@Observable
class GenerarEquiposWindow extends SimpleWindow<Partido> {
	@Property List<DivisionDeEquiposCommand> listaCritDivision
	@Property List<CriteriosCommand> listaCritOrdenamiento

	new(WindowOwner parent, Partido model) {
		super(parent, model)

		// Llevarlo a un método
		listaCritDivision = new LinkedList<DivisionDeEquiposCommand>
		getListaCritDivision.add(new AlgoritmoImparPar)
		getListaCritDivision.add(new AlgoritmoLoco)

		// Llevarlo a un mètodo
		listaCritOrdenamiento = new LinkedList<CriteriosCommand>
		getListaCritOrdenamiento.add(new CriterioCalifiUltimoPartido)
		getListaCritOrdenamiento.add(new CriterioHandicap)
		getListaCritOrdenamiento.add(new CriterioNCalificaciones(3))
	}

	override protected addActions(Panel actionPanel) {
		actionPanel.layout = new HorizontalLayout
		new Button(actionPanel).setCaption("Aceptar").onClick[|
			this.close
		].setAsDefault.disableOnError
		
		new Button(actionPanel).setCaption("Confirmar Equipos").onClick[|
			modelObject.confirmarEquipos(true)
			ObservableUtils.firePropertyChanged(modelObject, "estado", modelObject.estado)
		].bindEnabledToProperty("estado")

		var buscar = new Button(actionPanel).setCaption("Buscar Jugador").onClick[|this.buscarJugador]

		var elementSelected = new NotNullObservable("jugadorSeleccionado")
		buscar.bindEnabled(elementSelected)

	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Generar Equipo"

		/* Creacion panel GENERAR EQUIPOS */
		mainPanel.layout = new VerticalLayout
		val botoneraSuperior = new Panel(mainPanel)
		botoneraSuperior.layout = new HorizontalLayout
		val panelListaJugadores = new Panel(mainPanel)
		panelListaJugadores.layout = new ColumnLayout(3)
		val panelSelector1 = new Panel(botoneraSuperior)
		panelSelector1.layout = new VerticalLayout
		val panelSelector2 = new Panel(botoneraSuperior)
		panelSelector2.layout = new VerticalLayout
		val panelSelector3 = new Panel(botoneraSuperior)
		panelSelector3.layout = new VerticalLayout

		crearSelectoresCommands(panelSelector1, panelSelector2)

		crearBotonGenerar(panelSelector3)

		createListaJugadores(panelListaJugadores)
	}

	private def crearBotonGenerar(Panel panelSelector3) {
		new Button(panelSelector3) => [
			width = 200
			heigth = 45
			bindEnabledToProperty("estado")
			caption = "Generar Equipos"
			onClick[ |
				modelObject.equipoA = new ArrayList<Jugador>
				modelObject.ordenarJugadores(modelObject.algoritmoOrdenamiento)
				modelObject.dividirEquipos(modelObject.algoritmoDivision)
				ObservableUtils.firePropertyChanged(modelObject, "equipoA", modelObject.equipoA)
				ObservableUtils.firePropertyChanged(modelObject, "equipoB", modelObject.equipoB)
			]
		]
	}

	def crearSelectoresCommands(Panel panelSelector1, Panel panelSelector2) {
		new Label(panelSelector1).text = "Criterio de Selección"
		val selectorCritDivision = new Selector<DivisionDeEquiposCommand>(panelSelector1) => [
			width = 200
			allowNull(false)
			bindValueToProperty("algoritmoDivision")
		]
		var propiedadDivision = selectorCritDivision.bindItems(new ObservableProperty(this, "listaCritDivision"))
		propiedadDivision.adapter = new PropertyAdapter(typeof(DivisionDeEquiposCommand), "nombre")

		new Label(panelSelector2).text = "Criterio de Ordenamiento"
		val selectorCritOrdeamiento = new Selector<CriteriosCommand>(panelSelector2) => [
			allowNull(false)
			width = 200
			bindValueToProperty("algoritmoOrdenamiento")
		]
		var propiedadOrdenamiento = selectorCritOrdeamiento.bindItems(
			new ObservableProperty(this, "listaCritOrdenamiento"))
		propiedadOrdenamiento.adapter = new PropertyAdapter(typeof(CriteriosCommand), "nombre")
	}

	def void createListaJugadores(Panel panelJugadores) {

		new Label(panelJugadores) => [
			text = "Jugadores"
			fontSize = 20
		]

		new Label(panelJugadores) => [
			text = "Equipo A"
			fontSize = 20
		]

		new Label(panelJugadores) => [
			text = "Equipo B"
			fontSize = 20
		]

		var tableListaInscriptos = new Table<Jugador>(panelJugadores, typeof(Jugador))
		tableListaInscriptos.heigth = 200
		tableListaInscriptos.width = 285
		tableListaInscriptos.bindItemsToProperty("jugadores")
		tableListaInscriptos.bindValueToProperty("jugadorSeleccionado")
		new Column<Jugador>(tableListaInscriptos).setTitle("Nombre").bindContentsToProperty("nombre")

		createTableEquipo(panelJugadores, "equipoA")
		createTableEquipo(panelJugadores, "equipoB")
	}

	private def createTableEquipo(Panel panelJugadores, String teamToBind) {
		val tableListaEquipoA = new Table<Jugador>(panelJugadores, typeof(Jugador))
		tableListaEquipoA.heigth = 200
		tableListaEquipoA.width = 285
		tableListaEquipoA.bindItemsToProperty(teamToBind)
		new Column<Jugador>(tableListaEquipoA).setTitle("Nombre").bindContentsToProperty("nombre")
	}

	def void buscarJugador() {
		this.openDialog(new VerDatosJugadorWindow(this, modelObject.jugadorSeleccionado))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|]
		dialog.open
	}
}
