import java.lang.Math;

/*
public static final color c_pale = color(255, 254, 241);
public static final color c_slate = color(121, 154, 165);
public static final color c_grey = color(54, 63, 69);
public static final color c_peach = color(252, 179, 28);
*/

ColorSpectrum spectrumL, spectrumR; // left and right color spectrums
PGraphics pgLeft, pgRight; // left and right off-screen buffers, for each color spectrum
color backgroundColor;
color selectedColor = color(0, 0, 0);
float minContrast = 4.5; // WCAG AA = 4.5, WCAG AAA = 7
int spectrumResolution = 20; // 1 to 100
boolean showTextPreview = true;

PFont font;

void setup() {
  size(1280, 800);
  background(0);
  frameRate(30);

  colorMode(HSB, 100, 100, 100);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  smooth();
  noStroke();

  font = loadFont("data/HelveticaNeue-12.vlw");
  textFont(font);

  pgLeft = createGraphics(width/2, width/2, P2D);
  pgRight = createGraphics(width/2, width/2, P2D);
  
  spectrumL = new ColorSpectrum(0, 0, width/2, spectrumResolution, pgLeft);
  spectrumR = new ColorSpectrum(width/2, 0, width/2, spectrumResolution, pgRight);
  spectrumR.setContrastConstraint(minContrast);

  spectrumL.draw();
  spectrumR.draw();
}

void draw() {
  background(0);
  
  image(spectrumL.getPGraphics(), 0, 0);
  image(spectrumR.getPGraphics(), width/2, 0);

  stroke(255);
  strokeWeight(10);
  fill(selectedColor);
  rect(5, 5, 40, 40);
  noStroke();
  
  if (mousePressed) {
    selectedColor = get(mouseX, mouseY);
    
    spectrumR.setColorRelativeTo(selectedColor);
    System.out.println(red(selectedColor) + ", " + blue(selectedColor) + ", " + green(selectedColor));
    spectrumR.draw();
  }
  
/*  if (showTextPreview) {
    rectMode(CENTER);
    
    fill(255);
    rect(width/2, height/2, 240, 120);
    fill(
    
  }*/
  
}

// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float calcContrast(color c1, color c2) {
  float contrast; // contrast; value to calculate
  float l1, l2; // relative luminance values of the two colours

  l1 = calcLuminance(c1);
  l2 = calcLuminance(c2);

  if (l1 > l2) {
    contrast = (l1 + 0.05) / (l2 + 0.05);
  }
  else {
    contrast = (l2 + 0.05) / (l1 + 0.05);
  }

  System.out.println("(c1, c2): (" + red(c1) + ", " + blue(c1) + ", " + green(c1) + "), (" + red(c2) + ", " + blue(c2) + ", " + green(c2) + ")");
  System.out.println("(l1, l2, contrast): " + l1 + ", " + l2 + ", " + contrast);
  System.out.println("####");

  return contrast;
}

float calcLuminance(color c) {
  float L; // luminance value to be calculated and returned
  float rSrgb, gSrgb, bSrgb; // RGB sRGB values
  float r, g, b; // RGB values for luminance calcluation

  rSrgb = ((c >> 16) & 0xFF) / 255.0;
  gSrgb = ((c >> 8) & 0xFF) / 255.0;
  bSrgb = (c & 0xFF) / 255.0;

  if (rSrgb <= 0.03928) {
    r = rSrgb/12.92;
  }
  else {
    r = pow(((rSrgb + 0.055) / 1.055), 2.4);
  }

  if (gSrgb <= 0.03928) {
    g = gSrgb/12.92;
  }
  else {
    g = pow(((gSrgb + 0.055) / 1.055), 2.4);
  }

  if (bSrgb <= 0.03928) {
    b = bSrgb/12.92;

  }
  else {
    b = pow(((bSrgb + 0.055) / 1.055), 2.4);
  }

  L = (0.2126 * r) + (0.7152 * g) + (0.0722 * b);
  
  return L;
}
