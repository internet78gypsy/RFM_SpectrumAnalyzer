import processing.serial.*;

Serial port;
byte[] buffer = new byte[101];


void setup(){
  size(1200, 600);
  surface.setTitle("Spectrum Analyzer");
  surface.setResizable(true);
  surface.setLocation(100, 100);
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[0], 115200);
  port.clear();
  port.bufferUntil('\n');
}

void draw() {
  background(0);
  int scaleX = width/buffer.length+1;
  int scaleY = height/100;
  drawGrid(scaleX,scaleY);
  stroke(255,255,0);
  strokeWeight(1);
  while(port.available()>0) {
    for(int index = 0; index < buffer.length - 1; index++){
      line(index*scaleX, abs(buffer[index]*scaleY)-250, (index+1)*scaleX, abs(buffer[index+1]*scaleY)-250);
    }
  }
}

void serialEvent(Serial port){
  port.readBytes(buffer);
  port.clear();
}

void drawGrid(int scaleX, int scaleY){
  strokeWeight(0.3);
  stroke(255,255,255);
  for(int index = 0; index < width; index+=scaleX){
   line(index,0,index,height);
  }
  for(int index = 0; index < height; index+=scaleY){
   line(0,index,width,index);
  }
}
