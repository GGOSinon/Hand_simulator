
Arm arm;
void setup()
{
  //frameRate(10);
  arm = new Arm(radians(10),radians(10),radians(5),   5, 3, 2.5,  0.5, 0.3, 0.25,   15, 15, 15,   0.1);
  size(1000,600);
}

float T=0;
void draw()
{
  T+=0.05;
  arm.run(T);
  arm.display();
}