public class Window : Gtk.ApplicationWindow {
    private Gtk.ComboBoxText comboboxtext;
    private Gtk.Grid grid;
	private Gtk.SpinButton spin;
	private Gtk.Label numpoints_lbl;
    private Gtk.Label pi_lbl;
    private Gtk.Label epi_lbl;
	private Gtk.Button buttonDraw;
	private Gtk.Button buttonAbout;
	private Gtk.Separator separator;
	private Gtk.DrawingArea drawing_area;
	private Gtk.Statusbar statusBar;
	private string selection;

	internal Window (Driver app) {
		Object (application: app);

		grid = new Gtk.Grid();
		grid.set_column_spacing(15);
		grid.set_row_spacing(10);
        this.add(grid);

		comboboxtext = new Gtk.ComboBoxText();
		comboboxtext.append_text("Uniform");
        comboboxtext.append_text("Normal");
        comboboxtext.set_active(0);
        comboboxtext.show();
        //comboboxtext.changed.connect(on_comboboxtext_changed);
        grid.attach(comboboxtext, 0, 0, 1, 1);

		numpoints_lbl = new Gtk.Label("Number points:");
		grid.attach(numpoints_lbl, 1, 0, 1, 1);
		numpoints_lbl.show();

		spin = new Gtk.SpinButton.with_range(1, 10000, 1000);
        spin.set_value(1000);
		grid.attach(spin, 2, 0, 1, 1);
		spin.show();

        var draw_pi = new DrawPi(480, 480, 20, 10);

        buttonDraw = new Gtk.Button();
		buttonDraw.set_label("Calculate");
		buttonDraw.clicked.connect(on_buttondraw_click);
        grid.attach(buttonDraw, 3, 0, 1, 1);
		buttonDraw.show ();

		buttonAbout = new Gtk.Button();
		buttonAbout.set_label("About");
		//buttonAbout.clicked.connect(on_buttonabout_click);
        grid.attach(buttonAbout, 4, 0, 1, 1);
		buttonAbout.show ();

		separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        grid.attach(separator, 0, 1, 5, 1);
        separator.show();

        drawing_area = new Gtk.DrawingArea();
		drawing_area.set_size_request(480, 480);
		drawing_area.draw.connect((context) => {
            return draw_pi.draw_shapes(context);
		});
		grid.attach(drawing_area, 0, 2, 5, 1);
		drawing_area.show();

        pi_lbl = new Gtk.Label("Pi (first eight decimals): 3.14159265"); //3.1415926535897932384
		grid.attach(pi_lbl, 0, 3, 5, 1);
		pi_lbl.show();

        epi_lbl = new Gtk.Label("Pi (estimated):"); //3.1415926535897932384
		grid.attach(epi_lbl, 0, 4, 5, 1);
		epi_lbl.show();

        separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        grid.attach(separator, 0, 5, 5, 1);
        separator.show();

        statusBar = new Gtk.Statusbar();
        grid.attach(statusBar, 0, 6, 5, 1);
		statusBar.show();

        grid.show();
	}


	private void on_buttondraw_click() {
        //var draw_pi = new DrawPi(480, 480, 20, 10000);

        drawing_area = new Gtk.DrawingArea();
		drawing_area.set_size_request(480, 480);
		drawing_area.draw.connect((context) => {
            double pi = DrawPi.draw_points(context, 480, 20, 10000);
            stdout.printf("pi: " + pi.to_string() + "\n");
            epi_lbl.set_label(@"Pi (estimated): $pi");
            return true;
		});
		grid.attach(drawing_area, 0, 2, 5, 1);
        drawing_area.show();
	}

}



