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
  private int beatsPerMeasure;
  private String homeChord;
  private int homeNote;
  
  public Fragment(int measures, int chordsPerMeasure, int beatsPerMeasure, String[] scale, Table table, boolean major){
    this.measures = measures;
    int chordsCount = measures * chordsPerMeasure;
    chords = new Chord[chordsCount];
    probabilitySettings = table;
    this.scale = scale;
    this.chordsPerMeasure = chordsPerMeasure;
    this.beatsPerMeasure = beatsPerMeasure;
    if(major){
      homeChord = "I";
      homeNote = 0;
    }
    else{
      homeChord = "vi";
      homeNote = 5;
    }
    
    System.out.println(homeChord);
  }
  
  public void generateChords(boolean resolve, String nextChord){
    chords[(chordsPerMeasure*measures) - 1] = new Chord(randomChord(nextChord), scale, 3, 1, (((chordsPerMeasure*measures)-1)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure); //leading chord into the next fragment (on beat 3 of either time sig trust)
    if(resolve){
      chords[(chordsPerMeasure*measures) - 2] = new Chord(homeChord, scale, 3, 1, (((chordsPerMeasure*measures)-2)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure);
    }
    else{
      chords[(chordsPerMeasure*measures) - 2] = new Chord(randomChord(chords[(chordsPerMeasure*measures) - 1].getSymbol()), scale, 3, 1, (((chordsPerMeasure*measures)-2)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure);
    }
    for(int i = (chordsPerMeasure*measures) - 3; i >= 0; i--){
      chords[i] = new Chord(randomChord(chords[i+1].getSymbol()), scale, 3, 1, (i*(beatsPerMeasure/chordsPerMeasure))+1, beatsPerMeasure/chordsPerMeasure);
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
    chords[(chordsPerMeasure*measures) - 1] = new Chord(randomChord(nextChord), scale, 3, 1, (((chordsPerMeasure*measures)-1)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure); //leading chord into the next fragment (on beat 3 of either time sig trust)
    if(resolve){
      chords[(chordsPerMeasure*measures) - 2] = new Chord(homeChord, scale, 3, 1, (((chordsPerMeasure*measures)-2)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure);
    }
    else{
      chords[(chordsPerMeasure*measures) - 2] = new Chord(randomChord(chords[(chordsPerMeasure*measures) - 1].getSymbol()), scale, 3, 1, (((chordsPerMeasure*measures)-2)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure);
    }
    for(int i = (chordsPerMeasure*measures) - 3; i >= 1; i--){
      chords[i] = new Chord(randomChord(chords[i+1].getSymbol()), scale, 3, 1, (i*(beatsPerMeasure/chordsPerMeasure))+1, beatsPerMeasure/chordsPerMeasure);
    }
    chords[0] = new Chord(firstChord, scale, 3, 1, 1, beatsPerMeasure/chordsPerMeasure);
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
    melody = new NumberNote[(beatsPerMeasure*measures)];
    float[] weights = {melodyComplexity - 1.0, 2.0 - melodyComplexity};
    int randomIndex; // random number 1, 2, or 3
    
    NumberNote chordNote;
    
    if(chords[chords.length - 1] != null){
      randomIndex = int(random(1, 4)); // random number 1, 2, or 3
      chordNote = chords[chords.length-1].getNote(randomIndex);
      melody[melody.length-2] = new NumberNote(chordNote.getPitch(), 5, 1, (beatsPerMeasure*measures)-1, 1);
    }
    
    if(resolveToRoot){
      melody[melody.length-(2*(beatsPerMeasure/chordsPerMeasure))] = new NumberNote(scale[homeNote], 5, 1, (((chordsPerMeasure*measures)-2)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure);
    } else {
      randomIndex = int(random(1, 4)); // random number 1, 2, or 3
      chordNote = chords[randomIndex].getNote(randomIndex);
      melody[melody.length-(2*(beatsPerMeasure/chordsPerMeasure))] = new NumberNote(chordNote.getPitch(), 5, 1, (((chordsPerMeasure*measures)-2)*(beatsPerMeasure/chordsPerMeasure)) + 1, beatsPerMeasure/chordsPerMeasure);
    }
    
    for(int i = melody.length - (2*(beatsPerMeasure/chordsPerMeasure)) - 1; i >= 0 ; i--){
      if ((i % 2 == 0 && beatsPerMeasure == 4) || (i%3 == 0 && beatsPerMeasure == 3)){ //strong beat: yes melody note
        randomIndex = int(random(1, 4)); // random number 1, 2, or 3
        chordNote = chords[i*chordsPerMeasure/(beatsPerMeasure)].getNote(randomIndex);
        int duration = 1;
        int j = 1;
        while(melody[i+j] == null){
          duration++;
          j++;
        }
        melody[i] = new NumberNote(chordNote.getPitch(), 5, 1, i+1, duration);
        
      }
      else if(melody[i+1] != null && weightedRandomChoice(weights) == 1){  //weak beat: maybe melody note
        NumberNote target = melody[i+1];
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
  
  public void makeResolve(){ 
    chords[chords.length - 1] = null;
    for(int i = melody.length - 1; i >= melody.length -(beatsPerMeasure/chordsPerMeasure); i--){
      if(melody[i] != null){
        melody[i] = null;
      }
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
  
  public NumberNote[] getBassNotes(){
    ArrayList<NumberNote> bassList = new ArrayList<NumberNote>();
    for(Chord c : chords){
      if(c != null){ //this is causing some errors i think -z
        NumberNote bassNote = c.getNote(0); //index 0 = bass note cus I was smart phew
        bassList.add(bassNote);
      }
    }
    NumberNote[] finalArray = new NumberNote[bassList.size()];
    return bassList.toArray(finalArray);
  }
  
  public NumberNote[] getChordNotes(){
    ArrayList<NumberNote> finalList = new ArrayList<NumberNote>();
    for(Chord c : chords){
      if(c != null){
        NumberNote[] chordNotes = c.getNotes();
        for(int i = 1; i < 4; i++){
          finalList.add(chordNotes[i]);
        }
      }
    }
    NumberNote[] finalArray = new NumberNote[finalList.size()];
    return finalList.toArray(finalArray);
  }
  
  public NumberNote[] getMelodyNotes(){     
    ArrayList<NumberNote> melodyList = new ArrayList<NumberNote>();
    for(NumberNote n : melody){
      if(n != null){
        melodyList.add(n);
      }
    }
    NumberNote[] finalArray = new NumberNote[melodyList.size()];
    return melodyList.toArray(finalArray);    
  }
  

  
}
