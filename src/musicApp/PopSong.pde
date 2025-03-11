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
    myFragments = new Fragment[measures/4];
    
    if(measures == 4){
        myFragments[0].generateChords(true, "I");  
        myFragments[0].generateMelody(true);
        return;
    } 
    Fragment verseB = new Fragment(4, 2, scale, probabilitySettings);
    verseB.generateChords(false, "I");
    verseB.generateMelody(false);
    Fragment verseA = new Fragment(4, 2, scale, probabilitySettings);
    verseA.generateChords(verseB.getFirstChord(), "I");
    verseA.generateMelody(false);
    Fragment chorusD = new Fragment(4, 2, scale, probabilitySettings);
    chorusD.generateChords(false, verseA.getFirstChord());
    chorusD.generateMelody(true);
    Fragment chorusC = new Fragment(4, 2, scale, probabilitySettings);
    chorusC.generateChords(false, chorusD.getFirstChord());
    chorusC.generateMelody(false);
    Fragment verseBPrime = new Fragment(4, 2, scale, probabilitySettings);
    verseBPrime.generateChords(chorusC.getFirstChord(), verseB.getFirstChord());
    verseBPrime.generateMelody(false);
    
    System.out.println(myFragments.length);
    for(int i = 0; i < myFragments.length; i++){
      if(i == 15 || i == 13 || i == 7 || i == 5){ //chorus D
        myFragments[i] = chorusD;
      }
      else if(i == 14 || i == 12 || i == 6 || i == 4){
        myFragments[i] = chorusC;
      }
      else if(i == 3 || i == 11){
        myFragments[i] = verseBPrime;
      }
      else if(i == 1 || i == 9){
        myFragments[i] = verseB;
      }
      else if(i==0 || i == 2 || i == 8 || i==10){
        myFragments[i] = verseA;
      }
      System.out.println(i);
      myFragments[i].addStartBeat(16*i);
      
    }
    //myFragments[myFragments.length-1].makeResolve();
    
  }
  
}
