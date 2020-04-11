float projSize = 300;
int resI = 30;
int resJ = 30;

void setup(){
  //size(1280, 720);
  fullScreen();
  colorMode(HSB, 360, 100, 100);
  strokeWeight(10);
  noFill();
}

void draw(){
  background(360);
  stroke(0, 80);
  float phi1 = float(frameCount)/500;
  float lambda0 = float(frameCount)/100;
  translate(width/2, height/2);
  //draw horizotal line
  for(int i = 0 ; i <= resI; i++){
    float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
    beginShape();
    for(float j = 0 ; j <= resJ; j++){
      float lambda = map(j, 0, resJ, -PI, PI);
      float hue = map(j, 0, resJ, 0, 360);
      PVector p = azimuthalProjection(projSize, phi, phi1, lambda, lambda0);
      vertex(p.x, p.y);
    }
    endShape();
  }
  //draw vertical line
  for(float j = 0 ; j <= resJ; j++){
    float lambda = map(j, 0, resJ, -PI, PI);
    float hue = map(j, 0, resJ, 0, 360);
    stroke(hue, 100, 100);
    beginShape();
    for(int i = 0 ; i <= resI; i++){
      float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
      PVector p = azimuthalProjection(projSize, phi, phi1, lambda, lambda0);
      vertex(p.x, p.y);
    }
    endShape();
  }
}

//based on this cite https://mathworld.wolfram.com/AzimuthalEquidistantProjection.html
PVector azimuthalProjection(float R, float phi, float phi1, float lambda, float lambda0){//stereographic Projection
  float c = acos(sin(phi1)*sin(phi) + cos(phi1)*cos(phi)*cos(lambda - lambda0));
  float k = c/sin(c);
  float x = k*cos(phi)*sin(lambda - lambda0);
  float y = k*(cos(phi1)*sin(phi) - sin(phi1)*cos(phi)*cos(lambda - lambda0));
  return new PVector(x*R, y*R);
}

float loopMod(float x, float val){
  while(x < val){
    x += val;
  }
  return x;
}