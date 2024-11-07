class Fragment{
  int measures;
  Chord[] chords; //must be n * measures
  
  Fragment(int measures, int chordsPerMeasure){
    this.measures = measures;
    chords = new Chord[measures * chordsPerMeasure];
  }
  
}
