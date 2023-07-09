/* Driver.vala
 *
 * Copyright 2023 Leo Guzman
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
* Humble pi generator
* @author Leo Guzman
* @version 1.0
*/
public class Driver : Gtk.Application {
    /* Override the 'activate' signal of GLib.Application,
	 * which is inherited by Gtk.Application. */
	protected override void activate() {
		var window = new Window(this);
        window.title = "Calculating Pi with MonteCarlo Simulation";
        window.border_width = 10;
        window.window_position = Gtk.WindowPosition.CENTER;
        window.set_resizable(false);
        window.show();
	}

	internal Driver () {
        Object(application_id: "com.github.kuma");
    }
}

/**
* Entry point
* @author Leo Guzman
* @version 1.0
*/
public int main (string[] args) {
    return new Driver ().run (args);
}
