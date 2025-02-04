//import statements for MIDI, scanners, etc. here

String globalPhase;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean pop; // pop
boolean classical; // classical
Button[] buttons = new Button[4];
PImage logo;
PFont pixel;


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
  buttons[0] = new Button(350, 100, 100, 60, "test", "q1");
  buttons[1] = new Button(350, 200, 100, 60, "test #2", "q1");
  buttons[2] = new Button(750, 200, 220, 50, "Pop Song", "mainMenu");
  buttons[3] = new Button(750, 400, 220, 50, "Classical Song", "mainMenu");
  pop = false;  
  classical = false;
  stroke(#1D201F);
  //mySongs = new Song[2];
  //mySongs[0] = new ClassicalSong();
  //mySongs[1] = new PopSong();
  
  lucaTest();
}


void draw() {
  background(10);
  strokeWeight(0);
  fill(255,0,0); 
  rect(700,10,480,680,20);
  if (globalPhase == "mainMenu") {
  fill(255); 
  textSize(80);
  text("Welcome to", 300, 150); 
  textSize(30);
  image(logo, 300,400);
  quad(500,height,520,height,720,0,700,0);
  }
  
  //rendering buttons -z
    for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       buttons[i].display();
       buttons[i].hover(mouseX, mouseY);
     }
   }
  
  //1st question -z
  //make this a case switch statement
  if (globalPhase == "q1") {
   fill(0);
   textSize(30);
   text("Choose your settings for the song you want to make", 25, 50); 
   textSize(12);
   text("How long would you like your song to be?", 25, 100);
   text("10 measures", 25, 120);
   text("20 measures", 100, 120);
   text("30 measures", 175, 120);
   text("40 measures", 250, 120);
   text("what tempo would you like your song to be?", 25, 160);
   text("80 bpm", 25, 180);
   text("100 bpm", 100, 180);
   text("120 bpm", 175, 180);
   text("140 bpm", 250, 180);
 
   //will NOT include other options as we develop 
   //we'll then take all the requirements and generate a song along these guidelines
   //then output that to the user
   
   
  }
}

//this is Luca's way to test his stuff in the console for rn so he can have an entry point.
void lucaTest(){
  Jingle j = new Jingle("A#", 4);
  j.printScale();
}
//instead make 
void mousePressed() {
 if (mouseX>400 && mouseX <600 && mouseY>200 && mouseY<250 && globalPhase == "mainMenu") {
    globalPhase = "q1";
    classical = true; // classical
  }
  if (mouseX>100 && mouseX <300 && mouseY>200 && mouseY<250 && globalPhase == "mainMenu") {
    pop = true; // pop
    globalPhase = "q1";
   } 
  
}
