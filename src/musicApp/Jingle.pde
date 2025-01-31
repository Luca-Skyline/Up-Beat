// Luca DalCanto

class Jingle extends Song{
  Chord[] chords;
  
  Jingle(String keySig, int measures){
    super(keySig);
    // adjust based on parameters
    measures = 4;
  }
  
  @Override
  void generate(){
    chords = new Chord[(2*measures) - 1];
    chords[(2*measures) - 2] = new Chord(scale[0], "", 4, 200, measures, 4);
  }
}
