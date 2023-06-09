namespace InteractiveViz {
    [GtkTemplate (ui = "/eu/kazjote/InteractiveViz/numericBoxRow.ui")]
    public class NumericBoxRow : ArgumentRow {
        [GtkChild]
        private unowned Gtk.Label argument_name;
        [GtkChild]
        private unowned Gtk.SpinButton spin_button;
        
        public NumericBoxRow (string name_from_definition, Json.Object ui_definition) {
            argument_name.label = name_from_definition;
           
            var adjustment = spin_button.adjustment;
            adjustment.lower = -100.0;
            adjustment.upper = 100.0;
            adjustment.step_increment = 1.0;
            
            spin_button.value_changed.connect (() => {
                value_changed ();
            });
        }
        public override Json.Node to_json () {
            var node = new Json.Node (Json.NodeType.VALUE);
            node.set_double (spin_button.value);
            return node;
        }
        public override string get_argument_name () {
            return argument_name.label;   
        }
    }
}
