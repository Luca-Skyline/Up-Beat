class NumberNote{
  private float velocity;
  private String pitch;
  private float startMeasure;
  private float startBeat;
  private float duration;
  private String instrument;
  
  public NumberNote(String value, int octave, float velocity, float startMeasure, float startBeat, float duration){
    this.velocity = velocity;
    pitch = value;
    this.startMeasure = startMeasure;
    this.startBeat = startBeat;
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
