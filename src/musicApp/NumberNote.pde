//made my Micah Tien

class NumberNote{
  private float velocity;
  
  private String letterNote;
  private int octave;
  private int[] letterOffsets;
  private int pitch;
  
  private float startMeasure;
  private float startBeat;
  private float realBeat;
  
  private float duration;
  
  public NumberNote(String letterNote, int octave, float velocity, float startMeasure, float startBeat, float duration){
    this.velocity = velocity;
    this.velocity = 127;
    
    this.letterNote = letterNote;
    this.octave = octave;
    int[] tempOffsets = {9, 11, 0, 3, 4, 5, 7};
    letterOffsets = new int[7];
    letterOffsets = tempOffsets;
    pitch = calculatePitch();
    
    this.startMeasure = startMeasure;
    this.startBeat = startBeat;
    this.realBeat = 4*(startMeasure-1) + startBeat;
    
    this.duration = duration;
  }
  
  public int calculatePitch() {
    int p = 12*(this.octave+1); //sets the octaves so that c4 is 60, c5 is 72, and so on
    int imsad = int(this.letterNote.charAt(0));
    p += this.letterOffsets[imsad-65]; //this is beautiful
    p += stringLength(this.letterNote); //accounts for sharps;
    return p;
  }
  
  public String getPitch(){
    return this.letterNote;
  }
  
  //made by Jenna Tran
  public int stringLength(String str) {
    int inc = 0;
    for (int i=0; i<str.length(); i++) {
      inc++;
    }
    return inc-1;
  }
  
}
