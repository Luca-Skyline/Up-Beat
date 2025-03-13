class ClassicalSong extends Song {
  
  ClassicalSong(boolean mrSkylineMode, int measures, int timeSignature, String keySignature, boolean major, String[] instruments){
    super(measures, keySignature, timeSignature, major, instruments);
    
    //set up probability table
    
    if(mrSkylineMode){
      try{
        probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsSkyline.csv");
      }
      catch(Error e){
        System.out.println("Probablity File Not Found! Talk to Luca.");
      }
    }
    else{
      try{
        probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsClassical.csv");
      }
      catch(Error e){
        System.out.println("Probablity File Not Found! Talk to Luca.");
      }
    }
  }
  
  @Override
  void generate(){
    myFragments = new Fragment[measures/4];    
  }
  
}
