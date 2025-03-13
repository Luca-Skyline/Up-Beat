// Luca DalCanto

class Jingle extends Song{
  
  //precondition: measures > 1
  public Jingle(int timeSignature, String keySignature, String[] instruments){
    super(2, keySignature, timeSignature, instruments);
    
    //set up probability table
    try{
      probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsClassical.csv");
    }
    catch(Error e){
      System.out.println("Probablity File Not Found! Talk to Luca.");
    }
    
    myFragments = new Fragment[1]; //a jingle consists of a single fragment
    
  }
  
  @Override
  public void generate(){
    myFragments[0] = new Fragment(3, 2, timeSignature, scale, probabilitySettings);
    myFragments[0].generateChords(true, "I");  
    myFragments[0].generateMelody(true);    
    myFragments[0].makeResolve();
  }
}
