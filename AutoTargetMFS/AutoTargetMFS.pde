import processing.serial.*;

PFont font_digit;

long ts_init = millis();
boolean timeout = false;

int score = 0;
int target_num = 4; // change this
int[] target_score = {100, 100, 100, 100}; // change this

Serial myPort;
String buf;

void setup() {
  size(1920, 1080);
  font_digit = createFont("DS-DIGIT.ttf", 32);
  textFont(font_digit);

  int portNum = 0; // change this number if port doens't match
  String portName = Serial.list()[portNum];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0x2a2a2a);
  fill(0xfffedb21);

  /* draw time */
  textSize(230);
  text("TIME: ", 100, 230);
  long ts = millis();
  int sec = 45 - int(ts - ts_init) / 1000;
  int mil = 99 - (int(ts - ts_init) % 1000) / 10;
  if (sec < 10) {
    fill(0xffff0000);
  }
  if (sec <= 0) {
    sec = 0;
    mil = 0;
    timeout = true;
  }

  text(sec + "\"" + mil, 600, 230);

  /* update score */
  if ( myPort.available() > 0) {
    buf = myPort.readStringUntil('\n');
    println(buf);
    if (!timeout && buf.length() > 0) {
      int index = buf.charAt(0) - '0';
      score += target_score[index];
    }
  } 

  /* draw score */
  fill(0xfffedb21);
  textSize(230);

  text("SCORE: ", 100, 450);
  textSize(650);
  text("" + score, 300, 950);

  delay(20);
}

