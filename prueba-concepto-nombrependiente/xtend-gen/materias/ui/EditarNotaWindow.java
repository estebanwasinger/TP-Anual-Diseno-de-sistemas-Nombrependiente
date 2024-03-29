package materias.ui;

import materias.domain.Nota;
import org.uqbar.arena.layout.ColumnLayout;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.CheckBox;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.TextBox;
import org.uqbar.arena.windows.Dialog;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;

@SuppressWarnings("all")
public class EditarNotaWindow extends Dialog<Nota> {
  private TextBox fechaBox;
  
  public EditarNotaWindow(final WindowOwner owner, final Nota nota) {
    super(owner, ((Nota) nota.clone()));
  }
  
  protected void createFormPanel(final Panel mainPanel) {
    this.setTitle("Editar nota");
    final Panel form = new Panel(mainPanel);
    ColumnLayout _columnLayout = new ColumnLayout(2);
    form.setLayout(_columnLayout);
    Label _label = new Label(form);
    _label.setText("Fecha");
    TextBox _textBox = new TextBox(form);
    this.fechaBox = _textBox;
    this.fechaBox.<ControlBuilder>bindValueToProperty("fecha");
    Label _label_1 = new Label(form);
    _label_1.setText("Descripción");
    TextBox _textBox_1 = new TextBox(form);
    _textBox_1.<ControlBuilder>bindValueToProperty("descripcion");
    Label _label_2 = new Label(form);
    _label_2.setText("Aprobado");
    CheckBox _checkBox = new CheckBox(form);
    _checkBox.<ControlBuilder>bindValueToProperty("aprobado");
  }
  
  protected void addActions(final Panel actions) {
    Button _button = new Button(actions);
    Button _setCaption = _button.setCaption("Aceptar");
    final Action _function = new Action() {
      public void execute() {
        EditarNotaWindow.this.accept();
      }
    };
    Button _onClick = _setCaption.onClick(_function);
    Button _setAsDefault = _onClick.setAsDefault();
    _setAsDefault.disableOnError();
    Button _button_1 = new Button(actions);
    Button _setCaption_1 = _button_1.setCaption("Cancelar");
    final Action _function_1 = new Action() {
      public void execute() {
        EditarNotaWindow.this.cancel();
      }
    };
    _setCaption_1.onClick(_function_1);
  }
}
