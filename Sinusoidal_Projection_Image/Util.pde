//based on this cite https://en.wikipedia.org/wiki/Sinusoidal_projection
PVector sinusoidalProjection(float R, float phi, float lambda, float lambda0){//stereographic Projection
  //float x = (lambda - lambda0)*cos(phi)*R;
  float x = (loopMod(lambda - lambda0, TWO_PI)-TWO_PI-PI)*cos(phi)*R;//loop longitude
  float y = phi*R;
  return new PVector(x, y);
}

PVector unSinusoidalProjection(float R, float x, float y, float lambda0){//stereographic Projection
  //float x = (lambda - lambda0)*cos(phi)*R;
  float phi = y/R;
  float lambda = lambda0 + x/cos(phi)/R;
  lambda = loopMod(lambda, TWO_PI)-TWO_PI-PI;
  return new PVector(phi, lambda);
}

float loopMod(float x, float val){
  while(x < val){
    x += val;
  }
  return x;
}