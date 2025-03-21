class PopSong extends Song {
  
  PopSong(boolean jazzMode, int measures, int timeSignature, String keySignature, boolean major){
    super(measures, keySignature, timeSignature, major);
    
    //set up probability table
    
    if(jazzMode){
      percussionDirectory = "drums/jazz" + timeSignature+ ".mid";
      try{
        probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsJazz.csv");
      }
      catch(Error e){
        System.out.println("Probablity File Not Found! Talk to Luca.");
      }
    }
    else{
      percussionDirectory = "drums/pop" + timeSignature+ ".mid";
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
    
    System.out.println("Major:" + major);
    
    Fragment verseB = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
    verseB.generateChords(true, "I");
    verseB.generateMelody(false);
    Fragment verseA = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
    verseA.generateChords(false, verseB.getFirstChord(), "I");
    verseA.generateMelody(false);
    Fragment chorusD= new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
    chorusD.generateChords(true, verseA.getFirstChord());
    chorusD.generateMelody(true);
    Fragment chorusC = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
    chorusC.generateChords(false, chorusD.getFirstChord());
    chorusC.generateMelody(false);
    Fragment verseBPrime = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
    verseBPrime.generateChords(true, chorusC.getFirstChord(), verseB.getFirstChord());
    verseBPrime.generateMelody(false);
    
    for(int i = 0; i < myFragments.length; i++){
      if(i == 15 || i == 13 || i == 7 || i == 5){ //chorus D
        myFragments[i] = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
        myFragments[i].setChords(copyChords(chorusD));
        myFragments[i].setMelody(copyMelody(chorusD));
      }
      else if(i == 14 || i == 12 || i == 6 || i == 4){
        myFragments[i] = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
        myFragments[i].setChords(copyChords(chorusC));
        myFragments[i].setMelody(copyMelody(chorusC));
      }
      else if(i == 3 || i == 11){
        myFragments[i] = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
        myFragments[i].setChords(copyChords(verseBPrime));
        myFragments[i].setMelody(copyMelody(verseBPrime));
      }
      else if(i == 1 || i == 9){
        myFragments[i] = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
        myFragments[i].setChords(copyChords(verseB));
        myFragments[i].setMelody(copyMelody(verseB));
      }
      else if(i==0 || i == 2 || i == 8 || i==10){
        myFragments[i] = new Fragment(4, 1, timeSignature, scale, probabilitySettings, major);
        myFragments[i].setChords(copyChords(verseA));
        myFragments[i].setMelody(copyMelody(verseA));
      }
      myFragments[i].addStartBeat(4*timeSignature*i);
      
    }
    myFragments[myFragments.length-1].makeResolve();
    
  }
  

  
}
