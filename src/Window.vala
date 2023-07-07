public class Window : Gtk.ApplicationWindow {
    private Gtk.ComboBoxText combo_box;
    private Gtk.Grid grid;
	private Gtk.SpinButton spin;
	private Gtk.Label numpoints_lbl;
    private Gtk.Label pi_lbl_0;
    private Gtk.Label pi_lbl_1;
    private Gtk.Label epi_lbl_0;
    private Gtk.Label epi_lbl_1;
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

		combo_box = new Gtk.ComboBoxText();
		combo_box.append_text("Uniform");
        combo_box.append_text("Normal");
        combo_box.set_active(0);
        combo_box.show();
        //comboboxtext.changed.connect(on_comboboxtext_changed);
        grid.attach(combo_box, 0, 0, 1, 1);

		numpoints_lbl = new Gtk.Label("Number points:");
		grid.attach(numpoints_lbl, 1, 0, 1, 1);
		numpoints_lbl.show();

		spin = new Gtk.SpinButton.with_range(1000, 100000, 10000);
        spin.set_value(10000);
		grid.attach(spin, 2, 0, 1, 1);
		spin.show();

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
            return Utils.draw_shapes(context, 480, 20);
		});
		grid.attach(drawing_area, 0, 2, 5, 1);
		drawing_area.show();

        pi_lbl_0 = new Gtk.Label("Pi: 3.1415926536"); //3.1415926535897932384
        pi_lbl_0.set_xalign(1.0f);
		grid.attach(pi_lbl_0, 1, 3, 2, 1);
		pi_lbl_0.show();

        pi_lbl_1 = new Gtk.Label("(first ten decimals)"); //3.1415926535897932384
        pi_lbl_0.set_xalign(0.0f);
		grid.attach(pi_lbl_1, 2, 3, 2, 1);
		pi_lbl_1.show();

        epi_lbl_0 = new Gtk.Label(""); //3.1415926535897932384
        epi_lbl_0.set_xalign(1.0f);
		grid.attach(epi_lbl_0, 1, 4, 2, 1);
		epi_lbl_0.show();

        epi_lbl_1 = new Gtk.Label(""); //3.1415926535897932384
        epi_lbl_0.set_xalign(0.0f);
		grid.attach(epi_lbl_1, 2, 4, 2, 1);
		epi_lbl_1.show();

        separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        grid.attach(separator, 0, 5, 5, 1);
        separator.show();

        statusBar = new Gtk.Statusbar();
        grid.attach(statusBar, 0, 6, 5, 1);
		statusBar.show();

        grid.show();
	}


	private void on_buttondraw_click() {
        drawing_area = new Gtk.DrawingArea();
		drawing_area.set_size_request(480, 480);
		drawing_area.draw.connect((context) => {
            int num_points = spin.get_value_as_int();
            double pi = Utils.draw_points(context, 480, 20, num_points);
            epi_lbl_0.set_label(@"Pi: $pi");
            epi_lbl_1.set_label("(estimated)");
            return true;
		});
		grid.attach(drawing_area, 0, 2, 5, 1);
        drawing_area.show();
	}

}



