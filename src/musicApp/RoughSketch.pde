// create a pop song:
// Song september = new PopSong(false, 16, 4, "A#", "Piano"); <-- measures, beats per measure (time sig), key, instrument
//create a jazz song:
// Song jazzyTune = new PopSong(true, 32, 4, "G", "Piano");
// create a classical song:
// Song moonlightSonata = new ClassicalSong(false, 64, 3, "C", "Piano");
// create a skyline song:
// Song olympus = new ClassicalSong(true, 16, 4, "G#", "Piano");
// create a jingle:
// Song mcdonalds = new Jingle(4, "A", "Piano");

//NOTES:
// -please pass me the key signature in SHARP format (example: pass me Bb as A#)
// -Jingle doesn't take a number of measures
// -IDK if this is something you want to do, but songs of different classes can be stored in the same array because they all have super class Song!


//import statements for MIDI, scanners, etc. here
import controlP5.*;
import themidibus.*;
import javax.sound.midi.*;
import java.io.*;
ControlP5 cp5;
String globalPhase, info;
ArrayList<String> lastPhase = new ArrayList<String>();
boolean firstMousePress = false;
boolean major, textGenerated;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean pop; // pop
boolean classical; // classical
Button[] buttons = new Button[52];
Scrollbar[] myScrolls = new Scrollbar[2];
InfoBubble[] infoBubbles = new InfoBubble[5];
PImage logo, mainMenu, genreScreen, chordScreen, lengthScreen, tempoScreen, timeScreen, keyScreen, bassScreen, chordInstrumentScreen, melodyScreen, previewScreen, playScreen, nameScreen, saveScreen, savedSongScreen;
PFont pixel;
MidiBus mBus;
String[] textBoxes;
String[] instruments = new String[3];
//ArrayList<String> instruments = new ArrayList<String>();

Song[] mySongs;
Song userSong;
MIDINote[][] MIDINotes;
int startMillis;
float lastBeat;
int tempo, songLength;
String genre, timeSig, keySig, songName, instrumentsText; //contents of strings are in camel case e.g. electricKeyboard

Jingle j;



