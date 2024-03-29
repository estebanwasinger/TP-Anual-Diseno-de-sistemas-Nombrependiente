package materias.ui

import org.uqbar.arena.windows.WindowOwner
import materias.domain.Nota
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.CheckBox
import materias.domain.Materia

class CrearNotaWindow extends Dialog<Nota>{
	var TextBox fechaBox
	var Materia materiaSeleccionada
	var Nota notaNueva
	
	new(WindowOwner owner, Nota nota,Materia materia) {
		super(owner, nota)
		notaNueva = nota
		materiaSeleccionada = materia
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Editar nota"
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		println(materiaSeleccionada.nombre)
		new Label(form).text = "Fecha"
		fechaBox = new TextBox(form)
		fechaBox.bindValueToProperty("fecha")
		new Label(form).text = "Descripción"
		new TextBox(form).bindValueToProperty("descripcion")
		
		new CheckBox(form).bindValueToProperty("aprobado")
		new Label(form).text = "Aprobado"
		}

	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [|this.accept
				this.guardarNota()
			]
			.setAsDefault.disableOnError

	new Button(actions) 
		.setCaption("Cancelar")
		.onClick [|this.cancel]
	}
	
	def void guardarNota(){
		if(notaNueva.aprobado != true) notaNueva.aprobado = false
			materiaSeleccionada.notas.add(notaNueva)	
	}
}