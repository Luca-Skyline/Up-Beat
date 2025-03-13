class ClassicalSong extends Song {
  
  ClassicalSong(boolean mrSkylineMode, int measures, int timeSignature, String keySignature, boolean major){
    super(measures, keySignature, timeSignature, major);
    
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
    myFragments = new Fragment[measures/8];
    
    myFragments[myFragments.length-1] = new Fragment(8, 2 - (timeSignature%2), timeSignature, scale, probabilitySettings, major);
    myFragments[myFragments.length-1].generateChords(true, "I");
    myFragments[myFragments.length-1].generateMelody(true);
    myFragments[myFragments.length-1].makeResolve();
    myFragments[myFragments.length-1].addStartBeat(8*timeSignature*(myFragments.length-1));
    
    for(int i = (measures/8) - 2; i >= 0; i--){
      myFragments[i] = new Fragment(8, 2 - (timeSignature%2), timeSignature, scale, probabilitySettings, major);
      myFragments[i].generateChords(false, myFragments[i+1].getFirstChord());
      myFragments[i].generateMelody(false);
      myFragments[i].addStartBeat(8*timeSignature*i);
    }
  }
  
}
