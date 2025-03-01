import java.util.Arrays;
import java.util.Random;

class Fragment{
  int measures;
  Chord[] chords; //must be n * measures
  NumberNote[] melody;
  private Table probabilitySettings;
  protected String[] scale;
  
  public Fragment(int measures, int chordsPerMeasure, String[] scale, Table table){
    this.measures = measures;
    chords = new Chord[measures * chordsPerMeasure];
    probabilitySettings = table;
    this.scale = scale;
  }
  
  public void generateChords(){
    chords = new Chord[(2*measures) - 1];
    chords[(2*measures) - 2] = new Chord("I", scale, 4, 1, measures, 1, 4); //last chord in root position, whole note
    for(int i = (2*measures) - 3; i >= 0; i--){
      chords[i] = new Chord(randomChord(chords[i+1].getSymbol()), scale, 4, 1, (i+2)/2, 1+(2*(i%2)), 2);
    }
    for(int i = 0; i < chords.length; i++){
      System.out.print(chords[i].getSymbol() + " ");
    }
  }
  
  void generateMelody(){
  
  }
  
  private String randomChord(String nextChord){ //make private later
    for(int i = 0; i < probabilitySettings.getRowCount(); i++){
      TableRow row = probabilitySettings.getRow(i);
      if(row.getString(0).equals(nextChord)){ // if this "section" is correct for the next chord
        ArrayList<Float> weightList = new ArrayList<Float>();
        for(int j = i; j < probabilitySettings.getRowCount(); j++){
          row = probabilitySettings.getRow(j);
          if(row.getString(1).equals("")){ //end of "section"
            break;
          }
          weightList.add(row.getFloat(2));
        }
        
        //convert arraylist to array
        float[] weights = new float[weightList.size()];
        for(int j = 0; j < weights.length; j++){
          weights[j] = weightList.get(j);
        }
        
        //randomize index, then go back and get chord
        int randomIndex = weightedRandomChoice(weights);
        row = probabilitySettings.getRow(i + randomIndex);        
        return row.getString(1);
      }
    }
    //not found
    System.out.println("I'm a stupid program and backed myself into an inescapable corner. Talk to Luca. Next Chord: " + nextChord);
    return "I";
  }
  
  private int weightedRandomChoice(float[] weights) {
    float total = 0;
    for (float weight : weights) {
        total += weight;
    }
    if (total <= 0) {
        throw new IllegalArgumentException("Sum of weights must be positive.");
    }
    
    float threshold = new Random().nextFloat() * total;
    float cumulative = 0;
    
    for (int i = 0; i < weights.length; i++) {
        cumulative += weights[i];
        if (threshold <= cumulative) {
            return i;
        }
    }
    
    return weights.length - 1;
  }
  
  NumberNote[] getNotes(){
    return melody; // NEEDS TO BE NOTES FROM MELODY, CHORDS, AND EVERYTHING ELSE
  }
  
}
