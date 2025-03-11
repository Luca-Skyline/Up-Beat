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
ControlP5 cp5;

String globalPhase;
boolean firstMousePress = false;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean pop; // pop
boolean classical; // classical
Button[] buttons = new Button[25];
Scrollbar[] myScrolls = new Scrollbar[1];
PImage logo;
PFont pixel;
MidiBus mBus;
String[] textBoxes;

ArrayList<String> instruments = new ArrayList<String>();

Song[] mySongs;
MIDINote[] MIDINotes;
int startMillis;
float lastBeat;
int tempo, songLength;
String genre, timeSig, keySig, songName, instrumentsText;

Jingle j;



//     TO DO : slider for chaos level and tempo, buttons for key and 
//             time signature and type of song (classical/pop for now) ;p
//          
void setup() {
  size(1200,700);
  logo = loadImage("BlueUpBeat.png");
  logo.resize(350,350);
  pixel = createFont("pixel.ttf",30);
  textFont(pixel);
  textAlign(CENTER);
  imageMode(CENTER);
  cp5 = new ControlP5(this);
  textSize(25); 
  globalPhase = "mainMenu";
  //this list of buttons and later sliders and stuff is going to be SUPER long uhm ;-;
  //what i plan on doing is putting all of the buttons and sliders and wheels and widgets into a giant text file then just reading from it :p
  buttons[0] = new Button(850, 150, 300, 100, "Generate New Song", "mainMenu", "qGenre", "newSong", false);
  buttons[1] = new Button(850, 300, 300, 100, "Load Old Song", "mainMenu", "old", "oldSong", false);
  buttons[2] = new Button(850, 450, 300, 100, "Settings", "mainMenu", "settings", "TEMP", false);
  
  buttons[3] = new Button(200, 350, 250, 70, "Classical Song", "qGenre", "qLength", "classical", false);
  buttons[4] = new Button(500, 350, 250, 70, "Pop Song", "qGenre", "qLength", "pop", false);
  buttons[5] = new Button(800, 350, 250, 70, "Mr. Skyline", "qGenre", "qLength", "skyline", false);
  
  buttons[6] = new Button(200, 350, 250, 70, "4 measures", "qLength", "qTempo", "4", false);
  buttons[7] = new Button(500, 350, 250, 70, "8 measures", "qLength", "qTempo", "8", false);
  buttons[8] = new Button(800, 350, 250, 70, "16 measures", "qLength", "qTempo", "16", false);
  
  myScrolls[0] = new Scrollbar(width/2-200, 350, 400, 30, "qTempo", "bpm", 60, 200);
  buttons[9] = new Button(500, 500, 250, 70, "Done", "qTempo", "qSign", myScrolls[0].txt, false);
  
  buttons[10] = new Button(400, 250, 250, 70, "2/4", "qSign", "qKey", "2/4", false);
  buttons[11] = new Button(800, 250, 250, 70, "3/4", "qSign", "qKey", "3/4", false);
  buttons[12] = new Button(400, 400, 250, 70, "4/4", "qSign", "qKey", "4/4", false);
  buttons[13] = new Button(800, 400, 250, 70, "6/8", "qSign", "qKey", "6/8", false);
  
  buttons[14] = new Button(800, 550, 250, 70, "Next", "qKey", "qInstruments", "filler", false);
  
  buttons[15] = new Button(400, 250, 250, 70, "Piano", "qInstruments", "preview", "Piano", true);  //big todo: make these toggles 
  buttons[16] = new Button(800, 250, 250, 70, "Violin", "qInstruments", "preview", "Violin", true);//so that you can have multiple
  buttons[17] = new Button(400, 400, 250, 70, "Trumpet", "qInstruments", "preview", "Trumpet", true);//instruments
  buttons[18] = new Button(800, 400, 250, 70, "Flute", "qInstruments", "preview", "Flute", true);
  buttons[19] = new Button(800, 500, 250, 70, "Next", "qInstruments", "preview", "filler", false);
  
  buttons[20] = new Button(800, 550, 250, 70, "Next", "preview", "play", "execute", false);
  
  buttons[21] = new Button(800, 550, 250, 70, "Finish", "play", "qName", "stop", false);
  
  buttons[22] = new Button(800, 550, 250, 70, "Next", "qName", "qSave", "filler", false);
                                               //filler here ^^^ will become what is in the textbox once next is clicked
  buttons[23] = new Button(400, 550, 250, 70, "Yes", "qSave", "mainMenu", "yesSave", false);
  buttons[24] = new Button(800, 550, 250, 70, "No", "qSave", "mainMenu", "noSave", false);
  pop = false;  
  classical = false;
  stroke(#1D201F);
  //mySongs = new Song[2];
  //mySongs[0] = new ClassicalSong();
  //mySongs[1] = new PopSong();
  
  instantiateMidiBus();
  MIDINotes = new MIDINote[0];
  startMillis = 0;
  lastBeat = 0;
  tempo = 160;
  
//<<<<<<< Updated upstream
  Jingle j = new Jingle(4, "C", "Piano");
  //j.generate();
  Song pop = new PopSong(false, 32, 4, "G", "Piano");
  //pop.generate();
  //playSong(pop);
//=======
  //j = new Jingle("G", 4);
//>>>>>>> Stashed changes
  
  cp5.addTextfield("").setPosition(20,20).setSize(100,40).setFont(pixel).setFocus(true).setColor(color(255,100,100));
}


void draw() {
  //gradients are complicated, apparently T-T
  background(10);
  strokeWeight(4); //tinker w/this
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
  noStroke();
  fill(#f7b4e1); 
  quad(800,0,width,0,width,height,600,height);
  fill(#df5594);
  quad(1050,0,width,0,width,height,850,height); //aaaaaa these pinks hurt my eyes,,,, so bright./ ;-;
  fill(255);
  quad(600,height,620,height,820,0,800,0);
  text(globalPhase, 75, height-50);   //FOR DEBUG PURPOSES
  //case switch statement would be ideal for "phases" or screens
  
  if (globalPhase == "mainMenu") {
    //MAIN MENU BACKGROUND
  textSize(80);
  fill(#df5594);
  text("Welcome to", 300, 155);
  fill(255);
  text("Welcome to", 300, 150); 
  textSize(30);
  image(logo, 300,400);
  quad(580,height,587,height,787,0,780,0);
  }
  
  //rendering buttons -z
  for (int i=0; i<buttons.length; i++) {
    if (globalPhase == buttons[i].localPhase) {
      buttons[i].display();
      buttons[i].hover(mouseX, mouseY);
    }
  }
  
  //rendering scrollbars smiley face -z
  for (int i=0; i<myScrolls.length; i++) {
     if (globalPhase == myScrolls[i].phase) {
       myScrolls[i].update();
       myScrolls[i].display();
     }
   }
  fill(255);
  //1st question -z
  //make this a case switch statement
  
  switch (globalPhase) {
    case "qGenre":
      fill(255);
      text("What genre of music would you like your song to be?", width/2, 80);
      break;
      
    case "qLength": 
      fill(255);
      //textSize(30);
      text("How long would you like your song to be?", width/2, 80);
      break;
      
    case "qTempo":
      textSize(30);
      text("What tempo would you like your song to be?", width/2, 80);
      buttons[9].info = myScrolls[0].txt;
      break;
    case "qSign":
    textSize(75);
      text("Time Signature", width/4, 50);
      textSize(20);
      text("Specifies how many note values of a particular type\nare contained in each measure (bar)", width/4, 80);
      textSize(30);
      break;
    case "qKey": 
      text("Select Key Signature:", width/2, 50);
      textSize(20);
      text("Combinations of sharps or flats indicating the key of a composition (WIP currently)", width/2, 80);
      textSize(30);
      break;
    case "qInstruments": 
    textSize(30);
      text("Select which instrument you would like your song to be played by", width/2, 50);
      break;
    case "preview": 
    System.out.println(instrumentsText);
      textSize(75);
      text("Overview", (width/2)-70, 70);
      textSize(30);
      text("Genre: " + genre + "\n" + songLength + " measures\n" + tempo + " bpm\nTime Signature: " + timeSig + "\nKey Signature: " + keySig + "\n Instrument(s): " + instrumentsText, (width/2)-250, height/3);
    case "qName": 
      //buttons[i].info = whatevers in the text box; (i=21 currently)
      break;
    case "old":
      textSize(50);
      text("work in progress c:", width/2, height/2);
      break;
    case "settings":
      textSize(50);
      text("work in progress c:", width/2, height/2);
      break;
  //fill(100, 70);               tint over the whole screen lol
  //rect(0,0,width,height);
  }
  
  //actually playing songs (Micah)
  if (MIDINotes.length > 0) {
    float millisPerBeat = 60000/tempo;
    
    float currentBeat = (millis() - startMillis)/millisPerBeat;
    boolean songEnded = true;
    for (MIDINote mn : MIDINotes) {
      float start = mn.getBeat();
      float end = start + mn.getDuration();
      if (start > lastBeat && start <= currentBeat) { //beat started between last frame and this frame
        mBus.sendNoteOn(mn.getPitch(), mn.getPitch(), mn.getVelocity());
      }
      if (end > lastBeat && end <= currentBeat) { //beat ended between last frame and this frame
        mBus.sendNoteOff(mn.getPitch(), mn.getPitch(), mn.getVelocity());
      }
      
      if (currentBeat < end) { //note hasn't been played yet 
        songEnded = false;
      }
    }
    lastBeat = currentBeat;
    if (songEnded) MIDINotes = new MIDINote[0]; //songs over, you can stop doing this code
  }
}


//to-do: make it so when you click, buttons[i].info will be stored - this will depend on which screen it's on though
//for example, if(globalPhase == "qGenre") { 
// genre = buttons[i].info; } etc etc
//maybe make a whole case switch statement in here? I can't think of an easier way to do this
//because each individual variable will need to be defined and that depends on which screen we're on
//makes it so clicking buttons does stuff!! :) -z
void mousePressed() {
 for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       if (buttons[i].on == true) {
        // if (buttons[i].info != "filler") {
      switch (globalPhase) { 
        case "qGenre": 
          System.out.println(cp5.get(Textfield.class,"").getText());
          genre = buttons[i].info;
          break;
        case "qLength": 
          songLength = int(buttons[i].info);
          break;
        case "qTempo": 
          tempo = int(buttons[i].info);
          break;
        case "qSign": 
          timeSig = buttons[i].info;
          break;
        case "qKey": 
          keySig = buttons[i].info;
          break;
        case "qInstruments": 
          if (buttons[i].toggleable == true) {
            if (buttons[i].toggled == false) {
              instruments.add(buttons[i].info);
              buttons[i].toggled = true;
              break;
            }
            if (buttons[i].toggled == true) {
              instruments.remove(instruments.size()-1);
              buttons[i].toggled = false;
              break;
            }
          } 
          if (buttons[i].toggleable == false)  {
              for (int q = 0; q< instruments.size(); q++) {
                instrumentsText   += instruments.get(q) + " ";
              } 
              instrumentsText = instrumentsText.substring(4);
              break;
          }
          
          //for instruments you're gonna have to make smth to make it do multiple
          //maybe add a toggleable boolean to button, all instrument buttons are
          //toggleable, so here instruments += all the toggled buttons (use for loop ig) //further add-on: make an arraylist for this
          //or maybe have instrument1, instrument2, etc
        case "qName": 
          songName = cp5.get(Textfield.class,"").getText();
          break;
        }
    //    }
       if (buttons[i].toggleable == false) {
       globalPhase = buttons[i].inside();
       break;
       }
       }
     }
   }
}

void mouseReleased() {
  //playSong(j);
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