//     TO DO : slider for chaos level and tempo, buttons for key and 
//             time signature and type of song (classical/pop for now) ;p
//          
void setup() {
  size(1047,502);
  //images!!! oh joy :)
  logo = loadImage("BlueUpBeat.png");
  logo.resize(350,350);
  mainMenu = loadImage("mainMenu.png");
  mainMenu.resize(width,height);
  genreScreen = loadImage("genreScreen.png");
  genreScreen.resize(width,height);
  chordScreen = loadImage("chordScreen.png");
  chordScreen.resize(width,height);
  lengthScreen = loadImage("lengthScreen.png");
  lengthScreen.resize(width,height);
  tempoScreen = loadImage("tempoScreen.png");
  tempoScreen.resize(width,height);
  timeScreen = loadImage("timeScreen.png");
  timeScreen.resize(width,height);
  keyScreen = loadImage("keyScreen.png");
  keyScreen.resize(width,height);
  bassScreen = loadImage("bassScreen.png");
  bassScreen.resize(width,height);
  chordInstrumentScreen = loadImage("chordsInstrumentScreen.png");
  chordInstrumentScreen.resize(width,height);
  melodyScreen = loadImage("melodyScreen.png");
  melodyScreen.resize(width,height);
  previewScreen = loadImage("previewScreen.png");
  previewScreen.resize(width,height);
  playScreen = loadImage("playScreen.png");
  playScreen.resize(width,height);
  nameScreen = loadImage("nameScreen.png");
  nameScreen.resize(width,height);
  saveScreen = loadImage("saveScreen.png");
  saveScreen.resize(width,height);
  savedSongScreen = loadImage("savedSongsScreen.png");
  savedSongScreen.resize(width,height);
  pixel = createFont("pixel.ttf",30);
  textFont(pixel);
  textAlign(CENTER);
  cp5 = new ControlP5(this);
  textSize(25); 
  globalPhase = "mainMenu";
  info = "";
  //this list of buttons and later sliders and stuff is going to be SUPER long uhm ;-;
  //what i plan on doing is putting all of the buttons and sliders and wheels and widgets into a giant text file then just reading from it :p
  buttons[0] = new Button(715, 203, 276, 116, "Generate New ", "mainMenu", "qGenre", "newSong", false, true);
  buttons[1] = new Button(677, 354, 276, 116, "Load Old Song", "mainMenu", "old", "oldSong", false, true);
  buttons[2] = new Button(746, 50, 276, 116, "Settings", "mainMenu", "mainMenu", "TEMP", false, true);
  
  buttons[3] = new Button(154, 170, 266, 75, "Classical", "qGenre", "qChord", "classical", false, true);
  buttons[4] = new Button(574, 170, 266, 75, "Pop", "qGenre", "qChord", "pop", false, true);
  buttons[5] = new Button(154, 270, 266, 75, "Mr. Skyline", "qGenre", "qChord", "skyline", false, true);
  buttons[6] = new Button(574, 270, 266, 75, "Jazz", "qGenre", "qChord", "jazz", false, true);
  buttons[7] = new Button(382, 380, 266, 75, "Jingle", "qGenre", "qChord", "jingle", false, true);
  
  buttons[8] = new Button(715, 114, 266, 75, "Major", "qChord", "qLength", "major", false, true);
  buttons[9] = new Button(715, 250, 266, 75, "Minor", "qChord", "qLength", "minor", false, true);
  
  myScrolls[0] = new Scrollbar(width/2-200, 300, 400, 30, "qLength", "measures", 1, 8);
  buttons[10] = new Button(865, 395, 172, 80, "Next", "qLength", "qTempo", myScrolls[0].txt, false, true);
  //buttons[8] = new Button(200, 350, 266, 75, "4 measures", "qLength", "qTempo", "4", false, true);
  //buttons[9] = new Button(500, 350, 266, 75, "8 measures", "qLength", "qTempo", "8", false, true);
  //buttons[10] = new Button(800, 350, 266, 75, "16 measures", "qLength", "qTempo", "16", false, true);
  
  myScrolls[1] = new Scrollbar(width/2-200, 350, 400, 30, "qTempo", "bpm", 60, 200);
  buttons[11] = new Button(850, 395, 172, 78, "Next", "qTempo", "qSign", myScrolls[1].txt, false, true);
  
  buttons[12] = new Button(240, 245, 266, 75, "2/2", "qSign", "qKey", "2/2", false, true);
  buttons[13] = new Button(551, 245, 266, 75, "3/4", "qSign", "qKey", "3/4", false, true);
  buttons[14] = new Button(240, 342, 266, 75, "4/4", "qSign", "qKey", "4/4", false, true);
  buttons[15] = new Button(551, 342, 266, 75, "6/8", "qSign", "qKey", "6/8", false, true);
  
  buttons[16] = new Button(780, 22, 40, 30, "6/8", "qKey", "qBassInstrument", "C", true, false);
  buttons[17] = new Button(680, 54, 40, 30, "6/8", "qKey", "qBassInstrument", "F", true, false);
  buttons[18] = new Button(630, 102, 40, 30, "6/8", "qKey", "qBassInstrument", "A#", true, false);
  buttons[19] = new Button(604, 191, 40, 30, "6/8", "qKey", "qBassInstrument", "D#", true, false);
  buttons[20] = new Button(630, 273, 40, 30, "6/8", "qKey", "qBassInstrument", "G#", true, false);
  buttons[21] = new Button(644, 334, 80, 30, "6/8", "qKey", "qBassInstrument", "C#", true, false);
  buttons[22] = new Button(770, 367, 80, 30, "6/8", "qKey", "qBassInstrument", "F#", true, false);
  buttons[23] = new Button(879, 341, 80, 30, "6/8", "qKey", "qBassInstrument", "B", true, false);
  buttons[24] = new Button(937, 278, 40, 30, "6/8", "qKey", "qBassInstrument", "E", true, false);
  buttons[25] = new Button(956, 198, 40, 30, "6/8", "qKey", "qBassInstrument", "A", true, false);
  buttons[26] = new Button(938, 110, 40, 30, "6/8", "qKey", "qBassInstrument", "D", true, false);
  buttons[27] = new Button(883, 58, 40, 30, "6/8", "qKey", "qBassInstrument", "G", true, false);
  buttons[28] = new Button(850, 393, 266, 75, "Next", "qKey", "qBassInstrument", "filler", false, true);
  
  buttons[29] = new Button(63, 198, 266, 80, "Piano", "qBassInstrument", "qMiddleInstrument", "piano", true, true);  
  buttons[30] = new Button(394, 198, 266, 80, "Strings", "qBassInstrument", "qMiddleInstrument", "strings", true, true);
  buttons[31] = new Button(724, 198, 266, 80, "Brass", "qBassInstrument", "qMiddleInstrument", "brass", true, true);
  buttons[32] = new Button(115, 306, 381, 80, "Electric Keyboard", "qBassInstrument", "qMiddleInstrument", "electricKeyboard", true, true);
  buttons[33] = new Button(561, 306, 381, 80, "Electric Bass", "qBassInstrument", "qMiddleInstrument", "electricBass", true, true);
  buttons[34] = new Button(874, 410, 266, 80, "Next", "qBassInstrument", "qMiddleInstrument", "filler", false, true);
  
  buttons[35] = new Button(119, 193, 381, 80, "Piano", "qMiddleInstrument", "qMelInstrument", "piano", true, true);
  buttons[36] = new Button(553, 193, 381, 80, "Strings", "qMiddleInstrument", "qMelInstrument", "strings", true, true);
  buttons[37] = new Button(553, 298, 381, 80, "Brass", "qMiddleInstrument", "qMelInstrument", "brass", true, true);
  buttons[38] = new Button(119, 298, 381, 80, "Electric Keyboard", "qMiddleInstrument", "qMelInstrument", "electricKeyboard", true, true);
  buttons[39] = new Button(857, 396, 266, 80, "Next", "qMiddleInstrument", "qMelInstrument", "filler", false, true);
 
  buttons[40] = new Button(63, 190, 266, 80, "Piano", "qMelInstrument", "preview", "piano", true, true);  
  buttons[41] = new Button(392, 190, 266, 80, "Strings", "qMelInstrument", "preview", "strings", true, true);
  buttons[42] = new Button(724, 190, 266, 80, "Brass", "qMelInstrument", "preview", "brass", true, true);
  buttons[43] = new Button(114, 295, 381, 80, "Electric Keyboard", "qMelInstrument", "preview", "electricKeyboard", true, true);
  buttons[44] = new Button(560, 295, 381, 80, "Lead", "qMelInstrument", "preview", "lead", true, true);
  buttons[45] = new Button(874, 410, 266, 80, "Next", "qMelInstrument", "preview", "next", false, true);
  
  buttons[46] = new Button(295, 395, 175, 80, "Next", "preview", "play", "execute", false, true);
  
  buttons[47] = new Button(120, 380, 266, 75, "Finish", "play", "qName", "stop", false, true);
  buttons[47].displayable = true;
  
  buttons[48] = new Button(856, 400, 176, 76, "Next", "qName", "qSave", "filler", false, true);
                                               //filler here ^^^ will become what is in the textbox once next is clicked
  buttons[49] = new Button(203, 298, 239, 101, "YES", "qSave", "mainMenu", "yesSave", false, true);
  buttons[50] = new Button(650, 298, 239, 101, "NO", "qSave", "mainMenu", "noSave", false, true);
  
  buttons[51] = new Button(23, 391, 180, 80, "Back", "qGenre", "filler", "back", false, true);
  
  //  InfoBubble(float, float, float, String) will take in xposition, yposition, radius, and text in that order. 
  //  Change these as needed!
  //    -Micah
  //                           xpos  ypos
  //                              |  |
  //                              |  |
  //                              v  v
  infoBubbles[0] = new InfoBubble(100, 308, 11, "A genre with randomness\nfine-tuned by our famous\nmusic theorist Mr. Skyline.", "qGenre"); //topleft bubble for Skyline Special
  infoBubbles[1] = new InfoBubble(528, 308, 11, "Rhythmic, improvisational,\nwonderfully chaotic.\nFull of rich harmonies.", "qGenre"); //bottomleft bubble for Jazz
  infoBubbles[2] = new InfoBubble(100, 208, 11, "A good old-fashioned\nclassical composition for\npeople named Jenna Tran.", "qGenre"); //topright bubble for Classical
  infoBubbles[3] = new InfoBubble(528, 208, 11, "Very catchy and melodic\nmusic. Has upbeat rhythms\nand lots of polish.", "qGenre"); //bottomright bubble for Pop
  infoBubbles[4] = new InfoBubble(335, 419, 11, "Short, 4-measure jingle\n with a simple melody.", "qGenre"); //bottom bubble for jingle
  //you can tell which ones I chatgpted very easily. 
  //i am the pro mpt engineer and im not ashamed of it
  
  
  pop = false;  
  classical = false;
  stroke(#1D201F);
  //mySongs = new Song[2];
  //mySongs[0] = new ClassicalSong();
  //mySongs[1] = new PopSong();
  
  instantiateMidiBus();
  MIDINotes = new MIDINote[3][0];
  startMillis = 0;
  lastBeat = 0;
  tempo = 150;
  
  String[] tinstruments = {"electricKeyboard", "electricKeyboard", "electricKeyboard"};
  instruments = tinstruments; //i hate processing
  
  //j = new Jingle(4, "G", true);
  ////j.generate();
  //Song pop = new PopSong(true, 32, 4, "G", true);
  ////pop.generate();
  
  //playSong(pop);
  
  
  
  //cp5.addTextfield("").setPosition(195,271).setSize(657,97).setFont(pixel).setFocus(true).setColor(color(255,100,100)); //todo: find a way to set this so it only appears in qname
}


void draw() {
  //gradients are complicated, apparently T-T
  background(10);
  //smooth(); i think this does something ill test :P
  // new verdict: DEATH TO ALL GRADIENTS
  //for (int i = 0; i <= height; i++) {
  //    float inter = map(i, 0, height, (-0.2), 1);
  //    float inter2 = map(i, 0, height, 0, width);
  //    color c = lerpColor(#df5594, #46bbd5, inter); //can tinker w/ this for some fun stff! #46bbd5
  //    stroke(c);
  //    line(width-(2*inter2), height, width, (height-(2*i))); //swapping height for 0 is very funny (and interesting) line(inter2-i, 0, width, i);
  //  }  
    //UNIVERSAL BACKGROUND
  text(globalPhase, 75, height-50);   //FOR DEBUG PURPOSES
  //case switch statement would be ideal for "phases" or screens
  if (globalPhase == "mainMenu") {
    //MAIN MENU BACKGROUND
  image(mainMenu,0,0);
  }

  fill(255);
  //1st question -z
  //make this a case switch statement
  
  switch (globalPhase) {
    case "qGenre":
      image(genreScreen, 0, 0);
      break;
    case "qChord": 
      image(chordScreen, 0, 0);
      break;
    case "qLength": 
      image(lengthScreen, 0, 0);
      break;
    case "qTempo":
      image(tempoScreen, 0, 0);
      buttons[9].info = myScrolls[0].txt;
      break;
    case "qSign":
      image(timeScreen, 0, 0);
      break;
    case "qKey": 
      image(keyScreen, 0, 0);
      break;
    case "qBassInstrument": 
      image(bassScreen, 0, 0);
      break;
    case "qMiddleInstrument": 
      image(chordInstrumentScreen, 0, 0);
      break;
    case "qMelInstrument": 
      image(melodyScreen, 0, 0);
      break;
    case "preview": 
      image(previewScreen, 0, 0);
      //instrumentsText = instruments[0] + " " + instruments[1] + " " + instruments[2];
      fill(0);
      textSize(25);
      text("Genre: " + genre + "\nMajor?: " + major + "\n" + songLength + " measures\n" + tempo + " bpm\nTime Signature: " + timeSig + "\nKey Signature: " + keySig + "\nBass Instrument: " + instruments[0] + "\nMiddle Instrument: " + instruments[1] + "\nMelody Instrument: " + instruments[2], 852, 105);
      break;
    case "play": 
      image(playScreen, 0, 0);
      break;
    case "qName": 
      image(nameScreen, 0, 0);
      if (textGenerated == false) {
          cp5.addTextfield("").setPosition(195,271).setSize(657,97).setFont(pixel).setFocus(true).setColor(color(255,100,100));
          textGenerated = true;
      }
      break;
    case "qSave": 
      image(saveScreen, 0, 0);
      break;
    case "old":
      image(savedSongScreen, 0, 0);
      break;
    case "settings":
      textSize(50);
      text("work in progress c:", width/2, height/2);
      break;
  //fill(100, 70);               tint over the whole screen lol
  //rect(0,0,width,height);
  }
  
    //rendering buttons -z
  for (int i=0; i<buttons.length; i++) {
    if (globalPhase == buttons[i].localPhase) {
      if(buttons[i].info == "back") {
          if (globalPhase!="play" && globalPhase!="qName" && globalPhase != "qSave" && globalPhase !="mainMenu") {
          buttons[i].display();
          buttons[i].hover(mouseX, mouseY);
        }
      }
      else {
      buttons[i].display();
      buttons[i].hover(mouseX, mouseY);
      }  
    }
  }
  
  //rendering scrollbars smiley face -z
  for (int i=0; i<myScrolls.length; i++) {
     if (globalPhase == myScrolls[i].phase) {
       myScrolls[i].update();
       myScrolls[i].display();
     }
   }
  //rendering infobubbles!!!! ty micah for making these c:
  for (int i=0; i<infoBubbles.length; i++) {
    if(globalPhase == infoBubbles[i].phase) {
      infoBubbles[i].display(); 
    }
  }
  
  //actually playing songs (Micah)
  if (MIDINotes[0].length > 0) {
    float millisPerBeat = 60000/tempo;
    float currentBeat = (millis() - startMillis)/millisPerBeat;
    
    for (int i=0; i<MIDINotes.length; i++) { //loops over every instrument
      MIDINote[] midiArray = MIDINotes[i];
      
      for (MIDINote mn : midiArray) { //loops over ever beat
        if (mn != null) {
          float start = mn.getBeat();
          float end = start + mn.getDuration();
          int channel = i;
          
          if (lastBeat < start && start <= currentBeat) {
            //mBus.sendControllerChange(channel, 0, 90);
            //mBus.sendMessage(0xC0 | channel, getProgramNumber(instruments[i]));
            mBus.sendNoteOn(channel, mn.getPitch(), mn.getVelocity());   //note began between this and last frame
          }
          if (lastBeat < end && end <= currentBeat) {
            //mBus.sendControllerChange(channel, 0, 90);
            //mBus.sendMessage(0xC0 | channel, getProgramNumber(instruments[i]));
            mBus.sendNoteOff(channel, mn.getPitch(), mn.getVelocity());  //note ended between this and last frame
          }
        }
      }
    }
    lastBeat = currentBeat;
    
    
    
  }
    //text((str(mouseX) + " " + str(mouseY)), mouseX, mouseY);     //FOR DEBUG PURPOSES ONLY
}


//to-do: make it so when you click, buttons[i].info will be stored - this will depend on which screen it's on though
//for example, if(globalPhase == "qGenre") { 
// genre = buttons[i].info; } etc etc
//maybe make a whole case switch statement in here? I can't think of an easier way to do this
//because each individual variable will need to be defined and that depends on which screen we're on
//makes it so clicking buttons does stuff!! :) -z
void mousePressed() { //if you click
 for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) { // and if a button is being displayed
       if (buttons[i].on == true) { // and if you clicked inside the button's box
        // if (buttons[i].text != "filler") {
      switch (globalPhase) { 
        case "qGenre": 
          //System.out.println(cp5.get(Textfield.class,"").getText()); FOR DEBUG PURPOSES ONLY
          genre = buttons[i].info;
          break;
        case "qChord": 
          if (buttons[i].info == "major") {
            major = true;
            break;
          } 
          if (buttons[i].info == "minor") {
            major = false;
            break;
          }
          break;
        case "qLength": 
          songLength = int(myScrolls[0].txt);
          break;
        case "qTempo": 
          tempo = int(myScrolls[1].txt); //buttons[i].info doesnt work??? man idk and its 12;30 im tired ;-;
          break;
        case "qSign": 
          timeSig = buttons[i].info;
          break;
        case "qKey": 
          if (buttons[i].toggleable == true) {
            if (buttons[i].toggled == false) {
              keySig = buttons[i].info;
              for (int m = 0; m<buttons.length; m++) {
                 buttons[m].toggled = false; //resets each button to not be toggled
              }
              buttons[i].toggled = true; //sets only the clicked button to be toggled
              break;
            }
            if (buttons[i].toggled == true) { //if u click a toggled toggleable button
              keySig = "";
              buttons[i].toggled = false;
              break;
            }
          }
          break;
        case "qBassInstrument": 
          if (buttons[i].toggleable == true) {
            if (buttons[i].toggled == false) {
              instruments[0] = buttons[i].info;
              for (int m = 0; m<buttons.length; m++) {
                 buttons[m].toggled = false; //resets each button to not be toggled
              }
              buttons[i].toggled = true; //sets only the clicked button to be toggled
              break;
            }
            if (buttons[i].toggled == true) { //if u click a toggled toggleable button
              instruments[0] = "";
              buttons[i].toggled = false;
              break;
            }
          }
         
          case "qMiddleInstrument": 
          if (buttons[i].toggleable == true) {
            if (buttons[i].toggled == false) {
              instruments[1] = buttons[i].info;
              for (int m = 0; m<buttons.length; m++) {
                 buttons[m].toggled = false; //resets each button to not be toggled
              }
              buttons[i].toggled = true; //sets only the clicked button to be toggled
              break;
            }
            if (buttons[i].toggled == true) { 
              instruments[1] = "";
              buttons[i].toggled = false;
              break;
            }
          }
          
          case "qMelInstrument": 
          if (buttons[i].toggleable == true) {
            if (buttons[i].toggled == false) {
              instruments[2] = buttons[i].info;
              for (int m = 0; m<buttons.length; m++) {
                 buttons[m].toggled = false; //resets each button to not be toggled
              }
              buttons[i].toggled = true; //sets only the clicked button to be toggled
              break;
            }
            if (buttons[i].toggled == true) { 
              instruments[2] = "";
              buttons[i].toggled = false;
              break;
            }
          }
          break;
        case "preview": 
          if (buttons[i].info != "back") {
            if (timeSig == "3/4") {
              timeSig = "3"; 
            }
            if (timeSig == "6/8") {
              timeSig = "3";
              songLength*=2;
              
            }
            if (timeSig == "2/2") {
              timeSig = "4";
              tempo *=2;
            }
            if (timeSig == "4/4") { //gaslighting :)
              timeSig = "4"; 
            }
            if (genre == "pop") {
              userSong = new PopSong(false, songLength, int(timeSig), keySig, major);
            }
            if (genre == "jazz") {
              userSong = new PopSong(true, songLength, int(timeSig), keySig, major);
            }
            if (genre == "classical") {
              userSong = new ClassicalSong(false, songLength, int(timeSig), keySig, major); 
            }
            if (genre == "skyline") {
              userSong = new ClassicalSong(true, songLength, int(timeSig), keySig, major); 
            }
            if (genre == "jingle") {
              userSong = new Jingle(int(timeSig), keySig, major); 
            }
            userSong.generate();
            playSong(userSong);
            //songNumber++;    //increment the songNumber each time a new song is generated - so u do mySongs[songNumber] = new Song()...
          }
          break;
        case "play":
          textGenerated = false;
          break;
        case "qName": 
          songName = cp5.get(Textfield.class,"").getText();
          cp5.get(Textfield.class,"").remove();
          break;
        case "qSave": 
          if (buttons[i].text == "YES") {
            saveSong(songName); 
            break;
          }
          else {
            break; 
          }
        }
         if (buttons[i].toggleable == false) {
           if (buttons[i].info == "back") {
             globalPhase = lastPhase.get(lastPhase.size()-1);
             if (lastPhase.size() != 1) {
               buttons[i].localPhase = globalPhase;
             }
             lastPhase.remove(lastPhase.size()-1);
           } else {
             lastPhase.add(globalPhase);
             globalPhase = buttons[i].inside();
             buttons[51].localPhase = globalPhase; //back button appears on every screen
             break;
           }
         }
         //if (lastPhase.size() == 13) {
           //lastPhase.clear();
           //for (int n=lastPhase.size(); n>0; n--) {
             //lastPhase.remove(n-1);
          //}
         //}
       }
     }
   }
}

