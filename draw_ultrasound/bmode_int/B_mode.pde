import processing.serial.Serial;
import java.io.*;

BufferedWriter writer;
Serial myPort;
String val;
ArrayList<PVector> circles = new ArrayList<PVector>();
int numGroups = 19;
ArrayList<String[]> allData = new ArrayList<String[]>();

float max_value(ArrayList<PVector> a){
  float min = Float.MIN_VALUE; // Set initial min value to the maximum possible float
  int MAX = -1;
  for (int num = 0 ; num < a.size(); num++) {
    if (a.get(num).y > min) {
      min = a.get(num).y;
      MAX = num;
    }
  }
  if (MAX != -1){
    return a.get(MAX).x;
}else{
  return 0;
}
}

int avg(String[] a, int size){
  int average = 0;
  for(int i = 0; i< size; i++){
      average += int(a[i+size]);
    }
    average = round(average/size);
    return average;
}

void setup()
{
  fullScreen();
  background(0);
  
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);

}

void draw()
{
  if (myPort.available() > 0)
  {
    val = myPort.readStringUntil('\n');
  }
  if (val != null)
  {
    //background(0);
    //print(val);
    collectData(val);
    if (allData.size() == numGroups){
      processData();
      allData.clear();
    }
  }
}
void collectData(String data){
  String[] list = split(data,",");
  allData.add(list);
  
}
void processData(){
  background(0);
  
  for (String[] data : allData){
    int mode = Integer.parseInt(data[data.length - 1].trim());
    int size = (data.length - 1) / 2;
    //int low = avg(data,size)+3;
    //println(low);
    processDataPoint(data, size, mode);
  }
  drawCircles();
}
float getangle(int mode){
  float ang = 0;
  switch (mode)
  {
    case 0: ang -= 38; break;
    case 1: ang -= 31; break;
    case 2: ang -= 24; break;
    case 3: ang -= 18; break;
    case 4: ang -= 16; break;
    case 5: ang -= 12; break;
    case 6: ang -= 8; break;
    case 7: ang -= 6; break;
    case 8: ang -= 4; break;
    case 9: ang -= 0; break;
    case 10: ang += 4; break;
    case 11: ang += 6; break;
    case 12: ang += 8; break;
    case 13: ang += 12; break;
    case 14: ang += 16; break;
    case 15: ang += 18; break;
    case 16: ang += 24; break;
    case 17: ang += 31; break;
    case 18: ang += 38; break;
    default: break;
  }
  return radians(ang);

}
void processDataPoint(String[] data, int size, int mode){
    for(int i = 0; i < size; i+=2)
    {
      float distance = float(data[i])*3000/32000; //parameter need adjust
      float val = float(data[i+1]);
      float brightness = val > 500 ? ((val-500)/(600-500))*255 : val/20;

      
      if ((distance <= 5000 && distance > 50)){
        float ang = getangle(mode);
        float x = (distance)*sin(ang);
        float y = (distance)*cos(ang);
          
        circles.add(new PVector(width/2 + x, 900-y, brightness));
        }
      }  
}
void drawCircles(){
    if (circles.size() > 5000)
    {
      circles = new ArrayList<PVector>(circles.subList(circles.size()-5001, circles.size()-1));
    }
    
    for (PVector p : circles)
    {
      fill(255,255,255,p.z);
      circle(p.x, p.y, 20);
    }
  }
      
            
