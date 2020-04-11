float projSize = 200;
int resI = 30;
int resJ = 30;

void setup(){
  size(1280, 720);
  //fullScreen();
  colorMode(HSB, 360, 100, 100);
  strokeWeight(4);
  noFill();
}

void draw(){
  background(360);
  stroke(0, 80);
  float lamda0 = float(frameCount)/100;
  translate(width/2, height/2);
  //draw horizotal line
  for(int i = 0 ; i <= resI; i++){
    float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
    beginShape();
    for(float j = 0 ; j <= resJ; j++){
      float lamda = map(j, 0, resJ, -PI, PI);
      float hue = map(j, 0, resJ, 0, 360);
      PVector p = sinusoidalProjection(projSize, phi, lamda, lamda0);
      vertex(p.x, p.y);
    }
    endShape();
  }
  //draw vertical line
  for(float j = 0 ; j <= resJ; j++){
    float lamda = map(j, 0, resJ, -PI, PI);
    float hue = map(j, 0, resJ, 0, 360);
    stroke(hue, 100, 100);
    beginShape();
    for(int i = 0 ; i <= resI; i++){
      float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
      PVector p = sinusoidalProjection(projSize, phi, lamda, lamda0);
      vertex(p.x, p.y);
    }
    endShape();
  }
}

//based on this cite https://en.wikipedia.org/wiki/Sinusoidal_projection
PVector sinusoidalProjection(float R, float phi, float lambda, float lambda0){//stereographic Projection
  //float x = (lambda - lambda0)*cos(phi)*R;
  float x = (loopMod(lambda - lambda0, TWO_PI)-TWO_PI-PI)*cos(phi)*R;//loop longitude
  float y = phi*R;
  return new PVector(x, y);
}

float loopMod(float x, float val){
  while(x < val){
    x += val;
  }
  return x;
}