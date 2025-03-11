// Luca DalCanto

class Jingle extends Song{
  
  //precondition: measures > 1
  public Jingle(int timeSignature, String keySignature, String instrument){
    super(2, keySignature, timeSignature, instrument);
    
    //set up probability table
    try{
      probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsClassical.csv");
    }
    catch(Error e){
      System.out.println("Probablity File Not Found! Talk to Luca.");
    }
    
    myFragments = new Fragment[1]; //a jingle consists of a single fragment
    myFragments[0] = new Fragment(2, 2, scale, probabilitySettings);
  }
  
  @Override
  public void generate(){
    myFragments[0].generateChords(true, "I");  
    myFragments[0].generateMelody(true);
    myFragments[0].addStartBeat(0);
  }
}
