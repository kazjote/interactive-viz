[DBus (name = "eu.kazjote.InteractiveViz")]
public class DBusService : Object {
    public void reload_picture (string filename) throws Error {
        reload_requested (filename);
    }
    
    public signal void reload_requested (string filename);
    
    public signal void arguments_changed ();
}
