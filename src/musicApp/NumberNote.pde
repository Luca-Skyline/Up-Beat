//made my Micah Tien

class NumberNote {
  private float velocity;

  private String letterNote;
  private int octave;
  private int[] letterOffsets;
  private int pitch;

  private float beat;
  private float duration;

  public NumberNote(String letterNote, int octave, float velocity, float beat, float duration) {
    this.velocity = velocity;
    this.velocity = 127;

    this.letterNote = letterNote;
    this.octave = octave;
    int[] tempOffsets = {9, 11, 0, 2, 4, 5, 7};
    letterOffsets = new int[7];
    letterOffsets = tempOffsets;
    pitch = calculatePitch();

    this.beat = beat;
    this.duration = duration;
  }
  
  public int getOctave(){
    return octave;
  }

  public String getPitch() {
    return this.letterNote;
  }
  
  public float getBeat(){
    return beat;
  }
  
  public void addToBeat(int change){
    System.out.println(change);
    beat += change;
  }
  
  public void setPitch(String letterNote){
    this.letterNote = letterNote;
    int[] tempOffsets = {9, 11, 0, 2, 4, 5, 7};
    letterOffsets = new int[7];
    letterOffsets = tempOffsets;
    pitch = calculatePitch();
  }


  public int calculatePitch() {
    int p = 12*(this.octave+1); //sets the octaves so that c4 is 60, c5 is 72, and so on
    int imsad = int(this.letterNote.charAt(0));
    p += this.letterOffsets[imsad-65]; //this is beautiful
    p += stringLength(this.letterNote); //accounts for sharps;
    return p;
  }

  //made by Honeyman Tien
  //citation vandalized by luca skyline >:(
  public int stringLength(String str) {
    int inc = 0;
    for (int i=0; i<str.length(); i++) {
      inc++;
    }
    return inc-1;
  }

  public MIDINote convertToMidiNote() {
    return new MIDINote(this.pitch, this.velocity, this.beat, this.duration);
  }
}
