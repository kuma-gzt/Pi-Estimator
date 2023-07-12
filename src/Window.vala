/**
     * Main window Gtk 3 class
     * @author Leo Guzman
     * @version 1.0
     */
public class Window : Gtk.ApplicationWindow {
    private Gtk.ComboBoxText combo_box;
    private Gtk.Grid grid;
	private Gtk.SpinButton spin;
	private Gtk.Label numpoints_lbl;
    private Gtk.Label pi_lbl_0;
    private Gtk.Label pi_lbl_1;
    private Gtk.Label epi_lbl_0; // estimated pi
    private Gtk.Label epi_lbl_1; // estimated pi
	private Gtk.Button buttonDraw;
	private Gtk.Button buttonAbout;
	private Gtk.Separator separator;
	private Gtk.DrawingArea drawing_area;
	private Gtk.Statusbar status_bar;
    private int width_da = 480; // width drawing area in pixels, no need to specify height as it is a square
    private int pad = 20; //padding in pixels

	internal Window (Driver app) {
		Object (application: app);

		grid = new Gtk.Grid();
		grid.set_column_spacing(15);
		grid.set_row_spacing(10);
        this.add(grid);

		combo_box = new Gtk.ComboBoxText();
		combo_box.append_text("Large");
        combo_box.append_text("Regular");
        combo_box.append_text("Small");
        combo_box.set_active(1);
        combo_box.show();
        grid.attach(combo_box, 0, 0, 1, 1);

		numpoints_lbl = new Gtk.Label("Number dots:");
		grid.attach(numpoints_lbl, 1, 0, 1, 1);
		numpoints_lbl.show();

		spin = new Gtk.SpinButton.with_range(10000, 100000, 10000);
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
		buttonAbout.clicked.connect(on_buttonabout_click);
        grid.attach(buttonAbout, 4, 0, 1, 1);
		buttonAbout.show ();

		separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        grid.attach(separator, 0, 1, 5, 1);
        separator.show();

        drawing_area = new Gtk.DrawingArea();
		drawing_area.set_size_request(width_da, width_da);
		drawing_area.draw.connect((context) => {
            return Utils.draw_shapes(context, width_da, pad);
		});
		grid.attach(drawing_area, 0, 2, 5, 1);
		drawing_area.show();

        pi_lbl_0 = new Gtk.Label("Pi: 3.1415926535");
        pi_lbl_0.set_xalign(1.0f);
		grid.attach(pi_lbl_0, 1, 3, 2, 1);
		pi_lbl_0.show();

        pi_lbl_1 = new Gtk.Label("(first ten decimals)");
        pi_lbl_0.set_xalign(0.0f);
		grid.attach(pi_lbl_1, 2, 3, 2, 1);
		pi_lbl_1.show();

        epi_lbl_0 = new Gtk.Label("");
        epi_lbl_0.set_xalign(1.0f);
		grid.attach(epi_lbl_0, 1, 4, 2, 1);
		epi_lbl_0.show();

        epi_lbl_1 = new Gtk.Label("");
        epi_lbl_0.set_xalign(0.0f);
		grid.attach(epi_lbl_1, 2, 4, 2, 1);
		epi_lbl_1.show();

        separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        grid.attach(separator, 0, 5, 5, 1);
        separator.show();

        status_bar = new Gtk.Statusbar();
        grid.attach(status_bar, 0, 6, 5, 1);
		status_bar.show();

        grid.show();
	}

    /**
     * Draws points and shapes given the GUI parameters
     * @parameter none
     * @return void
     * @author Leo Guzman
     * @version 1.0
     */
	private void on_buttondraw_click() {
        DateTime begin = new DateTime.now();

        int point_size;
        string combo_box_sel = combo_box.get_active_text();
        if (combo_box_sel == "Large")
        {
            point_size = 4;
        }
        else if (combo_box_sel == "Regular")
        {
            point_size = 2;
        }
        else if (combo_box_sel == "Small")
        {
            point_size = 1;
        }
        else
        {
            point_size = 2;
        }

        int num_points = spin.get_value_as_int();
        uint context_id = status_bar.get_context_id ("");
        // status_bar.push(context_id, @"Processing $num_points points...");

        grid.remove(drawing_area);
        drawing_area = new Gtk.DrawingArea();
		drawing_area.set_size_request(width_da, width_da);
		drawing_area.draw.connect((context) => {
            Utils.draw_shapes(context, width_da, pad);
            double pi = Utils.draw_points(context, width_da, pad, num_points, point_size);
            var pi_string = "%.10f".printf(pi);
            epi_lbl_0.set_label(@"Pi: " + pi_string);
            epi_lbl_1.set_label("(estimated value)");
            DateTime end = new DateTime.now();
            int dif = (int)(end.to_unix() - begin.to_unix());
            status_bar.push(context_id, @"Processing time: $dif seconds");
            return true;
		});
		grid.attach(drawing_area, 0, 2, 5, 1);
        drawing_area.show();
	}

    /**
     * About button
     * @parameter none
     * @return void
     * @author Leo Guzman
     * @version 1.0
     */
	private void on_buttonabout_click() {
		Gtk.AboutDialog dialog = new Gtk.AboutDialog();
		dialog.set_destroy_with_parent(true);
	    dialog.set_transient_for(this);
	    dialog.set_modal(true);
	    dialog.program_name = "MONTE CARLO PI ESTIMATOR";
	    dialog.comments = "Estimating pi number with random points";
	    dialog.copyright = "Copyright © 2023 Leo Guzman";
	    dialog.version = "1.0";

	    dialog.response.connect ((response_id) => {
		    if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
			    dialog.hide_on_delete();
		    }
	    });
	    dialog.present ();
	}
}



