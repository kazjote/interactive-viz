namespace InteractiveViz {
    public abstract class ArgumentRow : Gtk.ListBoxRow, Json.Serializable {
        public abstract Json.Node to_json();
        
        public abstract string get_argument_name ();
        
        public signal void value_changed ();
    }
}