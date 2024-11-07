//import statements for MIDI, scanners, etc. here

boolean mainMenu;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean option1;
boolean option2;
Button[] buttons = new Button[4];

//     TO DO : slider for chaos level and tempo, buttons for key and 
//             time signature and type of song (classical/pop for now) ;p
//          
void setup() {
  size(700,500);
  textSize(25); 
  buttons[0] = new Button(350, 100, 100, 60, "test", 2);
  buttons[1] = new Button(350, 200, 100, 60, "test #2", 2);
  buttons[2] = new Button(100, 200, 200, 50, "Pop Song", 1);
  buttons[3] = new Button(350, 200, 200, 50, "Classical Song", 1);
  mainMenu = true;
  option1 = false; 
  option2 = false;
}


void draw() {
  background(#1D201F);
  fill(#EAD2AC); 
  rect(10,10,680,480,20);
  if (mainMenu == true) {
  fill(0); 
  text("Welcome to Beatboxx, our procedural music generator!", 80, 150); 
  //text("
  //fill(140,200,220);
  
  //// option 1
  // if (mouseX>100 && mouseX <300 && mouseY>200 && mouseY<250) {
  //   fill(120, 180, 200);
  // } 
  //   rect(100, 200, 200, 50, 20); 
  //   fill(140,200,220);
     
  //   //option 2
  // if (mouseX>400 && mouseX <600 && mouseY>200 && mouseY<250) {
  //  fill(120, 180, 200);
  //}

  //rect(400, 200, 200, 50, 20); 
  //fill(0);
  //text("song type 1",110,225);
  //text("song type 2", 410, 225);
  }
  if (mainMenu == false) {
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
   for (int i=0; i<buttons.length; i++) {
     buttons[i].display();
     buttons[i].hover(mouseX, mouseY);
     
   }
   //will NOT include other options as we develop 
   //we'll then take all the requirements and generate a song along these guidelines
   //then output that to the user
   
   
  }
}
void mousePressed() {
 if (mouseX>400 && mouseX <600 && mouseY>200 && mouseY<250) {
    mainMenu = false;
    option2 = true;
  }
  if (mouseX>100 && mouseX <300 && mouseY>200 && mouseY<250) {
    option1 = true;
    mainMenu = false;
   } 
  
}
