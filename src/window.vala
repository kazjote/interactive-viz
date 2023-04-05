/* window.vala
 *
 * Copyright 2023 Kacper Bielecki
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
 */

namespace InteractiveViz {
    [GtkTemplate (ui = "/eu/kazjote/InteractiveViz/window.ui")]
    public class Window : Gtk.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.Picture plot;
        [GtkChild]
        private unowned Gtk.ListBox argument_box;
        
        private Gee.TreeMap<string, ArgumentRow> argument_row_map = new Gee.TreeMap<string, ArgumentRow> ();

        public Window (Gtk.Application app) {
            Object (application: app);
            
            InterfaceDefinition interface_definition = 
                new InterfaceDefinition ("/home/kazjote/projects/interactive-viz/viz-tool/interactive-viz/example-argument-definition.json");
                
            var argument_rows = interface_definition.build ();
            
            argument_rows.foreach ((argument_row) => {
                argument_box.append (argument_row);
                argument_row.value_changed.connect (() => {
                    arguments_changed ();
                });
                argument_row_map.set (argument_row.get_argument_name (), argument_row);
                argument_row.show ();
                return true;
            });
        }
        
        public signal void arguments_changed ();
        
        public Json.Object get_arguments () {
            var arguments = new Json.Object ();
            argument_row_map.foreach (entry => {
                arguments.set_member (entry.key, entry.value.to_json ());
                return true;
            });
            return arguments;
        }
        
        public void draw_plot (string filename) {
            message ("Will draw plot from file " + filename);
            plot.set_filename (filename);
        }
    }
}
