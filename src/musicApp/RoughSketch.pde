//import statements for MIDI, scanners, etc. here

String globalPhase;
boolean firstMousePress = false;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean pop; // pop
boolean classical; // classical
Button[] buttons = new Button[9];
Scrollbar[] myScrolls = new Scrollbar[1];
PImage logo;
PFont pixel;
import themidibus.*;
MidiBus basicBus;


Song[] mySongs;


//     TO DO : slider for chaos level and tempo, buttons for key and 
//             time signature and type of song (classical/pop for now) ;p
//          
void setup() {
  size(1200,700);
  logo = loadImage("UpBeatLogo.png");
  logo.resize(350,350);
  pixel = createFont("pixel.ttf",30);
  textFont(pixel);
  textAlign(CENTER);
  imageMode(CENTER);
  textSize(25); 
  globalPhase = "mainMenu";
  //this list of buttons and later sliders and stuff is going to be SUPER long uhm ;-;
  //what i plan on doing is putting all of the buttons and sliders and wheels and widgets into a giant text file then just reading from it :p
  buttons[0] = new Button(850, 150, 300, 100, "Generate New Song", "mainMenu", "q1", "newSong");
  buttons[1] = new Button(850, 300, 300, 100, "Load Old Song", "mainMenu", "old", "oldSong");
  buttons[2] = new Button(850, 450, 300, 100, "Settings", "mainMenu", "settings", "TEMP");
  
  //this makes it go from q1 to q3 an im going insane laksdjflkasdjflkasdjf
  buttons[3] = new Button(200, 350, 250, 70, "Classical Song", "q1", "q2", "classical");
  buttons[4] = new Button(500, 350, 250, 70, "Pop Song", "q1", "q2", "pop");
  buttons[5] = new Button(800, 350, 250, 70, "Mr. Skyline", "q1", "q2", "skyline");
  //deleting these next 3 buttons makes it work but why
  buttons[6] = new Button(200, 350, 250, 70, "1:00", "q2", "q3", "1:00");
  buttons[7] = new Button(500, 350, 250, 70, "1:30", "q2", "q3", "1:30");
  buttons[8] = new Button(800, 350, 250, 70, "2:00", "q2", "q3", "2:00");
  
  myScrolls[0] = new Scrollbar(width/2-200, height/2+100, 400, 50, "q3", "bpm", 60, 200);

  pop = false;  
  classical = false;
  stroke(#1D201F);
  //mySongs = new Song[2];
  //mySongs[0] = new ClassicalSong();
  //mySongs[1] = new PopSong();
  
  instantiateMidiBus();
  
  lucaTest();
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
  noStroke();
  fill(#f7b4e1); 
  quad(800,0,width,0,width,height,600,height);
  fill(#df5594);
  quad(1050,0,width,0,width,height,850,height); //aaaaaa these pinks hurt my eyes,,,, so bright./ ;-;
  fill(255);
  quad(600,height,620,height,820,0,800,0);
  text(globalPhase, 50, 50);
  //case switch statement would be ideal for "phases" or screens
  if (globalPhase == "mainMenu") {
  textSize(80);
  fill(150);
  text("Welcome to", 300, 156);
  fill(255);
  text("Welcome to", 300, 150); 
  textSize(30);
  image(logo, 300,400);
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
  if (globalPhase == "q1") {
    fill(255);
    text("What genre of song would you like your song to be?", width/2, 200);
  }
  if (globalPhase == "q2") {
   fill(255);
   //textSize(30);
   text("How long would you like your song to be?", width/2, 80);
  }
  if (globalPhase == "q3") {
    textSize(30);
    text("what tempo would you like your song to be?", width/2, 180);
  }
  if (globalPhase == "old" || globalPhase == "settings") {
   textSize(50);
   text("work in progress c:", width/2, height/2);
  }
  //fill(100, 70);               tint over the whole screen lol
  //rect(0,0,width,height);
}

//this is Luca's way to test his stuff in the console for rn so he can have an entry point.
void lucaTest(){
  Jingle j = new Jingle("C", 4);
  j.generate();
}

//makes it so clicking buttons does stuff!! :)
void mousePressed() {
 for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       globalPhase = buttons[i].inside();
       break;
     }
   }
}

//function made by Micah Tien
void instantiateMidiBus() {
  
  basicBus = new MidiBus();
  basicBus.registerParent(this);
  String OS = platformNames[platform];
  if (OS.equals("windows")) {
    basicBus.addInput(0);
    basicBus.addOutput(3);
  } else if (OS.equals("macos")) {
    basicBus.addInput(1);
    basicBus.addOutput(2);
    println("MacOS doesn't have a built-in synthesizer available for Processing.");
    println("To hear sound as this is running, you should open GarageBand, SimpleSynth, or another MIDI synthesizer.");
  } else {
    println("eww linux");
  } 
  
}
