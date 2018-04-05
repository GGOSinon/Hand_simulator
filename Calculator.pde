class Calculator
{
  float a[][] = new float[505][505];
  float b[] = new float[505];
  float res[] = new float[505];
  //m formulas with n variables 
  float[] calculate(float[][] ma, float[] mb, int m, int n) //m*n matrix
  {
    int i,j,k;
    for(i=0;i<m;i++)for(j=0;j<n;j++)a[i][j]=ma[i][j];
    for(i=0;i<n;i++)b[i]=mb[i];
    //Making REF
    for(i=0;i<m;i++){
      //Check if there is nonzero
      for(j=i;j<m;j++){
        if(a[j][i]!=0)break;
      }
      if(j==m){
        println("WTF IT IS NOT INVERTIBLE");
      }
      for(k=0;k<n;k++){
        //swap(a[i][k], a[j][k])
        float x = a[i][k];
        float y = a[j][k];
        x += (y - (y = x));
        a[i][k] = x;
        a[j][k] = y;
      }
      float x = b[i];
      float y = b[j];
      x += (y - (y = x));
      b[i] = x;
      b[j] = y;
      for(j=i+1;j<m;j++){
        float scale = a[j][i]/a[i][i];
        a[j][i]=0;
        for(k=i+1;k<n;k++){
          a[j][k]-=(scale*a[i][k]);
        }
        b[j]-=scale*b[i];
      }
    }
    // Get Values
    for(i=m-1;i>=0;i--){
        res[i]=b[i];
        for(j=i+1;j<n;j++){
          b[i]-=a[i][j]*res[j];
        }
        res[i]/=a[i][i];
    }
    return res;
  }
}