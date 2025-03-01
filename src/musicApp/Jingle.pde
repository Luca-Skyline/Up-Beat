// Luca DalCanto

class Jingle extends Song{
  private Fragment mySingleFragment;
  
  //precondition: measures > 1
  public Jingle(String keySig, int measures){
    super(keySig);
    mySingleFragment = new Fragment(measures, 2, scale, probabilitySettings);
  }
  
  @Override
  public void generate(){
    mySingleFragment.generateChords();  
  }
}
