// NOTE TO FRONTEND NERDS: (LOOKING AT YOU ZACK AND JENNA)
// IN ORDER TO TEST OUR PROGRAM,
// CREATE A NEW INSTANTIATION OF THE "Jingle" CLASS
// THE JINGLE CLASS TAKES IN A KEY SIGNATURE AND A NUMBER OF MEASURES RIGHT NOW, LIKE SO:
// Jingle j = new Jingle("C", 4);
// LET'S JUST DO FOUR MEASURES FOR RIGHT NOW
// IN ORDER TO CREATE THE SONG, CALL THE "generate" FUNCTION:
// j.generate();
// THEN IN ORDER TO PLAY THE SONG, CALL THE "play()" FUNCTION:
// j.play();


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
Button[] buttons = new Button[24];
Scrollbar[] myScrolls = new Scrollbar[1];
PImage logo;
PFont pixel;
MidiBus mBus;
String[] textBoxes;

Song[] mySongs;
MIDINote[] MIDINotes;
int startMillis;
float lastBeat;

String keY, measures;


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
  buttons[0] = new Button(850, 150, 300, 100, "Generate New Song", "mainMenu", "qGenre", "newSong");
  buttons[1] = new Button(850, 300, 300, 100, "Load Old Song", "mainMenu", "old", "oldSong");
  buttons[2] = new Button(850, 450, 300, 100, "Settings", "mainMenu", "settings", "TEMP");
  
  buttons[3] = new Button(200, 350, 250, 70, "Classical Song", "qGenre", "qLength", "classical");
  buttons[4] = new Button(500, 350, 250, 70, "Pop Song", "qGenre", "qLength", "pop");
  buttons[5] = new Button(800, 350, 250, 70, "Mr. Skyline", "qGenre", "qLength", "skyline");
  
  buttons[6] = new Button(200, 350, 250, 70, "", "qLength", "qTempo", "1:00");
  buttons[7] = new Button(500, 350, 250, 70, "1:30", "qLength", "qTempo", "1:30");
  buttons[8] = new Button(800, 350, 250, 70, "2:00", "qLength", "qTempo", "2:00");
  
  myScrolls[0] = new Scrollbar(width/2-200, 350, 400, 30, "qTempo", "bpm", 60, 200);
  buttons[9] = new Button(500, 500, 250, 70, "Done", "qTempo", "qSign", myScrolls[0].txt);
  
  buttons[10] = new Button(400, 250, 250, 70, "2/4", "qSign", "qKey", "2/4");
  buttons[11] = new Button(800, 250, 250, 70, "3/4", "qSign", "qKey", "3/4");
  buttons[12] = new Button(400, 400, 250, 70, "4/4", "qSign", "qKey", "4/4");
  buttons[13] = new Button(800, 400, 250, 70, "6/8", "qSign", "qKey", "6/8");
  
  buttons[14] = new Button(800, 550, 250, 70, "Next", "qKey", "qInstruments", "filler");
  
  buttons[15] = new Button(400, 250, 250, 70, "Piano", "qInstruments", "preview", "Piano");  //big todo: make these toggles 
  buttons[16] = new Button(800, 250, 250, 70, "Violin", "qInstruments", "preview", "Violin");//so that you can have multiple
  buttons[17] = new Button(400, 400, 250, 70, "Trumpet", "qInstruments", "preview", "Trumpet");//instruments
  buttons[18] = new Button(800, 400, 250, 70, "Flute", "qInstruments", "preview", "Flute");
  
  buttons[19] = new Button(800, 550, 250, 70, "Next", "preview", "play", "execute"  );
  
  buttons[20] = new Button(800, 550, 250, 70, "Finish", "play", "qName", "stop");
  
  buttons[21] = new Button(800, 550, 250, 70, "Next", "qName", "qSave", "filler");
                                               //filler here ^^^ will become what is in the textbox once next is clicked
  buttons[22] = new Button(400, 550, 250, 70, "Yes", "qSave", "mainMenu", "yesSave");
  buttons[23] = new Button(800, 550, 250, 70, "No", "qSave", "mainMenu", "noSave");
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
  
  cp5.setPosition(20,20).addTextfield("").setSize(100,40).setFont(pixel).setFocus(true).setColor(color(255,100,100));
}


void draw() {
  //gradients are complicated, apparently T-T
  background(10);
  strokeWeight(4); //tinker w/this
  //smooth(); i think this does something ill test :P
  for (int i = 0; i <= height; i++) {
      float inter = map(i, 0, height, (-0.2), 1);
      float inter2 = map(i, 0, height, 0, width);
      color c = lerpColor(#df5594, #46bbd5, inter); //can tinker w/ this for some fun stff! #46bbd5
      stroke(c);
      line(width-(2*inter2), height, width, (height-(2*i))); //swapping height for 0 is very funny (and interesting) line(inter2-i, 0, width, i);
    }  
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
    int tempo = 120; //this will get set by zach later;
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



//makes it so clicking buttons does stuff!! :) -z
void mousePressed() {
 for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       if (buttons[i].on == true) {
       globalPhase = buttons[i].inside();
       break;
       }
     }
   }
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
