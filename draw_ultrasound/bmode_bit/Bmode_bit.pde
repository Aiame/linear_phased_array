import processing.serial.Serial;
import java.io.*;

Serial myPort;
int arraySize = 50;
int[] timeArray = new int[arraySize];
int[] valArray = new int[arraySize];
int phaseValue;
boolean readingData = false;
int byteCounter = 0;
byte[] inBuffer = new byte[arraySize * 4 + 1];
final byte START_MARKER = (byte)0x7E;
final byte END_MARKER = (byte)0x7F;
ArrayList<PVector> circles = new ArrayList<PVector>();
ArrayList<PVector> currentBatch = new ArrayList<PVector>();
int currentIndex = 0;
BufferedWriter writer;
int counter = 0;
int clearInterval = 5000; // Time interval in milliseconds (e.g., 5000ms = 5 seconds)
int lastClearTime = 0;



void process_line(int receivedByte){
  //print("hi");
  if (receivedByte == START_MARKER) {
      readingData = true;
      byteCounter = 0;
    } else if (receivedByte == END_MARKER) {
      readingData = false;
      if (byteCounter == arraySize * 4 + 1) {
        // Convert the byte array to int arrays and uint8_t
        for (int i = 0; i < arraySize; i++) {
          int lowByte = inBuffer[i * 2] & 0xFF;
          int highByte = inBuffer[i * 2 + 1] & 0xFF;
          timeArray[i] = (highByte << 8) | lowByte;
          int val_lowByte = inBuffer[arraySize * 2 + i * 2] & 0xFF;
          int val_highByte = inBuffer[arraySize * 2 + i * 2 + 1] & 0xFF;
          valArray[i] = (val_highByte << 8) | val_lowByte;
        }
        phaseValue = inBuffer[arraySize * 4] & 0xFF;

        println("timeArray: " + join(nf(timeArray, 0), ','));
        println("valArray: " + join(nf(valArray, 0), ','));
        println("phaseValue: " + phaseValue);
        
        //try{
        //  writer.write(join(nf(timeArray, 0), ',') + "," + join(nf(valArray, 0), ',') + "," + phaseValue);
        //  writer.newLine();
        //  writer.flush();
        //}catch (IOException e) {
        //    e.printStackTrace();
        //  }
        
        
      }
    } else if (readingData) {
      if (byteCounter < inBuffer.length) {
        inBuffer[byteCounter++] = (byte)receivedByte;
      }
    }
    
    
    
    
}

void process_data(int[] time_arr, int[] val_arr){
  float ang = getangle(phaseValue);
  ang = radians(ang);
  //PVector offset = new PVector(width / 2, 900);
  for (int i = 0; i<arraySize; i++)
  {
    float distance = float(time_arr[i])*3000/21000;
    float val = float(val_arr[i]);
    float brightness = val>100 ? 255: 0;
    
    if(distance <=5000 && distance > 0){
      
      float x = round(distance * sin(ang) * 100) / 100.0;
      float y = round(distance * cos(ang) * 100) / 100.0;
      
      circles.add(new PVector(width / 2 + x, 900-y, brightness)); 
  }
 }
 if (circles.size()>200){circles = new ArrayList<PVector>(circles.subList(circles.size()-201, circles.size()-1));}
 
}

float getangle(int mode){
  float ang =0;
  switch(mode){
        case 0:ang -= 38;break;
        case 1:ang -= 31;break;
        case 2:ang -= 24;break;
        case 3:ang -= 18;break;
        case 4:ang -= 16;break;
        case 5:ang -= 12;break;
        case 6:ang -= 8;break;
        case 7:ang -= 6;break;
        case 8:ang -= 4;break;
        case 9:ang -= 0;break;
        case 10:ang += 4;break;
        case 11:ang += 6;break;
        case 12:ang += 8;break;
        case 13:ang += 12;break;
        case 14:ang += 16;break;
        case 15:ang += 18;break;
        case 16:ang += 24;break;
        case 17:ang += 31;break;
        case 18:ang += 38;break;
        default:break;
      }
      return ang;
    }
    
void divide_data(){
  int nextIndex = Math.min(currentIndex + 3420, circles.size());
  currentBatch = new ArrayList<>(circles.subList(currentIndex, nextIndex));
  currentIndex = nextIndex;
}

void setup() {
  fullScreen();
  background(0);

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);

  //try {
  //  writer = new BufferedWriter(new FileWriter("C:\\Users\\User\\Desktop\\meeting\\d7_25\\d7_25_1.txt", true));
  //} catch (IOException e) {
  //  e.printStackTrace();
  //}
}

void draw() {
  if(counter%500 == 0){
  background(0);
  }
  //if (millis() - lastClearTime > clearInterval) {
  //  circles.clear(); // Clear the circles
  //  lastClearTime = millis(); // Update the last clear time
  //}
  while (myPort.available() > 0) {
    //print("hi");
    int receivedByte = myPort.read();
    process_line(receivedByte);
  }
  //println("we are here");
  process_data(timeArray,valArray);
  //divide_data();
  //if (circles.size() > 200) {
  //  circles.remove(0); // Remove the oldest point if the list exceeds 100 points
  //}
  for (PVector p : circles){
    fill(255,255,255,p.z);
    circle(p.x,p.y,15);
    //print(p.x + "," + p.y);
  }
  counter++;
  //background(0);
  
  
}
