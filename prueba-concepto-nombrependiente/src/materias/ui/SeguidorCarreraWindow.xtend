package materias.ui

import java.awt.Color
import materias.applicationModel.SeguidorCarrera
import materias.domain.Materia
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.bindings.PropertyAdapter

class SeguidorCarreraWindow extends SimpleWindow<SeguidorCarrera> {

	new(WindowOwner parent) {
		super(parent, new SeguidorCarrera)
		modelObject.search()
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Seguidor de carrera"
		taskDescription = "Ingrese los parámetros de búsqueda"
		
		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		panelEdicionMateria(mainPanel)
		
	}
	def void panelEdicionMateria(Panel mainPanel){
		
		new Label(mainPanel).setText("Materia:")
		new Label(mainPanel).bindValueToProperty("materiaSeleccionada.nombre")
		new Label(mainPanel).setText("Profesor")
		new TextBox(mainPanel).bindValueToProperty("materiaSeleccionada.profesor")
		new Label(mainPanel).setText("Año de cursada")
		new TextBox(mainPanel).bindValueToProperty("materiaSeleccionada.anioCursada")
		// este check DEBERIA habilitarse solo si estan cargadas las 3 notas con Aprobado en SI (validacion!)
		//se debe modificar despues de agregar la grilla o tabla de notas
		new Label(mainPanel).setText = "Final Aprobado"
		var checkAprobado = new CheckBox(mainPanel)
		checkAprobado.bindValueToProperty("materiaSeleccionada.finalAprobado")
		new Label(mainPanel).text = "Ubicacion Materia"/*
		new Selector(mainPanel) => [
			allowNull = false
			//bindItems(new ObservableProperty(this, "valoresPosibles"))
			bindValueToProperty("materiaSeleccionada.ubicacion")
//			bindValue(new ObservableProperty(this.modelObject, "tipo"))
		]
		//val selectorUbicacion = new Selector<String>(mainPanel)
		//selectorUbicacion.allowNull(false)
		//selectorUbicacion.bindValueToProperty("materiaSeleccionada.ubicacion")
		//var propiedadUbicaciones = selectorUbicacion.bindItems(new ObservableProperty(this.modelObject.materiaSeleccionada, "posiblesUbicaciones"))
		//propiedadUbicaciones.adapter = new PropertyAdapter(typeof(String), "descripcion")*/
		new Label(mainPanel).setText = "Notas de Cursada"
	}
	
	// *************************************************************************
	// * FORMULARIO DE BUSQUEDA
	// *************************************************************************
	/**
	 * El panel principal de búsuqeda permite filtrar por número o nombre
	 */
	override def void createFormPanel(Panel mainPanel) {
		var searchFormPanel = new Panel(mainPanel)
		searchFormPanel.setLayout(new ColumnLayout(2))

		var labelNombre = new Label(searchFormPanel)
		labelNombre.text = "Nombre de materia"
		labelNombre.foreground = Color::RED //esto se lo cambie para probar nada mas :P si lo dejamos negro no hay que ponerlo

		new TextBox(searchFormPanel).bindValueToProperty("nombre")
	}

	/**
	 * Acciones asociadas de la pantalla principal. Interesante para ver es cómo funciona el binding que mapea
	 * la acción que se dispara cuando el usuario presiona click Para que el binding sea flexible necesito
	 * decirle objeto al que disparo la acción y el mensaje a enviarle Contra: estoy atado a tener métodos sin
	 * parámetros. Eso me impide poder pasarle parámetros como en el caso del alta/modificación.
	 * Buscar/Limpiar -> son acciones que resuelve el modelo (BuscadorCelular) Nuevo -> necesita disparar una
	 * pantalla de alta, entonces lo resuelve la vista (this)
	 *
	 */
	override protected addActions(Panel actionsPanel) {

		new Button(actionsPanel)
			.setCaption("Buscar")
			.onClick [ | modelObject.search ] 
			.setAsDefault
			.disableOnError

		new Button(actionsPanel) 
			.setCaption("Limpiar")
			.onClick [ | modelObject.clear ]
			
		new Button(actionsPanel) //
			.setCaption("Nueva Materia")
			.onClick [ | this.crearMateria ]
			
	}

	// *************************************************************************
	// ** RESULTADOS DE LA BUSQUEDA
	// *************************************************************************
	/**
	 * Se crea la grilla en el panel de abajo El binding es: el contenido de la grilla en base a los
	 * resultados de la búsqueda Cuando el usuario presiona Buscar, se actualiza el model, y éste a su vez
	 * dispara la notificación a la grilla que funciona como Observer
	 */
	def protected createResultsGrid(Panel mainPanel) {
		var table = new Table<Materia>(mainPanel, typeof(Materia))
		table.heigth = 150 //mismo valor que la columna para que sea una sola (columna)
		table.width = 450
		table.bindItemsToProperty("resultados")
		table.bindValueToProperty("materiaSeleccionada")
		this.describeResultsGrid(table)
	}
	
		/**
	 * Define las columnas de la grilla Cada columna se puede bindear 1) contra una propiedad del model, como
	 * en el caso del número o el nombre 2) contra un transformer que recibe el model y devuelve un tipo
	 * (generalmente String), como en el caso de Recibe Resumen de Cuenta
	 *
	 * @param table
	 */
	def void describeResultsGrid(Table<Materia> table) {
		new Column<Materia>(table) //
			.setTitle("Nombre")
			.setFixedSize(450)
			.bindContentsToProperty("nombre")
	}	
		
	// ********************************************************
	// ** Acciones
	// ********************************************************
	def void crearMateria() {
		this.openDialog(new CrearMateriaWindow(this))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

}