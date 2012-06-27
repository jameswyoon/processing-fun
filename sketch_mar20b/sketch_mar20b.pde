/*
 * processing_primer_2
 *
 * Basic interaction application.
 *
 * Created for GRPH 2A06, by James W. Yoon
 * Last revised: March 20, 2012
 *
 */

// My variables (for colours)
color c_blue = color(0, 174, 239); // Blue
color c_green = color(43, 182, 115); // Green
color c_orange = color(242, 101, 34); // Orange
color c_yellow = color(255, 222, 23); // Yellow
color c_black = color(55, 55, 55); // Black
color c_white = color(255, 255, 255); // White

void setup() {
  size(800, 600); // This creates a canvas of width 800px and height 600px
  background(c_black); // Make my background black
}

void draw() {
  // Do the following only if my mouse is pressed down
  if (mousePressed) {
    // Do the following five times
    for (int i = 0; i < 5; i++) {
      rectMode(CENTER); // Changing coordinate system to CENTER
      
      int pickAColor = (int)random(4); // Give me a random number from 0 to 4 so I can pick a random colour

      if (pickAColor == 0) { fill(c_blue); } // If the random number was 0, use blue
      else if (pickAColor == 1) { fill(c_green); } // Otherwise, if the random number was 1, use green
      else if (pickAColor == 2) { fill(c_orange); } // Otherwise, if the random number was 2, use orange
      else if (pickAColor == 3) { fill(c_yellow); } // Otherwise, if the random number was 3, use yellow

      stroke(c_white, 80); // Use a stroke colour of white, with an opacity of 80 (out of 255)

      rect(mouseX + random(20), mouseY + random(20), random(5), random(5)); // Draw a rectangle of random size, centered randomly around my mouse
    }
  }
}
