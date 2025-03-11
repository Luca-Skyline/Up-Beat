import java.util.Arrays;
import java.util.Random;

class Fragment{
  private int measures;
  private Chord[] chords; //must be n * measures
  private NumberNote[] melody;
  private Table probabilitySettings;
  private String[] scale;
  private float melodyComplexity = 1.5; //should between 1 and 2 for 2 chords per measure in 4/4 time
  private int chordsPerMeasure;
  
  public Fragment(int measures, int chordsPerMeasure, String[] scale, Table table){
    this.measures = measures;
    chords = new Chord[measures * chordsPerMeasure];
    probabilitySettings = table;
    this.scale = scale;
    this.chordsPerMeasure = chordsPerMeasure;
  }
  
  public void generateChords(boolean resolve, String nextChord){
    chords[(2*measures) - 1] = new Chord(randomChord(nextChord), scale, 3, 1, (4*measures) - 1, 2);
    if(resolve){
      chords[(chordsPerMeasure*measures) - 2] = new Chord("I", scale, 3, 1, (4*measures) - 3, 3); //last chord in root position, whole note
    }
    else{
      chords[(2*measures) - 2] = new Chord(randomChord(chords[(2*measures) - 1].getSymbol()), scale, 3, 1, (4*measures) - 3, 2);
    }
    for(int i = (2*measures) - 3; i >= 0; i--){
      chords[i] = new Chord(randomChord(chords[i+1].getSymbol()), scale, 3, 1, (i*2)+1, 2);
    }
    for(int i = 0; i < chords.length; i++){
      if(chords[i] == null){
        System.out.print("-- ");
      }
      else{
        System.out.print(chords[i].getSymbol() + "  ");
      }
    }
    System.out.println();
  }
  
  
  public void generateChords(boolean resolve, String nextChord, String firstChord){
    chords[(2*measures) - 1] = new Chord(randomChord(nextChord), scale, 3, 1, (4*measures) - 1, 2);
    if(resolve){
      chords[(chordsPerMeasure*measures) - 2] = new Chord("I", scale, 3, 1, (4*measures) - 3, 2);
    }
    else{
       chords[(2*measures) - 2] = new Chord(randomChord(nextChord), scale, 3, 1, (4*measures) - 3, 2);
    }
    
    for(int i = (2*measures) - 3; i >= 1; i--){
      chords[i] = new Chord(randomChord(chords[i+1].getSymbol()), scale, 3, 1, (i*2)+1, 2);
    }
    chords[0] = new Chord(firstChord, scale, 3, 1, 1, 2);
    for(int i = 0; i < chords.length; i++){
      System.out.print(chords[i].getSymbol() + "  ");
      //for(NumberNote note : chords[i].getNotes()){
      //  System.out.println(note.getPitch() + " " + note.getOctave());
      //}
    }
    System.out.println();
    //chords = new Chord[1];
    //chords[0] = new Chord("V", scale, 4, 1, 1, 4);
  }
  
  public void generateMelody(boolean resolveToRoot){
    //start with rhythm of melody
    melody = new NumberNote[(4*measures)];
    float[] weights = {melodyComplexity - 1.0, 2.0 - melodyComplexity};
    int randomIndex = int(random(1, 4)); // random number 1, 2, or 3
    
    NumberNote chordNote;
    
    if(chords[chords.length - 1] != null){
      randomIndex = int(random(1, 4)); // random number 1, 2, or 3
      chordNote = chords[chords.length-1].getNote(randomIndex);
      melody[melody.length-2] = new NumberNote(chordNote.getPitch(), 5, 1, (4*measures)-1, 1);
    }
    
    if(resolveToRoot){
      melody[melody.length-4] = new NumberNote(scale[0], 5, 1, (4*measures)-3, 2);
    } else {
      randomIndex = int(random(1, 4)); // random number 1, 2, or 3
      chordNote = chords[randomIndex].getNote(randomIndex);
      melody[melody.length-4] = new NumberNote(chordNote.getPitch(), 5, 1, (4*measures)-3, 2);
    }
    
    for(int i = melody.length - 5; i >= 0 ; i--){
      if (i % 2 == 0){ //strong beat: yes melody note
        randomIndex = int(random(1, 4)); // random number 1, 2, or 3
        chordNote = chords[i/2].getNote(randomIndex);
        int duration;
        if(melody[i+1] == null){duration = 2;}
        else{duration = 1;}
        melody[i] = new NumberNote(chordNote.getPitch(), 5, 1, i+1, duration);
        
      }
      else if(weightedRandomChoice(weights) == 1){  //weak beat: maybe melody note
        NumberNote target = melody[i+1];
        if(target == null){
          System.out.println("Big problem");
        }
        int targetIndex = Arrays.asList(scale).indexOf(target.getPitch());
        int myIndex = targetIndex + 1 + (-2 * int(random(2)));
        if(myIndex == -1){
          myIndex = 6;
        }
        else if(myIndex == 7){
          myIndex = 0;
        }
        else if(myIndex == -2){
          myIndex = 5;
        }
        melody[i] = new NumberNote(scale[myIndex], 5, 1, i+1, 1);
      }
    }
    for (int i = 0; i < melody.length; i++){
      if(melody[i] == null){
        System.out.print("- ");
      }
      else{
        System.out.print(melody[i].getPitch() + " ");
      }
    }
    //melody = new NumberNote[1];
  }
  
  public void makeResolve(){ // this is not right. We'll need to remove a chord prolly.
    chords[chords.length - 1] = null;
    if(melody[melody.length - 1] != null){
      melody[melody.length - 1] = null;
    }
    if(melody[melody.length - 2] != null){
      melody[melody.length - 2] = null;
    }
  }
  
  public void addStartBeat(int beat){
    for(Chord c : chords){
      if(c != null){
        c.addDelay(beat);
      }
    }
    for(NumberNote m : melody){  
      if(m != null){
        m.addToBeat(beat);
      }
    }
  }
  
  public Chord[] getChords(){
    return chords;
  }
  
  public void setChords(Chord[] chords){
    this.chords = chords;
  }
  
  public NumberNote[] getMelody(){
    return melody;
  }
  
  public void setMelody(NumberNote[] m){
    melody = m;
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
    System.out.println("I'm a very stupid program and backed myself into an inescapable corner. Talk to Luca. Next Chord: " + nextChord);
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
  
  public String getFirstChord(){
    return chords[0].getSymbol();
  }
  
  public NumberNote[] getNotes(){
    ArrayList<NumberNote> finalList = new ArrayList<NumberNote>();
    for(Chord c : chords){
      if(c != null){
        NumberNote[] chordNotes = c.getNotes();
        for(NumberNote n : chordNotes){
          finalList.add(n);
        }
      }
    }
    for(NumberNote n : melody){
      if(n != null){
        finalList.add(n);
      }
    }
    
    NumberNote[] finalArray = new NumberNote[finalList.size()];
    return finalList.toArray(finalArray); // NEEDS TO BE NOTES FROM MELODY, CHORDS, AND EVERYTHING ELSE
  }
  
}
