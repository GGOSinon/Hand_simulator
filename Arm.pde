class Arm
{
  float angle1, angle2, angle3;
  float dangle1, dangle2, dangle3;
  float ddangle1, ddangle2, ddangle3;
  float F_x1, F_x2, F_x3, F_y1, F_y2, F_y3;
  float d1, d2, d3;
  float m1, m2, m3;
  float M1, M2, M3, L;
  float k1, k2, k3;
  float dt = 0.01;
  float a[][] = new float[505][505];
  float b[] = new float[505];
  float res[] = new float[505];
  float Angles[][] = new float[3][3];
  
  Arm(float angle1, float angle2, float angle3, float d1, float d2, float d3, float m1, float m2, float m3, float k1, float k2, float k3, float L){
    this.angle1 = angle1; this.angle2 = angle2; this.angle3 = angle3;
    this.d1=d1; this.d2=d2; this.d3=d3;
    this.m1=m1; this.m2=m2; this.m3=m3;
    this.k1=k1; this.k2=k2; this.k3=k3;
    this.L = L;
    M1 = (d1*d1*m1)/3; M2 = (d2*d2*m2)/3; M3 = (d3*d3*m3)/3;
  }

  float f(float k, float angle)
  {
    if(angle>0)return k*angle*angle*angle;
    return 1000*k*angle;
  }
  
  void run(float T)
  {
    int i,j;
    float t1 = 0.5*d1*cos(angle2)+d2+0.5*d3*cos(angle3);
    float t2 = 0.5*d1*sin(angle2)-0.5*d3*sin(angle3);
    float t = sqrt(t1*t1+t2*t2);
    float S2 = (sin(angle2+angle3)*d3+2*sin(angle2)*d2)/(2*t);
    float S3 = (sin(angle2+angle3)*d1+2*sin(angle3)*d2)/(2*t);
    float A1 = angle1;
    float A2 = angle1 + angle2;
    float A3 = angle1 + angle2 + angle3;
    //F_x3 = T*(cos(A3)+S3*sin(A3)) - m3*(d1*sin(A1)*dangle1+d2*sin(A2)*dangle2+0.5*d3*sin(A3)*dangle3);
    F_x3 = T*(S3*sin(A3)) - m3*(d1*sin(A1)*dangle1+d2*sin(A2)*dangle2+0.5*d3*sin(A3)*dangle3);
    F_x2 = F_x3 - m2*(d1*sin(A1)*dangle1+0.5*sin(A2)*dangle3);
    F_x1 = F_x2 + T*(sin(A1)+S2)*sin(A1) - m1*(0.5*d1*sin(A1)*dangle1);
    
    //F_y3 = T*(-sin(A3)+S3*cos(A3)) - m3*(d1*cos(A1)*dangle1+d2*cos(A2)*dangle2+0.5*d3*cos(A3)*dangle3);
    F_y3 = T*(S3*cos(A3)) - m3*(d1*cos(A1)*dangle1+d2*cos(A2)*dangle2+0.5*d3*cos(A3)*dangle3);
    F_y2 = F_y3 - m2*(d1*cos(A1)*dangle1+0.5*cos(A2)*dangle3);
    F_y1 = F_y2 + T*(sin(A1)+S2)*cos(A1) - m1*(0.5*d1*cos(A1)*dangle1);
    
    ddangle1 = (0.5*d1*T*(sin(angle1)+S2)+d1*(F_x2*sin(angle1)+F_y2*cos(angle1)) - f(k1,angle1)) / M1;
    ddangle2 = (d2*(F_x3*sin(A2)+F_y3*cos(A2)) - f(k2,angle2)) / M2;
    //ddangle3 = (0.5*d3*T*S3 + 0.5*L*T - f(k3,angle3)) / M3;
    ddangle3 = (0.5*d3*T*S3  - f(k3,angle3)) / M3;
    println(ddangle1, ddangle2, ddangle3);
    println(angle1, angle2, angle3);
    println(F_x1, F_x2, F_x3);
    println(F_y1, F_y2, F_y3);
    println();
    
    dangle1+=ddangle1*dt;
    dangle2+=ddangle2*dt;
    dangle3+=ddangle3*dt;
    
    angle1+=dangle1*dt;
    angle2+=dangle2*dt;
    angle3+=dangle3*dt;
  }
  
  void display()
  {
    background(255);
    PVector loc = new PVector(100, 500);
    PVector loc0 = new PVector(100, 0);
    PVector loc1 = new PVector(d1*50*cos(angle1), -d1*50*sin(angle1));
    PVector loc2 = new PVector(d2*50*cos(angle1+angle2), -d2*50*sin(angle1+angle2));
    PVector loc3 = new PVector(d3*50*cos(angle1+angle2+angle3), -d3*50*sin(angle1+angle2+angle3));
    loc0.add(loc);
    loc1.add(loc0);
    loc2.add(loc1);
    loc3.add(loc2);
    fill(0);
    stroke(0);
    line(loc.x, loc.y, loc0.x, loc0.y);
    line(loc0.x, loc0.y, loc1.x, loc1.y);
    line(loc1.x, loc1.y, loc2.x, loc2.y);
    line(loc2.x, loc2.y, loc3.x, loc3.y);
  }
}