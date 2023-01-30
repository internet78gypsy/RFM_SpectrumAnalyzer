#include <SPI.h>
#include <RH_RF69.h>

#if defined (__AVR_ATmega328P__)  
  #define RFM69_INT     2
  #define RFM69_CS      10
  #define RFM69_RST     3
  #define LED           13
#endif

#define startFrequency 863
#define endFrequency   873

RH_RF69 rf69(RFM69_CS, RFM69_INT);

void setup() 
{
  Serial.begin(115200);

  pinMode(LED, OUTPUT);     
  pinMode(RFM69_RST, OUTPUT);
  digitalWrite(RFM69_RST, LOW);

  digitalWrite(RFM69_RST, HIGH);
  delay(10);
  digitalWrite(RFM69_RST, LOW);
  delay(10);
  
  if (!rf69.init()) {
    while (1);
  }
  rf69.setModeRx();
}

void loop() {
    for(float freq = startFrequency; freq < endFrequency-0.1; freq+=0.1){
      rf69.setFrequency(freq);
      Serial.write(rf69.rssiRead());
    }
    Serial.write('\n');
}
