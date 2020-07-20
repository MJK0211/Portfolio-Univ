import controlP5.*;
import processing.serial.*;
Serial port;
int imgWidth = 320;
int imgHeight = 240;
int PADim = (imgWidth)*(imgHeight);
float vl = 0;
float vr = 0;
import processing.video.*;
Capture Cam;

ControlP5 cp5;

int check = 0;
int scene = 1;

float[] ColorArray1 = new float[PADim];
float[] ColorArray2 = new float[PADim];
float[] ColorArray3 = new float[PADim];

color[] trackColor; 
float threshold = 25;

float angle = 0;
float Rangle = 0;
float degree = 0;
int[] centroid_team = new int[2];
int[] centroid_id = new int[2];
int[] centroid_Robot = new int[2];

int[] current_position = new int[2];

int num = 0;
int initialX,initialY;
 
void setup(){ 
 loadPixels();
 size(800, 240);
 port = new Serial(this, "COM4", 9600);
 Cam = new Capture(this, imgWidth, imgHeight,30);
 Cam.start();
 trackColor = new color[2];
 trackColor[0] = color(255, 0, 0);
 trackColor[1] = color(255, 0, 0);
 
 cp5 = new ControlP5(this);
 cp5.addRadioButton("radio") 
 .setPosition(500,30)
 .setSize(40,40)
 .setSpacingColumn(100)
 .addItem("Team Color",1)
 .addItem("ID Color",2)
 .addItem("Robot Outline",3)
 .addItem("START",4);
}

void draw(){
  background(0);
  if(Cam.available()){
   Cam.read(); 
   Cam.loadPixels();
  }
  image(Cam,0,0);
  if(check==1||check==3||check==4){
    int[] pixelArray = Cam.pixels;
    ColorArray1 = populateColorArray(pixelArray,1);
    ColorArray1 = clippers(ColorArray1);
    centroid_team = centroid(ColorArray1);
   
    //println(str(centroid_team[0]) + " " + str(centroid_team[1]));
    //drawCrosshairs(centroid_team);
   
  }
  if(check==2||check==3||check==4){
    int[] pixelArray = Cam.pixels;
    ColorArray2 = populateColorArray(pixelArray,2);
    ColorArray2 = clippers(ColorArray2);    
    centroid_id = centroid(ColorArray2);
    
    //println(str(centroid_id[0]) + " " + str(centroid_id[1]));
    //drawCrosshairs(centroid_id);     
   port.write('b');
   port.write(0);
  }
  if(check==3||check==4){
    int[] pixelArray = Cam.pixels;
    ColorArray3 = populateColorArray(pixelArray,3);
    ColorArray3 = clippers(ColorArray3);
    
    centroid_team = centroid(ColorArray1);
    centroid_id = centroid(ColorArray2);
    
    centroid_Robot[0] = (centroid_team[0] + centroid_id[0])/2;
    centroid_Robot[1] = (centroid_team[1] + centroid_id[1])/2; 
        
    drawCrosshairs(centroid_Robot);    
        
    angle = atan2(centroid_id[1]-centroid_team[1], centroid_id[0]-centroid_team[0]);
    if ((degrees(angle) * -1)-45 > 0 && (degrees(angle) * -1)-45 < 180){
    ////if(degrees(angle)>0 && degrees(angle)<180){
    degree = (degrees(angle)* -1)-45;
    }else degree = 315-degrees(angle) ;
      //Angle(360);
    println(degree);
  }    
  if(check == 4){
    //velocity(150,90);
    println(degree);
     Position();
  }
}

