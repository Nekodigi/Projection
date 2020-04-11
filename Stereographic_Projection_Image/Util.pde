//based on this cite https://mathworld.wolfram.com/StereographicProjection.html
PVector stereoProjection(float R, float phi, float phi1, float lambda, float lambda0){//stereographic Projection
  float k = 2*R/(1+sin(phi1)*sin(phi) + cos(phi1)*cos(phi)*cos(lambda - lambda0));
  float x = k*cos(phi)*sin(lambda - lambda0);
  float y = k*(cos(phi1)*sin(phi) - sin(phi1)*cos(phi)*cos(lambda - lambda0));
  return new PVector(x, y);
}

PVector unStereoProjection(float R, float x, float y, float phi1, float lambda0){//stereographic Projection
  float rho = sqrt(x*x + y*y);
  float c = 2*atan(rho/(2*R));
  float phi = asin(cos(c)*sin(phi1) + y*sin(c)*cos(phi1)/rho);
  float lambda = loopMod(lambda0 + atan2(x*sin(c), (rho*cos(phi1)*cos(c) - y*sin(phi1)*sin(c))), TWO_PI)-TWO_PI-PI;
  //unique processing
  return new PVector(phi, lambda);
}

float loopMod(float x, float val){
  while(x < val){
    x += val;
  }
  return x;
}