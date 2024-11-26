abstract class Song {
  protected int measures;
  protected String name;
  protected float duration;
  protected int sharps;
  protected Note[] allNotes; //final combination of all notes
  protected final IntDict circleOfFifths;
  protected ArrayList<String> scale;
  
  protected Song(){
    String[] keys = {"C", "G", "D", "A", "E", "B", "F#", "C#", "G#", "D#", "A#", "E#"};
    circleOfFifths = new IntDict(12);
    for(int i = 0; i < 12; i++){
      circleOfFifths.add(keys[i], i);
    }
    
    //establish scale
    
  }
  
  abstract void generate();
  void play(){
    // send allNotes data to Micah
  }
 
  
  
}
