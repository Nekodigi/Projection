int resI = 30;
int resJ = 30;

void setup(){
  //size(500, 500);
  fullScreen();
  colorMode(HSB, 360, 100, 100);
  strokeWeight(10);
  noFill();
}

void draw(){
  background(360);
  stroke(0, 80);
  float phi1 = float(frameCount)/500;
  float lamda0 = float(frameCount)/100;
  translate(width/2, height/2);
  //draw horizotal line
  for(int i = 0 ; i <= resI; i++){
    float phi = map(i, 0, resI, -HALF_PI, HALF_PI);
    beginShape();
    for(float j = 0 ; j <= resJ; j++){
      float lamda = map(j, 0, resJ, -PI, PI);
      float hue = map(j, 0, resJ, 0, 360);
      PVector p = stereoProjection(height/10, phi, phi1, lamda, lamda0);
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
      PVector p = stereoProjection(height/10, phi, phi1, lamda, lamda0);
      vertex(p.x, p.y);
    }
    endShape();
  }
}
//based on this cite https://mathworld.wolfram.com/StereographicProjection.html
PVector stereoProjection(float R, float phi, float phi1, float lamda, float lamda0){//stereographic Projection
  float k = 2*R/(1+sin(phi1)*sin(phi) + cos(phi1)*cos(phi)*cos(lamda - lamda0));
  float x = k*cos(phi)*sin(lamda - lamda0);
  float y = k*(cos(phi1)*sin(phi) - sin(phi1)*cos(phi)*cos(lamda - lamda0));
  return new PVector(x, y);
}