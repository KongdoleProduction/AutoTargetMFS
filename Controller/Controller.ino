#define SENSOR_READ_PERIOD 1
#define SENSOR_UPDATE_PERIOD 200 // increase this if too noisy
#define SENSOR_NUM 4

uint8_t sensor_pins[SENSOR_NUM] = {2, 3, 4, 5}; // change this

void setup() {
  for (int i=0; i<SENSOR_NUM; i++) {
    pinMode(sensor_pins[i], INPUT_PULLUP);
  }
  Serial.begin(9600);
}

void loop() {
  static unsigned long sensor_prev, send_prev;

  static unsigned long sensor_last_hit[SENSOR_NUM];

  if (millis() - sensor_prev > SENSOR_READ_PERIOD) {
    sensor_prev = millis();
    for (int i=0; i<SENSOR_NUM; i++) {
      boolean buf = digitalRead(sensor_pins[i]);
      if (buf &&
          (millis() - sensor_last_hit[i] > SENSOR_UPDATE_PERIOD)) {
        sensor_last_hit[i] = millis();
        Serial.println(i, DEC);
      }
    }
  }
}
