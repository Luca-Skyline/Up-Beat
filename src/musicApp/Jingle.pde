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
    
    myFragments = new Fragment[2]; //a jingle consists of a single fragment
    
  }
  
  @Override
  public void generate(){
    myFragments[0] = new Fragment(2, 2, scale, probabilitySettings);
    myFragments[0].generateChords(true, "I");  
    myFragments[0].generateMelody(true);
    
    myFragments[1] = new Fragment(2, 2, scale, probabilitySettings);
    myFragments[1].setChords(copyChords(myFragments[0]));
    myFragments[1].setMelody(copyMelody(myFragments[0]));
    myFragments[1].addStartBeat(8);
    
    myFragments[1].makeResolve();
  }
}
