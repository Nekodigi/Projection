//based on this cite https://mathworld.wolfram.com/StereographicProjection.html
PVector stereoProjection(float R, float phi, float phi1, float lamda, float lamda0){//stereographic Projection
  float k = 2*R/(1+sin(phi1)*sin(phi) + cos(phi1)*cos(phi)*cos(lamda - lamda0));
  float x = k*cos(phi)*sin(lamda - lamda0);
  float y = k*(cos(phi1)*sin(phi) - sin(phi1)*cos(phi)*cos(lamda - lamda0));
  return new PVector(x, y);
}

PVector unStereoProjection(float R, float x, float y, float phi1, float lamda0){//stereographic Projection
  float ro = sqrt(x*x + y*y);
  float c = 2*atan(ro/2/R);
  float phi = asin(cos(c)*sin(phi1) + y*sin(c)*cos(phi1)/ro);
  float lamda = lamda0 + atan(x*sin(c)/(ro*cos(phi1)*cos(c) - y*sin(phi1)*sin(c)));
  //unique processing
  
  return new PVector(phi, lamda);
}