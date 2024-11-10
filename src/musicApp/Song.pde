abstract class Song {
  protected int measures;
  protected String name;
  protected float duration;
  protected Note[] allNotes; //final combination of all notes
  
  abstract void generate();
  void play(){
    // send allNotes data to Micah
  }
 
  
  
}
