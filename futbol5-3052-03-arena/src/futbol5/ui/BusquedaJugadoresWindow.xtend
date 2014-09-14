package futbol5.ui

import futbol5.domain.Jugador
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.bindings.DateAdapter
import futbol5.applicationModel.Futbol5
import org.uqbar.arena.windows.MainWindow
import org.uqbar.commons.utils.ApplicationContext
import futbol5.homes.HomeJugadores

@Observable
class BusquedaJugadoresWindow extends SimpleWindow<Futbol5>{
		new(WindowOwner parent,Futbol5 model) {
		super(parent, model)
	}
	
	new(RunnableBusquedaJugadores parent) {
		super(parent, new  Futbol5)
	}
					
	override createContents(Panel mainPanel) {
		
		title = "Busqueda de Jugadores"
		var panel2Columnas = new Panel(mainPanel)
		panel2Columnas.setLayout(new ColumnLayout(2))
		var panelIzquierda = new Panel(panel2Columnas) // divido la vista principal en dos paneles
		var panelDerecha = new Panel(panel2Columnas)
		new Label(panelIzquierda) => [
			text = "Busqueda" //le doy un titulo al panel izquierdo que va a contener los tipos de busqueda
			fontSize = 20
			]
		new Label(panelDerecha) => [
			text = "Resultados" //le doy un titulo al panel derecho que va a mostrar los resultados de la busqueda
			fontSize = 20
		]
		
		addActions(mainPanel) 
		createFormPanel(panelIzquierda)
		grillaBasicaJugadores(panelDerecha)
	}
	
	override protected addActions(Panel actionPanel) {
		actionPanel.layout = new HorizontalLayout
		new Button(actionPanel)
			.setCaption("Regresar")
	}
	
	
	override void createFormPanel(Panel panelIzquierda) {
		title = "Busqueda Jugador"

		panelIzquierda.layout = new VerticalLayout
		val busquedaSuperior = new Panel(panelIzquierda)
		busquedaSuperior.layout = new VerticalLayout
		
		val panelBusquedaJugadores = new Panel(panelIzquierda)
		panelBusquedaJugadores.layout = new ColumnLayout(2)
		
		criteriosDeBusqueda(busquedaSuperior)

	}
	
	def void criteriosDeBusqueda(Panel busquedaSuperior){
		
		// Por nombre “comienza con” //
		var labelNombre = new Label(busquedaSuperior)
		labelNombre.text = "Nombre Jugador" //hay que afinar el "comienza con"
		

		new TextBox(busquedaSuperior)=>
			[bindValueToProperty("nombre")
			width = 200]
		
		//Por apodo “contiene” //	
		var labelApodo = new Label(busquedaSuperior)
		labelApodo.text = "Apodo Jugador" //hay que afinar el "contiene"

		new TextBox(busquedaSuperior)=>
			[bindValueToProperty("apodo")
			width = 200]	
			
		// Búsqueda por fecha de nacimiento “anterior a” //
		var labelFechaNacimiento = new Label(busquedaSuperior)
		labelFechaNacimiento.text = "Fecha de nacimiento menor a:" //hay que afinar el "contiene"

		new TextBox(busquedaSuperior)=>
			[bindValueToProperty("fechaNacimiento")
			width = 200]	
			
		//Por rango desde/hasta del hándicap (puede ingresarse sólo desde, o sólo hasta) //
		//Por rango desde/hasta del promedio de último partido //
		//Filtrar sólo los que tuvieron infracciones, sólo los que no tuvieron infracciones, todos //
			
		new Button(busquedaSuperior)
			.setCaption("Buscar")
			.onClick [ | modelObject.search ]
			.setFontSize(12)
			.setWidth = 200
			
		new Button(busquedaSuperior) 
			.setCaption("Limpiar")
			.onClick [ | modelObject.clear ]
			.setFontSize(12)
			.setWidth = 200
		
	}
	
	def void grillaBasicaJugadores(Panel panelJugadores){
		var table = new Table<Jugador>(panelJugadores, typeof(Jugador))
		table.heigth = 200
		table.width = 590
		table.bindValueToProperty("seleccionJugador")
		new Column<Jugador>(table) //
			.setTitle("Nombre")
			.setFixedSize(150)
			.bindContentsToProperty("nombre")
		new Column<Jugador>(table) //
			.setTitle("Apodo")
			.setFixedSize(150)
			.bindContentsToProperty("apodo")
		new Column<Jugador>(table) //
			.setTitle("Handicap")
			.setFixedSize(150)
			.bindContentsToProperty("nivelDeJuego")
		new Column<Jugador>(table) //
			.setTitle("Promedio")
			.setFixedSize(150)
		//	.bindContentsToProperty("nombre")
	}
		
}