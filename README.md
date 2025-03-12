# Up Beat



## Instructions for UpBeat -- READ THIS, IT'S COMPLICATED AND IT MATTERS

- If on Mac, open GarageBand or another MIDI synthesizer in the background. See below for more details.
- Ensure you have an internet connection
- Download and unzip thiis repository
- Navigate to RIBIT-REPO/src/musicApp
- Open RoughSketch.pde in Processing
- At top right corner of Processing IDE, select "Java"
- Click "Mange Modes..."
- Go to the "Libraries"
- Search for "The MidiBus". When it appears, click it and hit "Install".
- Search for "ControlP5". When it appears, click it and hit "Install".
- Close install menu and run code

## Members - The RIBIT Team
**RIBIT:** Teams RISE International Baccalaureate Information Technology

### Backend

**Luca DalCanto (Team Lead, Music Theorist, and Procedural Systems):** In charge of figuring out how to weigh the random elements of creating the music track. Takes parameters from Zack and gives data to Micah representing musical information. Luca is in charge of communicating with other team members to ensure proper data handling between these two choke points.

**Micah Tien (MIDI, Audio Engineer):** In charge of turning the information into MIDI and sequencing it into audio to play back to the user. Takes parameters from Luca. 

### Frontend

**Jenna Tran (Front-End Team Lead, Graphics Designer, Data Transfer):** Artist for visuals and visionary front-end designer. Understands the big picture and how front-end and back-end tie together.

**Zachary Wellborn (User Interfacing and Graphics Implementation):** In charge of implementing graphics for user interaction. Collects information from the user and sends it to Luca.

**Maggie Cole (Graphics Creation, Testing, and GitHub Management):** Helps with producing graphics/design and testing the output of the procedural music generator. Works with Luca and Jenna to make improvements in the software's musical awareness. 

## Procedural Music Generator (UpBeat)

Reference/Inspo: https://muted.io/app/

Logo - Jenna Tran

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/BlueUpBeat.png?raw=true" width="400" />

- User input and randomness come together
- Fundemental music theory awareness
- Outputs as MIDI information and audio

Class Diagram - Maggie Cole

<img src="https://github.com/Luca-Skyline/Up-Beat/blob/main/images/littleGuy.png?raw=true" width="800" />


### User Interaction (Zach, Maggie, Jenna)

GUI Mockup (Step-By-Step Pages/Screens)- Jenna Tran

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/GUI_Done.png?raw=true" width="600" />

#### To-Do List of maybes
- make look different based on mood of song

### Procedural Generation (Luca, Jenna)

- metronome?
- percussion?

### Sound Rendering (Micah, Jenna)

Welcome to my devlog
#### Use of AudioExample.pde
Clicking anywhere on the window will play a simple C3 Chord (C3, E3, G3, C4). It will play as long as the mouse is held.

#### MacOS specifics
MidiBus has definitely passed its glory days (if it ever had any) and it is pretty finnicky for any use outside of Windows OS. But, it is possible!
The program will not run on MacOS unless the IAC Driver Bus is set up properly. The easiest way to do this is as follows:

1. Open the application **Audio MIDI Setup**
2. At the topbar, navigate to **Window** >> **Show MIDI Studio**
3. Double click on **IAC Driver**
4. Click the checkbox **Device is online** so that it's ticked
5. In the Ports section, if there are no ports listed, click the **+** button to the bottom left. It should say *IAC Driver Bus 1* under *Ports*.

Now the program will run, but it won't synthesize sound. MacOS doesn't have any built-in sound synthesizers, but substitutes require practically no setup. The best option from my testing is simply an empty GarageBand project, but other programs (e.g. SimpleSynth) are totally viable. To use GarageBand:

1. Open the application **GarageBand**
2. Double click on **Empty Project**
3. Select the **MIDI** track
4. Optionally, you could press *Command + K* to see a keyboard of the MIDI notes being sequenced.
