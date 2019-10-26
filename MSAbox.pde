//create an object which compartmentalises some behaviour
//initiate class and name it
class MSAbox{
//relevant class data  
  PVector pos;
  float rad;
  float dist_mult;
  PVector velocity;
  float momentum;  
  ArrayList<PVector> tail;  
//class constuctor  
MSAbox(PVector p)
{
    pos = p;
    rad = random(5,20);
    dist_mult = random(0.005,0.009); //tweaking these changes behaviour alot
    velocity = new PVector(0,0,0);
    momentum = random(0.90,0.95);//and me!
    tail = new ArrayList<PVector>();
    
   
}

}
