// Luca DalCanto

import java.util.Arrays;
import java.util.Random;

abstract class Song {
  protected int measures;
  protected String name;
  protected float duration;
  protected int sharps;
  protected NumberNote[] allNotes; //final combination of all notes
  protected String[] scale;
  private Table probabilitySettings;
  
  protected Song(String keySignature){
    String[] keys = {"C", "G", "D", "A", "E", "B", "F#", "C#", "G#", "D#", "A#", "E#"};
    String[] orderOfNotes = {"A", "B", "C", "D", "E", "F", "G"};
    String[] orderOfSharps = {"F", "C", "G", "D", "A", "E", "B", "F", "C", "G", "D"};
    
    //figure out number of sharps
    sharps = 0;
    while(sharps<12){
      if(keys[sharps] == keySignature){break;}
      sharps++;
    }
    
    //establish scale with just white notes, starting from correct tonic
    scale = new String[7];
    int index = Arrays.binarySearch(orderOfNotes, str(keySignature.charAt(0))); //index of "orderOfNotes" to start on
    for(int i = 0; i < 7; i++){
      scale[i] = orderOfNotes[(i+index)%7];
    }
    
    //add sharps
    for(int i = 0; i < sharps; i++){
      String modifyKey = orderOfSharps[i];
      for(int j = 0; j < 7; j++){
        if(str(scale[j].charAt(0)).equals(modifyKey)){
          scale[j] += "#";
          break;
        }
      }
    }
    
    //set up probability table
    probabilitySettings = loadTable("ProbabilityFiles/MusicProductionStatsClassical.csv");
    
  }
  
  //String randomChord(String nextChord){
  //  for(int i = 0; i < probabilitySettings.getRowCount(); i++){
  //    TableRow row = probabilitySettings.getRow(i);
  //    if(row.getString(0).equals(nextChord)){
  //      while(!row.getString(1).equals("")){
          
  //      }
  //      break;
  //    }
  //    //not found
  //    System.out.println("I backed myself into an inescapable corner. Talk to Luca.");
  //    return "I";
  //  }
  //}
  
  int weightedRandomChoice(float[] weights) {
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

  
  void printScale(){
    System.out.println("Number of Sharps: " + sharps);
    for(String note : scale){
      System.out.print(note + " ");
    }
  }
  
  abstract void generate();
  void play(){
    // send allNotes data to Micah
  }
 
  
  
}
