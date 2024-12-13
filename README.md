# RIBIT

**RIBIT:** RISE International Baccalaureate Information Technology

## Members

**Luca DalCanto (Team Lead, Music Theorist, and Procedural Systems):** In charge of figuring out how to weigh the random elements of creating the music track (the "brains" of the program). Takes parameters from Zack (representing user input) and gives parameters to Micah (representing musical information).

**Micah Tien (MIDI, Audio Engineer):** In charge of turning the information into MIDI and rendering it as audio to play back to the user. Takes parameters from Luca.

**Zachary Wellborn (User Interfacing and Graphics Implementation):** In charge of implementing graphics for user interaction. Collects information from the user and sends it to Luca.

**Jenna Tran (Graphics Creation, Data Transfer, and Procedural Systems):** In charge of ensuring proper logistics of information during both "choke points" and ensuring proper cooperation among systems. Artist for visuals. Helps where needed, in particular the infrastructure for procedural music generation. 

**Maggie Cole (Graphics Creation, Testing, and GitHub Management):** Helps with producing graphics/design and testing the output of the procedural music generator. Works with Luca and Jenna to make improvements in the software's musical awareness.

## Procedural Music Generator (UpBeat)

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/UpBeatLogoLarge.png?raw=true" width="400" />

- User input and randomness come together
- Fundemental music theory awareness
- Outputs as MIDI information and audio

Class Diagram - Luca DalCanto

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/49aa40e8ed149a643bcb9aaca875b2188ba064f9/images/InheritanceMusic.png" width="500" />

### User Interaction (Zach, Maggie, Jenna)

### Procedural Generation (Luca, Jenna)

### Sound Rendering (Micah, Jenna)

Welcome to my devlog
#### Devlog
One problem I encountered was a NullPointerException. This comes from the MIDIBus libary, the one I'm using to render sound, being made for a previous version of processing.
To solve this error, the .jar file inside of the library needs to be replaced with a more current one found [here](https://github.com/micycle1/themidibus/releases/tag/p4).

#### To do list
- ~~Instantiate a MIDIBus object~~
  - ~~Fix NullPointerException~~
- Create a sequencer
- Create a sequence
