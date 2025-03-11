// Luca DalCanto

class Jingle extends Song{
  
  //precondition: measures > 1
  public Jingle(int timeSignature, String keySignature, String instrument){
    super(keySig);
    myFragments = new Fragment[1]; //a jingle consists of a single fragment
    myFragments[0] = new Fragment(2, 2, scale, probabilitySettings);
  }
  
  @Override
  public void generate(){
    myFragments[0].generateChords();  
    myFragments[0].generateMelody();
  }
}
