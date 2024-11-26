class ChordWeighting{
  String[] chords = {"I", "II", "ii", "III", "iii", "IV", "V", "bVI", "vi", "bVII", "vii"};
  int[] indices = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  IntDict indexDict = new IntDict(chords, indices);
  FloatDict[] weights;
  
  ChordWeighting(String genre, float chaos){
    
    weights = new FloatDict[11];
    
    // pull data from spreadsheet based on genre & put in weights
    // adjust based on chaos
  }
  
  String choosePreviousChord(String currentChord){
    int chordIndex = indexDict.get(currentChord);
    // do randomization with weights[chordIndex]
    
    return "I";
  }
  
}
