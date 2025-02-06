import javax.sound.midi.*;
import javax.sound.sampled.*;
import java.io.*;

void setup() {
  String midiFile = sketchPath("input.mid"); // Path to the MIDI file
  String wavFile = sketchPath("output.wav"); // Output WAV file

  try {
    convertMidiToWav(midiFile, wavFile);
    println("MIDI to WAV conversion complete.");
  } catch (Exception e) {
    e.printStackTrace();
  }
}

void convertMidiToWav(String midiFilePath, String wavFilePath) throws Exception {
  // Load MIDI file
  Sequence sequence = MidiSystem.getSequence(new File(midiFilePath));

  // Get and open the Synthesizer
  Synthesizer synth = MidiSystem.getSynthesizer();
  synth.open(); // Mac needs this explicitly

  // Load default soundbank (if available)
  Soundbank soundbank = synth.getDefaultSoundbank();
  if (soundbank != null) {
    synth.loadAllInstruments(soundbank);
  } else {
    println("Warning: No soundbank found! Mac may need a valid SoundFont.");
  }

  // Get and open the Sequencer
  Sequencer sequencer = MidiSystem.getSequencer(false); // Use software sequencer
  sequencer.open(); // **FIX: Ensure sequencer is opened**
  sequencer.setSequence(sequence);
  sequencer.getTransmitter().setReceiver(synth.getReceiver());

  // Define the audio format
  AudioFormat format = new AudioFormat(44100, 16, 2, true, false);

  // Create a TargetDataLine to capture sound
  DataLine.Info info = new DataLine.Info(TargetDataLine.class, format);
  TargetDataLine line = (TargetDataLine) AudioSystem.getLine(info);
  line.open(format);
  line.start();

  // Create an AudioInputStream from the line
  AudioInputStream audioStream = new AudioInputStream(line);

  // Start MIDI playback
  sequencer.start();

  // Wait for playback to finish
  while (sequencer.isRunning()) {
    Thread.sleep(100);
  }

  // Write to WAV file
  File wavFile = new File(wavFilePath);
  AudioSystem.write(audioStream, AudioFileFormat.Type.WAVE, wavFile);

  // Close resources
  sequencer.stop();
  sequencer.close();
  synth.close();
  line.stop();
  line.close();
}
