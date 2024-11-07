class Fragment{
  int measures;
  Chord[] chords; //must be n * measures
  ChordWeighting weights;
  NumberNote[] melody;
  
  Fragment(int measures, int chordsPerMeasure, ChordWeighting weights){
    this.measures = measures;
    chords = new Chord[measures * chordsPerMeasure];
    this.weights = weights;
  }
  
  void generateChords(){
  
  }
  
  void generateMelody(){
  
  }
  
  NumberNote[] getNotes(){
    return melody; // NEEDS TO BE NOTES FROM MELODY, CHORDS, AND EVERYTHING ELSE
  }
  
}
