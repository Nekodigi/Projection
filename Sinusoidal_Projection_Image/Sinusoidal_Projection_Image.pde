float outSize = 200;
float projSize = 100;
int resI = 30;
int resJ = 30;
PImage img;
boolean render = false;
Bicubic bicubic;

void setup(){
  size(1280, 720);
  //fullScreen();
  strokeWeight(5);
  img = loadImage("FevCat.png");
  bicubic = new Bicubic(img);
  noFill();
}

void draw(){
  background(255);
  image(img, 0, 0, height/4, height/4);
  float lambda0 = (float(frameCount)/20)%TWO_PI-PI;
  translate(width/2, height/2);
  float tileS = 10;
  if(render){ 
    tileS = 1;
  }else{
    noFill();
    stroke(0);
    //draw horizotal line
    for(int i = 0 ; i <= resI; i++){
      float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
      beginShape();
      for(float j = 0 ; j <= resJ; j++){
        float lambda = map(j, 0, resJ, -PI, PI);
        float hue = map(j, 0, resJ, 0, 360);
        PVector p = sinusoidalProjection(projSize, phi, lambda, lambda0);
        vertex(p.x, p.y);
      }
      endShape();
    }
    //draw vertical line
    for(float j = 0 ; j <= resJ; j++){
      float lambda = map(j, 0, resJ, -PI, PI);
      float hue = map(j, 0, resJ, 0, 360);
      beginShape();
      for(int i = 0 ; i <= resI; i++){
        float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
        PVector p = sinusoidalProjection(projSize, phi, lambda, lambda0);
        vertex(p.x, p.y);
      }
      endShape();
    }
  }
  //show image
  noStroke();
  for(float x = -outSize; x < outSize; x+=tileS){
      for(float y = -outSize; y < outSize; y+=tileS){
        PVector p2 = unSinusoidalProjection(projSize, x, y, lambda0);//-half_pi < phi(x) < half_pi, -pi < lamda(y) < pi
        p2 = new PVector(map(p2.x, -HALF_PI, HALF_PI, 0, img.width), map(p2.y, -PI, PI, 0, img.height));//0 < x < img.width, 0 < y < img.height
  
        if(p2.x > 0 && p2.x < img.width && p2.y > 0 && p2.y < img.height){
          fill(bicubic.colorAt(p2.y, p2.x));
          //rect(p2.x, p2.y, tileS, tileS);
          rect(x, y, tileS, tileS);
        }
      }
    }
}

void keyPressed(){
  if(key == 'r'){
    render = !render;
  }
}