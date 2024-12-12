abstract class Song {
  protected int measures;
  protected String name;
  protected float duration;
  protected int sharps;
  protected Note[] allNotes; //final combination of all notes
  protected IntDict scale;
  
  protected Song(String keySignature){
    String[] keys = {"C", "G", "D", "A", "E", "B", "F#", "C#", "G#", "D#", "A#", "E#"};
    String[] orderOfNotes = {"A", "B", "C", "D", "E", "F", "G"};
    String[] orderOfSharps = {"F", "C", "G", "D", "A", "E", "B", "F", "C", "G", "D"};
    
    
    int numberOfSharps = 0;
    while(numberOfSharps<12){
      if(keys[numberOfSharps] == keySignature){break;}
    }
    
    scale = new IntDict(7);
        
    //establish scale
    for(int i = 0; i < numberOfSharps; i++){
      
    }
    
  }
  
  abstract void generate();
  void play(){
    // send allNotes data to Micah
  }
 
  
  
}
