/* application.vala
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
    public class Application : Adw.Application {
        public Application () {
            Object (application_id: "eu.kazjote.InteractiveViz", flags: ApplicationFlags.FLAGS_NONE);
        }

        construct {
            ActionEntry[] action_entries = {
                { "about", this.on_about_action },
                { "preferences", this.on_preferences_action },
                { "quit", this.quit }
            };
            this.add_action_entries (action_entries, this);
            this.set_accels_for_action ("app.quit", {"<primary>q"});
        }
        
        private DBusService dbus_service = new DBusService ();

        public override void activate () {
            base.activate ();
            var win = this.active_window;
            if (win == null) {
                var window = new InteractiveViz.Window (this);
                win = window;
                dbus_service.reload_requested.connect ((filename) => {
                    window.draw_plot (filename);
                });
                
                window.arguments_changed.connect (() => {
                    var json = new Json.Node (Json.NodeType.OBJECT);
                    json.set_object (window.get_arguments ());
                    size_t length;
                    var generator = new Json.Generator ();
                    generator.set_root (json);
                    dbus_service.arguments_changed (generator.to_data (out length));
                });

                Bus.own_name (BusType.SESSION, "eu.kazjote.InteractiveViz", BusNameOwnerFlags.NONE,
                      on_bus_aquired,
                      () => message ("name acquired!"),
                      () => stderr.printf ("Could not aquire DBus name\n"));
                
            }
            win.present ();
        }
        
        private void on_about_action () {
            string[] authors = { "Kacper Bielecki" };
            Gtk.show_about_dialog (this.active_window,
                                   "program-name", "interactive-viz",
                                   "authors", authors,
                                   "version", "0.1.0");
        }

        private void on_preferences_action () {
            message ("app.preferences action activated");
        }
        
        
        private void on_bus_aquired (DBusConnection conn) {
            try {
                conn.register_object ("/eu/kazjote/InteractiveViz", dbus_service);
            } catch (IOError e) {
                stderr.printf ("Could not register service\n");
            }
        }
    }
}
