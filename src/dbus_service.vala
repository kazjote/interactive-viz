[DBus (name = "eu.kazjote.InteractiveViz")]
public class DBusService : Object {
    public void reload_picture (string filename) throws Error {
        message ("TODO: I should reload the picture now");
    }
    
    public signal void arguments_changed ();
}