void mouseReleased() {
  //playSong(j);
  //saveSong("The very first song");
}

//function made by Micah Tien
void instantiateMidiBus() {
  
  mBus = new MidiBus();
  mBus.registerParent(this);
  String OS = platformNames[platform];
  if (OS.equals("windows")) {
    mBus.addInput(0);
    mBus.addOutput(3);
  } else if (OS.equals("macos")) {
    mBus.addInput(1);
    mBus.addOutput(2);
    println("MacOS doesn't have a built-in synthesizer available for Processing.");
    println("To hear sound as this is running, you should open GarageBand, SimpleSynth, or another MIDI synthesizer.");
    println("If MidiBus just spit out an error, you need to o into Audio MIDI Setup, view > ports, open the first port, and put it online.");
    println("For more help, check our README.md :)");
  } else {
    println("eww linux");
  } 
  
}

//function made by Micah Tien
void playSong(Song smong) {
  smong.generate();
  MIDINotes = smong.midiNotes();
  startMillis = millis();
  lastBeat = 0;
  for (int i=0; i<instruments.length; i++) {
    mBus.sendControllerChange(i, 0, 90);
    mBus.sendMessage(0xC0 | i, getProgramNumber(instruments[i]));
  }
}

//function made by Micah Tien
int getProgramNumber(String instr) {
  switch (instr) {
    case "strings":
      return 40;
    case "bass":
      return 32;
    case "electricKeyboard":
      return 4;
    case "brass":
      return 56;
    case "lead":
      return 80;
    case "piano":
    default:
      return 0; //if no instrument, just use the basic basic piano
  }
}

