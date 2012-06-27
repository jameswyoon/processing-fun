class ColorSpectrum {
  int posX, posY; // position of colour spectrum, top-left corner
  int spectrumSize; // size of the colour spectrum, in pixels

  int spectrumResolution; // granularity of colour spectrum; 1-100; 1 for low, 100 for high

  color colorRelativeTo; //
  float contrastConstraint; // 
  
  boolean hasSomethingChanged;
  
  PGraphics graphicsBuffer;

  // Constructors

  ColorSpectrum(int pX, int pY, int sSize, PGraphics pg) {
    this.posX = pX;
    this.posY = pY;
    this.spectrumSize = sSize;
    
    this.spectrumResolution = 100;

    this.colorRelativeTo = color(0, 0, 0);
    this.contrastConstraint = 0;
    
    this.graphicsBuffer = pg;
    
    this.hasSomethingChanged = false;
  }

  ColorSpectrum(int pX, int pY, int sSize, int res, PGraphics pg) {
    this.posX = pX;
    this.posY = pY;
    this.spectrumSize = sSize;
    
    this.spectrumResolution = res;

    this.colorRelativeTo = color(0, 0, 0);
    this.contrastConstraint = 0;

    this.graphicsBuffer = pg;

    this.hasSomethingChanged = false;
  }

  ColorSpectrum(int pX, int pY, int sSize, int res, color c, float contrast, PGraphics pg) {
    this.posX = pX;
    this.posY = pY;
    this.spectrumSize = sSize;

    this.spectrumResolution = res;

    this.colorRelativeTo = c;
    this.contrastConstraint = contrast;

    this.graphicsBuffer = pg;

    this.hasSomethingChanged = false;
  }

  // Getters-and-setters

  void setColorRelativeTo(color c) {
    this.colorRelativeTo = c;
    this.hasSomethingChanged = true;
  }

  void setContrastConstraint(float contrast) {
    this.contrastConstraint = contrast;
    this.hasSomethingChanged = true;
  }

  PGraphics getPGraphics() { return graphicsBuffer; }

  // Behavior

  void draw() {
    int luminanceValue = 100;
    int numberOfElements = spectrumResolution;
    int elementSize = spectrumSize / numberOfElements;
    
    /*
    System.out.println("numberOfElements: " + numberOfElements);
    System.out.println("spectrumResolution: " + spectrumResolution);
    System.out.println("spectrumSize: " + spectrumSize);
    System.out.println("elementSize: " + elementSize);
    */
        
    graphicsBuffer.beginDraw();
    
    rectMode(CORNER);
    
    graphicsBuffer.background(0);
    
    for (int i = 0; i < numberOfElements; i++) {
      for (int j = 0; j < numberOfElements; j++) {
        int valueDifference = 100 / numberOfElements;
        color c = color(i * valueDifference, luminanceValue, j * valueDifference);
        
        if (calcContrast(c, colorRelativeTo) > contrastConstraint) {
          graphicsBuffer.fill(c);
        }
        else {
          graphicsBuffer.fill(0);
        }
                
        graphicsBuffer.rect(0 + (i * elementSize), 0 + (j * elementSize), elementSize, elementSize);
        //graphicsBuffer.ellipse(posX + (i * elementSize), posY + (j * elementSize), elementSize, elementSize);
      }
    }
    
    graphicsBuffer.endDraw();
  }

  void move(int pX, int pY) {
    this.posX = pX;
    this.posY = pY;
    
    this.hasSomethingChanged = true;
  }
}
