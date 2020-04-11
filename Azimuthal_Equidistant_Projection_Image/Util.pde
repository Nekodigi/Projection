//based on this cite https://mathworld.wolfram.com/AzimuthalEquidistantProjection.html
PVector azimuthalProjection(float R, float phi, float phi1, float lambda, float lambda0){//stereographic Projection
  float c = acos(sin(phi1)*sin(phi) + cos(phi1)*cos(phi)*cos(lambda - lambda0));
  float k = c/sin(c);
  float x = k*cos(phi)*sin(lambda - lambda0);
  float y = k*(cos(phi1)*sin(phi) - sin(phi1)*cos(phi)*cos(lambda - lambda0));
  return new PVector(x*R, y*R);
}

PVector unAzimuthalProjection(float R, float x, float y, float phi1, float lambda0){//stereographic Projection
  x /= R; y /= R;
  lambda0 %= TWO_PI;
  float c = sqrt(x*x + y*y);
  float phi = asin(cos(c)*sin(phi1) + y*sin(c)*cos(phi1)/c);
  float lambda = lambda0 + atan2(x*sin(c), c*cos(phi1)*cos(c) - y*sin(phi1)*sin(c));
  lambda = loopMod(lambda, TWO_PI)-TWO_PI-PI;
  return new PVector(phi, lambda);
}

float loopMod(float x, float val){
  while(x < val){
    x += val;
  }
  return x;
}