//function made by Micah Tien
void saveSong(String songName) {
  try {
    Sequence sequence = new Sequence(Sequence.PPQ, 480);
    Track track = sequence.createTrack();
    
    //tempo
    MetaMessage tempoMessage = new MetaMessage();
    int mpqn = 60000000 / tempo; //microseconds per quarter note
    byte[] tempoData = {(byte) ((mpqn >> 16) & 0xFF), (byte) ((mpqn >> 8) & 0xFF), (byte) (mpqn & 0xFF)}; //stolen from mr gpt
    tempoMessage.setMessage(0x51, tempoData, 3);
    track.add(new MidiEvent(tempoMessage, 0));
    
    for (int i=0; i<MIDINotes.length; i++) {
      
      //instruments
      ShortMessage programChange = new ShortMessage();
      programChange.setMessage(ShortMessage.PROGRAM_CHANGE, i, getProgramNumber(instruments[i]), 0);
      track.add(new MidiEvent(programChange, 0));
      
      //note info
      for (MIDINote mn : MIDINotes[i]) {
        if (mn != null) {
          //MIDI is dumb and uses long instead of float
          ShortMessage noteOn = new ShortMessage();
          noteOn.setMessage(ShortMessage.NOTE_ON, i, mn.getPitch(), mn.getVelocity());
          track.add(new MidiEvent(noteOn, (long) (mn.getBeat() * 480)));
  
          ShortMessage noteOff = new ShortMessage();
          noteOff.setMessage(ShortMessage.NOTE_OFF, i, mn.getPitch(), 0);
          track.add(new MidiEvent(noteOff, (long) ((mn.getBeat()+mn.getDuration()) * 480)));
        }
      }
    }
    
    songName += ".mid";
    File midiFile = new File(songName);
    MidiSystem.write(sequence, 1, midiFile);
    println(songName + " saved to absolute path: " + midiFile.getAbsolutePath());

  } catch (Exception e) {
    e.printStackTrace();
  }
}

//erm
//textbox things??../12/? stuff!@?>?
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}
