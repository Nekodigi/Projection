//based on this cite https://en.wikipedia.org/wiki/Mollweide_projection
PVector mollweideProjection(float R, float phi, float lambda, float lambda0){//stereographic Projection
  float theta = phi2theta(phi, 10);
  float x = R*2*sqrt(2)/PI*(loopMod(lambda - lambda0, TWO_PI)-TWO_PI-PI)*cos(theta);//loop longitude
  float y = R*sqrt(2)*sin(theta);
  return new PVector(x, y);
}

float phi2theta(float phi, int iter){
  float theta = phi;
  for(int i = 0; i < iter; i++){
    theta = theta - (2*theta + sin(2*theta) - PI*sin(phi))/(2 + 2*cos(2*theta));
  }
  return theta;
}

PVector unMollweideProjection(float R, float x, float y, float lambda0){//stereographic Projection
  //float x = (lambda - lambda0)*cos(phi)*R;
  float theta = asin(y/R/sqrt(2));
  float phi = asin((2*theta + sin(2*theta))/PI);
  float lambda = lambda0 + PI*x/(2*R*sqrt(2)*cos(theta));
  lambda = loopMod(lambda, TWO_PI)-TWO_PI-PI;
  return new PVector(phi, lambda);
}

PVector unSinsodialProjection(float R, float x, float y, float lambda0){//stereographic Projection
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