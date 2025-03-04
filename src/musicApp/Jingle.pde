// Luca DalCanto

class Jingle extends Song{
  //private Fragment mySingleFragment;
  
  //precondition: measures > 1
  public Jingle(String keySig, int measures){
    super(keySig);
    myFragments = new Fragment[1]; //a jingle consists of a single fragment
    myFragments[0] = new Fragment(measures, 2, scale, probabilitySettings);
  }
  
  @Override
  public void generate(){
    myFragments[0].generateChords();  
    myFragments[0].generateMelody();
  }
}
