// Luca DalCanto

class Chord{
  private NumberNote[] myNotes;
  private float duration;
  private String symbol;
  private float beat;
  private String[] majorScale;
  private int octave;
  private float velocity;
  
  public Chord(String symbol, String[] majorScale, int octave, float velocity, float beat, float duration){
    this.majorScale = majorScale;
    this.symbol = symbol;
    this.beat = beat;
    this.octave = octave;
    myNotes = new NumberNote[4];
    this.velocity = velocity;
    this.duration = duration;
    
    makeType(symbol);
  }
  
  public void makeType(String chordSymbol){
    switch(chordSymbol){
      case "I":
        myNotes[0] = new NumberNote(majorScale[0], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[0], octave, velocity, beat, duration); // root
        myNotes[2] = new NumberNote(majorScale[2], octave, velocity, beat, duration); // third
        myNotes[3] = new NumberNote(majorScale[4], octave, velocity, beat, duration); // fifth
        break;
      case "I7":
        myNotes[0] = new NumberNote(majorScale[0], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[6], octave, velocity, beat, duration); // root
        myNotes[2] = new NumberNote(majorScale[2], octave, velocity, beat, duration); // third
        myNotes[3] = new NumberNote(majorScale[4], octave, velocity, beat, duration); // fifth
        break;
      case "ii":
        myNotes[0] = new NumberNote(majorScale[1], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[1], octave, velocity, beat, duration); // root
        myNotes[2] = new NumberNote(majorScale[3], octave, velocity, beat, duration); // third
        myNotes[3] = new NumberNote(majorScale[5], octave, velocity, beat, duration); // fifth
        break;
      case "iii":
        myNotes[0] = new NumberNote(majorScale[2], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[6], octave, velocity, beat, duration); // fifth
        myNotes[2] = new NumberNote(majorScale[2], octave, velocity, beat, duration); // root
        myNotes[3] = new NumberNote(majorScale[4], octave, velocity, beat, duration); // third

        break;
      case "IV":
        myNotes[0] = new NumberNote(majorScale[3], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[0], octave, velocity, beat, duration); // fifth
        myNotes[2] = new NumberNote(majorScale[3], octave, velocity, beat, duration); // root
        myNotes[3] = new NumberNote(majorScale[5], octave, velocity, beat, duration); // third
        break;
      case "IV7":
        myNotes[0] = new NumberNote(majorScale[3], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[0], octave, velocity, beat, duration); // fifth
        myNotes[2] = new NumberNote(majorScale[2], octave, velocity, beat, duration); // root
        myNotes[3] = new NumberNote(majorScale[5], octave, velocity, beat, duration); // third
        break;
      case "V":
        myNotes[0] = new NumberNote(majorScale[4], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[6], octave, velocity, beat, duration); // third
        myNotes[2] = new NumberNote(majorScale[1], octave, velocity, beat, duration); // fifth
        myNotes[3] = new NumberNote(majorScale[4], octave, velocity, beat, duration); // root
        break;
      case "V7":
        myNotes[0] = new NumberNote(majorScale[4], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[6], octave, velocity, beat, duration); // third
        myNotes[2] = new NumberNote(majorScale[1], octave, velocity, beat, duration); // fifth
        myNotes[3] = new NumberNote(majorScale[3], octave, velocity, beat, duration); // root
      case "vi":
        myNotes[0] = new NumberNote(majorScale[5], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[0], octave, velocity, beat, duration); // third
        myNotes[2] = new NumberNote(majorScale[2], octave, velocity, beat, duration); // fifth
        myNotes[3] = new NumberNote(majorScale[5], octave, velocity, beat, duration); // root
        break;
      case "vii*":
        myNotes[0] = new NumberNote(majorScale[6], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[6], octave, velocity, beat, duration); // root
        myNotes[2] = new NumberNote(majorScale[1], octave, velocity, beat, duration); // third
        myNotes[3] = new NumberNote(majorScale[3], octave, velocity, beat, duration); // fifth
        break;
      case "II":
        myNotes[0] = new NumberNote(majorScale[1], 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[1], octave, velocity, beat, duration); // root
        myNotes[2] = new NumberNote(majorScale[3] + "#", octave, velocity, beat, duration); // third
        myNotes[3] = new NumberNote(majorScale[5], octave, velocity, beat, duration); // fifth
        break;
      case "bVI":
        myNotes[0] = new NumberNote(majorScale[4] + "#", 2, velocity, beat, duration); // bass (root)
        myNotes[1] = new NumberNote(majorScale[0], octave, velocity, beat, duration); // third
        myNotes[2] = new NumberNote(majorScale[1] + "#", octave, velocity, beat, duration); // fifth
        myNotes[3] = new NumberNote(majorScale[4] + "#", octave, velocity, beat, duration); // root
        break;
      case "bVII":
        myNotes[0] = new NumberNote(majorScale[5] + "#", 2, velocity, beat, duration);
        myNotes[1] = new NumberNote(majorScale[5] + "#", octave, velocity, beat, duration);
        myNotes[2] = new NumberNote(majorScale[1], octave, velocity, beat, duration);
        myNotes[3] = new NumberNote(majorScale[3], octave, velocity, beat, duration);
        break;
      default:
        System.out.println("I'm not smart enough to handle the " + symbol + " chord yet :(");
        myNotes = new NumberNote[1];
    
    }  
  }
  
  public void addDelay(int beat){
    for(NumberNote c : myNotes){
      c.addToBeat(beat);
    }
  }
  
  public String getSymbol(){
    return symbol;
  }
  
  public NumberNote getNote(int index){
    return myNotes[index];
  }
  
  public float getBeat(){
    return beat;
  }
  
  public NumberNote[] getNotes(){
    return myNotes;
  }
  
  public int getOctave(){
    return octave;
  }
  
  
  public float getVelocity(){
    return velocity;
  }
  
  public float getDuration(){
    return duration;
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
