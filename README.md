# RIBIT

**RIBIT:** RISE International Baccalaureate Information Technology

## Instructions for Running Group Project (UpBeat)

- Download and unzip repository
- Navigate to RIBIT-REPO/src/musicApp
- Open RoughSketch.pde in Processing
- Run Code

## Members

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

Class Diagram - Luca DalCanto

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/49aa40e8ed149a643bcb9aaca875b2188ba064f9/images/InheritanceMusic.png" width="500" />

### User Interaction (Zach, Maggie, Jenna)

Start Screen - Jenna Tran

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/Theme_1.png?raw=true" width="400" />

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/Theme_5.png?raw=true" width="400" />

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/Theme_2.png?raw=true" width="400" />

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/Theme_6.png?raw=true" width="400" />

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/Theme_3.png?raw=true" width="400" />

GUI Mockup (Step-By-Step Pages/Screens)- Jenna Tran

*very ugly but the idea is there*

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/GUIMockup.png?raw=true" width="600" />

Diffrent Poposed Color Variation

Orginal Paper Sketch 

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
