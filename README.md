# RIBIT

**RIBIT:** RISE International Baccalaureate Information Technology

## Members

**Luca DalCanto (Music Theorist and Procedural Systems):** In charge of figuring out how to weigh the random elements of creating the music track (the "brains" of the program). Takes parameters from Zack (representing user input) and gives parameters to Micah (representing music).

**Micah Tien (MIDI, Audio Engineer):** In charge of turning the information into MIDI and rendering it as audio to play back to the user. Takes parameters from Luca.

**Zachary Wellborn (User Interfacing and Graphics Implementation):** In charge of implementing graphics for user interaction. Collects information from the user and sends it to Luca.

**Jenna Tran (Graphics Creation, Data Transfer, and Procedural Systems):** In charge of ensuring proper logistics of information during both "choke points" and ensuring proper cooperation among systems. Artist for visuals. Helps where needed, in particular the infrastructure for procedural music generation. 

**Maggie Cole (Graphics Creation, Testing, and GitHub Management):** In charge of producing graphics and testing the output of the procedural music generator. Works with Luca and Jenna to make improvements in the software's musical awareness.

## Procedural Music Generator
- User input and randomness come together
- Fundemental music theory awareness
- Outputs as MIDI information and audio

Class Diagram - Luca DalCanto

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/49aa40e8ed149a643bcb9aaca875b2188ba064f9/images/InheritanceMusic.png" width="500" />

Link to CodeHS file: https://codehs.com/sandbox/id/new-sandbox-program-zfq1Qm?filepath=Chord.java&collaborate=-O7ozjqHktADjsoU7bUd

## Password Game
Our program uses a loop to ask for password input indefinitely until the player enters a password that matches all criteria. To assess which criteria need to be displayed for any given password entry, we have a function that contains a sequence of “if” checks: one for each rule. If a rule is met, nothing happens and the code proceeds with the next rule check. If, however, a rule is not met, the function returns the number of that rule so the main loop can display it (and all the previous rules) and ask for new input.

Link to codeHS file: https://codehs.com/sandbox/id/java-main-TBfN8x?collaborate=-O5KM8sxcanbL7vcloM0

### Logic Flow Diagram

<img src="https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/IMG_0042.jpeg?raw=true" width="600" />

### Demonstration

![Demonstration](https://github.com/Luca-Skyline/RIBIT-REPO/blob/main/images/demonstration.png?raw=true)


