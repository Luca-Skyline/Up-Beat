class PopSong extends Song {
  PercussionTrack percussion;
  
  PopSong(boolean jazzMode, int measures, int timeSignature, String keySignature, String instrument){
    super(measures, keySignature, timeSignature, instrument);
    
    //set up probability table
    
    if(jazzMode){
      try{
        probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsJazz.csv");
      }
      catch(Error e){
        System.out.println("Probablity File Not Found! Talk to Luca.");
      }
    }
    else{
      try{
        probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsPop.csv");
      }
      catch(Error e){
        System.out.println("Probablity File Not Found! Talk to Luca.");
      }
    }
  }
  
  @Override
  void generate(){
  
  }
  
}
