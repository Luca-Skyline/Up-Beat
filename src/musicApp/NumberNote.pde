class NumberNote{
  private float velocity;
  private String pitch;
  private float start;
  private float duration;
  private String instrument;
  
  public NumberNote(String value, int octave, float velocity, float start, float duration){
    this.velocity = velocity;
    pitch = value;
    this.start = start;
    this.duration = duration;
  }
  
  public String getPitch(){
    return pitch;
  }
  
  public MIDINote convertToMIDINote(){
    //Micah you can convert this to a midi note
    return null;
  }
  
}
