ArrayList<Flue> flueListe = new ArrayList<Flue>();
PImage frog;
PImage scope;

void setup() {
  size(1000, 1000);

  frog = loadImage("ja.jpg");
  scope = loadImage("web.jpg");
}

void draw() {
  clear();
  background(50, 170, 150);
  image(frog, 0, 0, 200, 200);
  image(scope, width/2, height/2, 300, 300);

  for (int i=0; i<flueListe.size(); i++) {
    Flue f = flueListe.get(i);
    f.tegnFlue();
    if (f.OOB(0, 0, width, height)) {
      flueListe.remove(flueListe.get(i));
    } else if (f.IOB(width/2, height/2, width/2+300, height/2+300)) {
      flueListe.remove(flueListe.get(i));
    } else {
      f.flyt();
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    flueListe.add(new Flue());
  }
  if (key == 'e') {
    flueListe.add(new Flue(10));
  }
}

void mousePressed() {
  flueListe.add(new Flue(mouseX, mouseY, 1));
}

/////////////////////////////////////////////////////////
class Flue {

  float positionX, positionY;
  float scale;
  float distanceFlyttet;
  float vinkel = 0; 
  float Flyt = 0.5;

  Flue() {
    positionX  = random(0, height);
    positionY  = random(0, width);
    scale      = random(0, 10);
    vinkel     = random(0, 2*PI);
  }

  Flue(float a, float b, float c) {
    positionX = a;
    positionY = b;
    scale = c;
    vinkel    = random(0, 2*PI);
  }

  Flue(float c) {
    positionX  = random(0, height);
    positionY  = random(0, width);
    scale = c;
    vinkel    = random(0, 2*PI);
  }

  void flyt() {
    distanceFlyttet = distanceFlyttet + Flyt;
  }

  float getXPos(float dist) {
    float x;
    x = cos(vinkel) * dist + positionX;
    return x;
  }

  float getYPos(float dist) {
    float y;
    y = sin(vinkel) * dist + positionY;
    return y;
  }

  boolean OOB(int x1, int y1, int x2, int y2) {
    if ((getXPos(distanceFlyttet + Flyt) >= x2)
      || (getXPos(distanceFlyttet + Flyt) <= x1)
      || (getYPos(distanceFlyttet + Flyt) >= y2)
      || (getYPos(distanceFlyttet + Flyt) <= y1)) {
      return true;
    } else {
      return false;
    }
  }

  boolean IOB(int x1, int y1, int x2, int y2) {
    if ((getXPos(distanceFlyttet) <= x2)
      && (getXPos(distanceFlyttet) >= x1)
      && (getYPos(distanceFlyttet) <= y2)
      && (getYPos(distanceFlyttet) >= y1)) {
      return true;
    } else {
      return false;
    }
  }



  void tegnFlue() {
    pushMatrix();
    translate(positionX, positionY);
    rotate(vinkel);
    translate(distanceFlyttet, 0);
    scale(scale);
    ellipse(0, 0, 20, 8);
    ellipse(0, 0-8, 15, 10);
    ellipse(0, 0+8, 15, 10);
    ellipse(0+6, 0, 8, 8);
    popMatrix();
  }
}
//////////////////////////////////////////////////////
