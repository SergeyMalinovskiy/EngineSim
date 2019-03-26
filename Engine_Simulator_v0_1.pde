PImage imgEngineMain,imgEngineMainGrid,imgShaft, imgPiston;
PFont font;

int tactNumber = 1;
int tactCount = 1;

void setup()
{
  size(800, 600);
  frameRate(30);
  
  imgEngineMain = loadImage("images\\engine_block.png");
  imgEngineMainGrid = loadImage("images\\engine_grid.png");
  imgShaft = loadImage("images\\shaft.png");
  imgPiston = loadImage("images\\piston.png");
  
  font = loadFont("data\\ArialMT-48.vlw");
  background(255);
  smooth();
  
  
}

boolean handleTact = false;
boolean toDown = false;
boolean lastToDown = false;
float freq = 0;
float last_y = 0;
//float k = 1;
float step = 0.05;
float xPointShaft, yPointShaft;
float   xPosClapan_1 = 300-3,
        yPosClapan_1 = 50-4,
        xPosClapan_2 = 300+3,
        yPosClapan_2 = 50-4;

int handleNumber=1;

void draw(){
  freq += step;
  background(255);
  xPointShaft = cos(freq);
  yPointShaft = sin(freq);
  
  float y = 20*sin(freq);
  
  if(y > last_y) toDown = true;
  if(y < last_y) toDown = false;
  
  if(millis()>2000){
    if((lastToDown && !toDown)||(!lastToDown && toDown)){
      handleNumber++;
      tactCount++;
      if(tactNumber!=4) tactNumber++;
      else tactNumber=1;
    }
  }
  /*
  if(tactNumber == 1 || tactNumber == 2){
    xPosClapan_2 -= y/100;
    yPosClapan_2 += y/100;
  }
  if(tactNumber == 3 || tactNumber == 4){
    xPosClapan_1 += y/100;
    yPosClapan_1 += y/100;
  }
  */
  //line(xPosClapan_1+44-10,yPosClapan_1+42,xPosClapan_1+91,yPosClapan_1+128);
  //line(xPosClapan_2+173+10,yPosClapan_2+42,xPosClapan_2+126,yPosClapan_2+128);
  
  //line(xPosClapan_1+74+3,yPosClapan_1+140,xPosClapan_1+107,yPosClapan_1+117);
  //line(xPosClapan_2+143-3,yPosClapan_2+140,xPosClapan_2+109,yPosClapan_2+117);
  
  if(!(tactNumber == 1)) line(xPosClapan_2+143-3,yPosClapan_2+140,xPosClapan_2+109,yPosClapan_2+117);
  if(!(tactNumber == 4)) line(xPosClapan_1+74+3,yPosClapan_1+140,xPosClapan_1+107,yPosClapan_1+117);
  
  image(imgEngineMain, 300,50);
  image(imgShaft, 300+70,50+296);
  
  stroke(255,0,0);
  strokeWeight(3);
  noFill();
  ellipse(409, 385, 80, 80);
  
  stroke(19,19,19);
  fill(30,30,30);
  ellipse(27*xPointShaft+409,27*yPointShaft+385, 15,15);
  
  line(27*xPointShaft+409+7,  27*yPointShaft+385, 300+74+33+4  ,  50+135+y+25+65);
  line(27*xPointShaft+409-7,  27*yPointShaft+385, 300+74+33-4  ,  50+135+y+25+65);
  

  
  
  image(imgPiston, 300+74,50+135+y+25);
  fill(0);
  textFont(font, 14);
  textAlign(LEFT);
  text(step, 20, 20);
  
  text("Pos : "+y+ "Gr", 20, 100);
  text("FPS : "+frameRate, 20, 40);
  text("Freq: "+frameRate*step/(2*PI)+" Hz", 20, 60);
  text("RPM: "+int(60*frameRate*step/(2*PI)), 20, 80);
  //text("Lenght: "+sqrt(pow((27*xPointShaft)+(409-300+74+33),2)+pow((27*yPointShaft+385)-(50+135+y+25+65),2)), 20, 120);
  text("Tact: "+tactNumber,20,140);
  
  if(toDown) text("Move to down",20,160);
  else text("Move to up",20,160);
  text("Handles: "+handleNumber,20,180);
  //text("Count of Takts: "+tactCount,20,200);
  //text("Error: "+(tactCount/(handleNumber+1)-1),20,220);
  
  lastToDown = toDown;
  last_y = y;
 // if(freq >= 4) freq = 0;
}

void keyPressed() {
  if(keyCode == UP) step+=0.005; 
  if(keyCode == DOWN) step-=0.005; 
}
