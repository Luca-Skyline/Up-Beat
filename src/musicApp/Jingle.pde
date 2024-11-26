class Jingle extends Song{
  Chord[] chords;
  
  Jingle(){
    // adjust based on parameters
    measures = 4;
    keySignature = "C";
    int numberOfSharps = circleOfFifths.get(keySignature);
  }
  
  @Override
  void generate(){
    chords = new Chord[(2*measures) - 1];
    chords[(2*measures) - 2] = new Chord(keySignature, "", 4, 200, measures, 4);
  }
}