void Position(){
  if(num==0){
    initialX = centroid_Robot[0];
    initialY = centroid_Robot[1];
  }
  num++;
  current_position[0] = centroid_Robot[0];
  current_position[1] = centroid_Robot[1];
  println("current_position : "+current_position[0]);
  if(scene==1){
      if(degree>358&&degree<2){
       // Angle(0);
      }
      if(initialX <= imgWidth-current_position[0]){
        velocity(180,120);
      }else{
        velocity(0,0);
        Angle(90);
      }
  }
  else if(scene==2){
    println("Scene two!!!!!!!!11");
      if(imgHeight - initialY <= current_position[1] ){
        velocity(180,120);
      }else{
        velocity(0,0);
        Angle(180);
      }
  }
  else if(scene==3){
    println("Scene three!!!!!!!!11");
      if(initialX <= current_position[0]){
        velocity(180,120);
      }else{
        velocity(0,0);
        Angle(270);
      }
  }
  else if(scene==4){
    println("Scene four!!!!!!!!11");
      if(current_position[1] <=initialY){
        velocity(180,120);
      }else{
        velocity(0,0);
        Angle(360);
      }
  }
}


void velocity(int vl, int vr){
  port.write('V');
  port.write(vl);
  port.write(vr);
  println(vl);
  println(vr);
}

void Angle(float desired_angle){
  float k_theta = 12./90.;
  float robot_angle = degree;
  float theta_e = desired_angle - robot_angle;

  //if (theta_e > 90){
  //  theta_e = theta_e -180;
  //} 
  
  //if(theta_e<3&&theta_e>-3){
  //  theta_e = 0;
  //}
  
  vl = (k_theta*theta_e)+123;
  vr = (k_theta*theta_e)+123;
  
  if(vr<=125 && vr>=120){
    vr = 0;
    scene = scene+1;
    println("Scene plus-----------------------------------------------");
  }
  if(vl<=125 && vl>=120){
    vl = 0;
  }
  port.write('R');
  
  port.write((int)vl);
  port.write((int)vr);
  
  println("vl : "+(int)vl);
  println("vr : "+(int)vr);
}

float[] populateColorArray(int[] pixelArray,int id){
 float[] ColorArray = new float[PADim];
 for(int i=0; i<PADim; i++){
   if(id==1){
     ColorArray[i] = Colorness1(pixelArray[i]);
   }else if(id==2){
     ColorArray[i] = Colorness2(pixelArray[i]);
   }else if(id==3){
     ColorArray[i] = Colorness3(pixelArray[i]);
   }    
 }
 return ColorArray;
}

float[] clippers(float[] ColorArray){
 float cutoff = 0.175;
 for(int i = 0; i<PADim; i++){
  if(ColorArray[i] > cutoff){
   ColorArray[i] = 1; 
  }
  else{
   ColorArray[i] = 0; 
  }
 }
 return ColorArray;
}

int[] centroid(float[] clippedArray){
 int[] centroid = new int[2];
 int count = 1;
 int xCenter = 0;
 int yCenter = 0;
 int countCutoff = 100;
 for(int i=0; i<PADim; i++){
  if(clippedArray[i] == 1){
   count += 1;
   xCenter += i%imgWidth;
   yCenter += (i - i%imgWidth)/imgWidth;
   int posX = i%imgWidth;
   int posY = (i - i%imgWidth)/imgWidth;
   stroke(255);
   strokeWeight(1);
   point(posX,posY);
  }
 }
 
 if(count> countCutoff){
  centroid[0] = xCenter/count;
  centroid[1] = yCenter/count;
 }
 else{
  centroid[0] = 0;
  centroid[1] = 0;
 }
 return centroid;
}

void drawCrosshairs(int[] centroid){
 int xPos = centroid[0];
 int yPos = centroid[1];
 stroke(255);
 line(xPos, 0, xPos, imgHeight);
 line(0, yPos, imgWidth, yPos);
 ellipseMode(RADIUS);
 noFill();
 ellipse(xPos, yPos, 0, 0);
}

void mousePressed() { 
  if(mouseX>=0&&mouseX<=320&&mouseY>=0&&mouseY<=240&&check==1){
    int loc = mouseX + mouseY*Cam.width;
    trackColor[0] = Cam.pixels[loc];
  }else if(mouseX>=0&&mouseX<=320&&mouseY>=0&&mouseY<=240&&check==2){
    int loc = mouseX + mouseY*Cam.width;
    trackColor[1] = Cam.pixels[loc];
  }
}

void radio(int theC) {
  switch(theC) {
    case(1):check = 1; break;
    case(2):check = 2; break;
    case(3):check = 3; break;    
    case(4):check = 4; break;
  }
}