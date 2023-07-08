/**
 * Utils to draw shapes, points and get value of pi
 * @author Leo Guzman
 * @version 1.0
 */

public class Utils : GLib.Object {
    // Attributes
    public static int width_da;
    public static int pad;
    public static int num_points;

    // Constructor
    public Utils() {

    }

    // Methods

    /**
     * Draw rectangle and circle
     * @parameter Cairo context
     * @return always true
     * @author Leo Guzman
     * @version 1.0
     */
    public static bool draw_shapes(Cairo.Context context, int width_da, int pad) {
        int center = (width_da)/2;
        int diam = width_da - pad*2;

        context.set_line_width(2);
        context.set_line_join (Cairo.LineJoin.ROUND);
        context.rectangle(pad, pad, diam, diam);
        context.stroke();
        context.arc(center, center, diam/2, 0, 2*Math.PI);
        context.stroke();

        return true;
    }

    /**
     * Draw points
     * @parameter Cairo context
     * @return pi value
     * @author Leo Guzman
     * @version 1.0
     */
    public static double draw_points(Cairo.Context context, int width_da, int pad, int num_points) {
        int diam = width_da - pad*2;
        int px;
        int py;

        double in_circle = 0.0;
        double pi;
        double[] pi_values = {};

        context.set_line_width(2);
        context.set_line_join(Cairo.LineJoin.ROUND);
        context.set_line_cap(Cairo.LineCap.ROUND);

        for (int i = 0; i < num_points; i++) {
            double x = Random.next_double() - 0.5;
            double y = Random.next_double() - 0.5;

            if ((x*x + y*y) <= 0.5*0.5) {
                in_circle = in_circle + 1;

                context.set_source_rgb(0, 0, 0);
                px = (int)((x + 0.5)*diam + pad);
                py = (int)((y + 0.5)*diam + pad);
                context.move_to(px, py);
                context.close_path();
                context.stroke();
            }
            else {
                context.set_source_rgb(1, 0, 0);
                px = (int)((x + 0.5)*diam + pad);
                py = (int)((y + 0.5)*diam + pad);
                context.move_to(px, py);
                context.close_path();
                context.stroke();
            }

            pi = in_circle/num_points*8;
            pi_values += pi;
        }

        return Gsl.Stats.mean(pi_values, 1, pi_values.length);
    }
}
