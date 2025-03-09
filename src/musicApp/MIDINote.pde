//file created by Micah Tien
class MIDINote {
  private String smileyFace;
  private int pitch;
  private int velocity;
  private float beat;
  private float duration;
  
  
  public MIDINote(int pitch, float velocity, float beat, float duration) {
    this.smileyFace = ":)";
    
    this.pitch = pitch;
    this.velocity = (int)velocity;
    this.beat = beat;
    this.duration = duration;
  }
  
  public int getPitch() {
    return this.pitch;
  }
  
  public int getVelocity() {
    return this.velocity;
  }
  
  public float getBeat() {
    return this.beat;
  }
  
  public float getDuration() {
    return this.duration; 
  }
  
  //function PROUDLY made by Micah Tien
  public String getSmileyFace() {
    return this.smileyFace; 
  }
}
