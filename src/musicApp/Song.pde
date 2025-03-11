// Luca DalCanto and Micah Tien

import java.util.Arrays;
import java.util.Random;
import themidibus.*;

abstract class Song {
  protected int measures;
  protected String name;
  protected float duration;
  protected int sharps;
  protected NumberNote[] allNotes; //final combination of all notes
  protected String[] scale;
  protected Table probabilitySettings;
  protected Fragment[] myFragments;
  protected int timeSignature;
  
  //constructor by Luca DalCanto (this is where the magic happens)
  protected Song(int measures, String keySignature, int timeSignature, String instrument){
    this.timeSignature = timeSignature;
    this.measures = measures;
    
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
    
  }
  
  void printScale(){
    System.out.println("Number of Sharps: " + sharps);
    for(String note : scale){
      System.out.print(note + " ");
    }
  }
  
  abstract public void generate();
  public ArrayList<MIDINote[]> midiNotes(){
    ArrayList<NumberNote> finalList = new ArrayList<NumberNote>();
    for(Fragment f : myFragments){
      NumberNote[] fragmentList = f.getNotes();
      for(NumberNote n : fragmentList){
        finalList.add(n);
      }
    }
    
    NumberNote[] finalArray = new NumberNote[finalList.size()];
    finalArray = finalList.toArray(finalArray);
    MIDINote[] noteArray = new MIDINote[finalList.size()];
    
    for (int i=0; i<finalArray.length; i++) {
      NumberNote nNote = finalArray[i];
      noteArray[i] = nNote.convertToMidiNote();
    }
    
    //PLEASE add a sorting function right here please
    // - micah
    
    
    //this is temp code! right now it will just return one instrument. this will need to be changed later for sure
    ArrayList<MIDINote[]> midiNotesList = new ArrayList<MIDINote[]>();
    midiNotesList.add(noteArray);
    
    return midiNotesList;
  }
}
