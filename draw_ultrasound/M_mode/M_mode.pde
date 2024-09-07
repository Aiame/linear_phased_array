import processing.serial.*;

Serial myPort;
String val;
ArrayList<PVector> aa = new ArrayList<PVector>();

PVector obj_distance(ArrayList<PVector> a){
  float min = Float.MIN_VALUE; // Set initial min value to the maximum possible float
  int MAX = -1;
  for (int num = 0 ; num < a.size(); num++) {
    if (a.get(num).y > min) {
      min = a.get(num).y;
      MAX = num;
    }
  }
  if (MAX != -1){
    return a.get(MAX);
}else{
  return new PVector(0,0);
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

void setup(){
  fullScreen();
  background(0);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
}


int x = 50;
float dis = 0;

void draw(){
  if(x>=width){
    background(0);
    x = 50;
  }
  if(myPort.available() > 0){
    val = myPort.readStringUntil('\n');
  }
  if(val != null){
    String[] list = split(val, ",");
    int mode = Integer.parseInt(list[list.length-1].trim());
    int size = (list.length-2)/2;
    int average = avg(list,size)+10;
    
    ArrayList<PVector> delta_t = new ArrayList<PVector>();
    for(int i = 0; i < size; i++){
      
      float distance = float(list[i])*1500/32000;
      float val = float(list[i+size]);
      float brightness = 0;
      
      if(val > average){
        brightness = 255;
      }else{
        brightness = 0;
      }
      
      if(distance > 50){
        delta_t.add(new PVector(distance,val,0));
        aa.add(new PVector(x,900-distance,brightness));
      }
    }
    PVector dis = obj_distance(delta_t);
    dis.mult(0.725/2);
    println(dis);
    x += 3;
    
    if (aa.size() >500){
      aa = new ArrayList<PVector>(aa.subList(aa.size()-501,aa.size()-1));
    }
    long count = 0;
    for(PVector p: aa){
      
      count++;
      //if(count>500){
      //  count = 0;
      //}
      if(count/100 == 0){
        textSize(20);
        text(dis.x,p.x,100);
      }
      fill(255,255,255,p.z);
      circle(p.x,p.y,10);
      
    }
}
}
