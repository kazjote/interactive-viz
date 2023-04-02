namespace InteractiveViz {
    [GtkTemplate (ui = "/eu/kazjote/InteractiveViz/numericBoxRow.ui")]
    public class NumericBoxRow : Gtk.ListBoxRow {
        [GtkChild]
        private unowned Gtk.Label argument_name;
        private unowned Gtk.SpinButton spin_button;
    }
}
