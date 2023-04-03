namespace InteractiveViz {
    public class InterfaceDefinition {
        public InterfaceDefinition (string json_file) {
            this.json_file_path = json_file;
        }
        
        public Gee.ArrayList<ArgumentRow> build () {
            Json.Parser parser = new Json.Parser ();
            var result = new Gee.ArrayList<ArgumentRow> ();
            
            try {
                parser.load_from_file (this.json_file_path);
                
                Json.Object top_level = parser.get_root ().get_object ();
                top_level.foreach_member ((obj, member_name, member_node) => {
                    Json.Object ui_definition = member_node.get_object ();
                    
                    if (ui_definition.get_string_member_with_default ("type", "missing") == "numeric") {
                        result.add (new NumericBoxRow (member_name, ui_definition));
                    }
                });
            } catch (Error e) {
                message ("Unable to parse argument UI definition file: " + e.message);
            }
            
            return result;            
        }

        string json_file_path;
    }
}