/*Animation adapted from Memo Atken's online tutorial http://www.memo.tv/works/ - additional functionality
to include data from a live weather API program written in Python
*/



//Globalsss
//create a class from the MSAbox object

//this is an array of these
ArrayList<MSAbox> boxes = new ArrayList<MSAbox>();

boolean followLeader = false; //toggle some behaviour

boolean do_drawTail = true;

boolean doDrawFan = true;

int tailFrameCount = 2;

int maxTail = 500;

//OSC setup for receiving incoming weather data from python program
import oscP5.*;
import netP5.*;

OscP5 oscP5;

float windValue, tempValue;

void oscEvent(OscMessage theOscMessage) {
   
  //get incoming wind data
  if(theOscMessage.checkAddrPattern("/weather/wind") == true){
  windValue = theOscMessage.get(0).floatValue();
  print(windValue + " ");
  }
  
}



//create a function which uses MSAbox object and a poistion variable object (PVector)
//to pass some behaviour to other box classes
void updateBox(MSAbox b, PVector target_pos){
  
  PVector dist = PVector.sub(target_pos, b.pos);
  PVector dist_scale = PVector.mult(dist, b.dist_mult);
  //add distScaled to velocity
  b.velocity.add(dist_scale);
  //add velocity to position
  b.pos.add(b.velocity);
  //multiply velocity by momentum
  b.velocity.mult(b.momentum);
  //add current pos to tail
   if(frameCount % tailFrameCount == 0){
  for(int i = 0; i < maxTail; i += 50){
    b.tail.add(b.pos.copy());
    if(b.tail.size() >= maxTail){
      b.tail.remove(i);
    }
  }
   }
 
  
}
//-----------------
//create a function which draws a box 
void drawBox(MSAbox b){
 
  //update box with myBox - and draw a box
  updateBox(b, b.pos);
  pushMatrix();
  translate(b.pos.x, b.pos.y);
  fill(0);
  strokeWeight(1);
  box(b.rad); 
  popMatrix();
  stroke(255);
  
  float speed = b.velocity.mag();
  float sW = map(speed, 0, 10, 0, b.rad);
  
  //draw tail
  
  for(int f = 0; f < b.tail.size() - 1; f ++){
    PVector p0 = b.tail.get(f);
    PVector p1 = b.tail.get(f + 1);
    /*adjusting p1.x changes the 'wind' effect, let's use the live wind data here
    from the python weather API program
    */
    p1.x += windValue;
    smooth();
    float lineMap = map(f,0,b.tail.size() - 1, 0, 1);
    if(do_drawTail){
    strokeWeight(sW * lineMap);
    line(p0.x,p0.y,p1.x,p1.y);
    }
    //draw a fan
  if(doDrawFan){
    strokeWeight(1);
    stroke(255 * lineMap);
    line(p1.x, p1.y, b.pos.x, b.pos.y);
  }
  
  
  
    
  }
}
//-----------------



void setup(){
  
  //start with three boxes
  for(int i =0; i < 3; i ++){
  PVector p = new PVector(random(0,width), random(0,height));
  boxes.add(i,new MSAbox(p));
    
    
  }
  
  size(800,800, P3D); 
  
  //listen for OSC messages on port (second arg)
  oscP5 = new OscP5(this,12345);
     
}
//-----------------
void draw(){
  
  
  background(0);
  
  PVector mousePos = new PVector(mouseX, mouseY, 0);
  
  
  for(int i = 0; i < boxes.size(); i ++){
    
  if(i > 0 & followLeader){
  updateBox(boxes.get(i), boxes.get(i - 1).pos);
  }else{updateBox(boxes.get(i), mousePos);}
  drawBox(boxes.get(i));
  
  }
  
}
//----------------
void mousePressed(){
  MSAbox b = new MSAbox(new PVector(mouseX,mouseY));
  boxes.add(b);
  
}
//-----------------
void keyPressed(){
  
  switch(key){
    case 'l': followLeader = !followLeader;
    break;
    case 't': do_drawTail = !do_drawTail;
    break;
    case 'f': doDrawFan = !doDrawFan; 
  }
  
}
