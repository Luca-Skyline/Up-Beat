class NumberNote{
  private float velocity;
  private String value;
  private float start;
  private float duration;
  private String instrument;
  
  public NumberNote(String value, float velocity, float start, float duration){
    this.velocity = velocity;
    this.value = value;
    this.start = start;
    this.duration = duration;
  }
  
  public MIDINote convertToMIDINote(){
    //Micah you can convert this to a midi note
    return null;
  }
  
}
