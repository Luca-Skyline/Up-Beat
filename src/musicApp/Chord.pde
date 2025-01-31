// Luca DalCanto

class Chord{
  private NumberNote[] myNotes;
  private float start;
  private float duration;
  
  Chord(String root, String quality, int octave, int velocity, float start, float duration){
    
    switch(quality){
      case "":
        myNotes = new NumberNote[3];
      // more cases
      default:
        myNotes = new NumberNote[1];
    
    }
    
    myNotes[0] = new NumberNote(root + octave, velocity, start, duration); // root note
  
  }
  
  NumberNote[] getNotes(){
    return myNotes;
  }

}

/* 

types of qualities: 
"" : Major Triad
"-" : Minor Triad
"sus" : Suspended 4
"dim" : Diminished Triad
"7" : Dominant 7
"^7" : Major 7
"-7" : Minor 7
"^-7" : Major Minor 7
"dim7" : Half Diminshed
"*" : Fully Dimished


*/
