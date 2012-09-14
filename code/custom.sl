surface custom(	float player1 = 0.5,
				player2 = 0.2,
				ballY = 0.5,
				ballX = 0.2,
				mixer = 0.5;
				color ramp1 = color(0,0,0),
				ramp2 = color(0.1,1.1,0.1))
{
color surfcolor = 0;
float shade = sqrt(pow((s-0.8), 2)+pow(t-0.2, 2))*0.2;
    surfcolor = color(shade,shade,shade);

float i;

//left paddle
if(s >= 0.03 && s <= 0.05 && t >= player1-0.07 && t <= player1+0.07)
    surfcolor = color(1,1,1);

//right paddle
if(s >= 0.95 && s <= 0.97 && t >= player2-0.07 && t <= player2+0.07)
    surfcolor = color(1,1,1);

//ball
if(s >= ballX-0.015 && s <= ballX+0.015 && t >= ballY-0.015 && t <= ballY+0.015)
    surfcolor = color(1,1,1);

//middle line
if(s >= 0.49 && s <= 0.51 && t >= 0.04 && t <= 0.96)
    surfcolor = color(1,1,1);

//border
for (i = 0.01; i <= 1; i += 0.04)
{
	if((s >= i && s <= i+0.02)&&(t >= 0.96 && t <= 0.98 || t >= 0.02 && t <= 0.04))
	surfcolor = color(1,1,1);
}

//Zero
float zeroPosX = 0.4;
float zeroPosY = 0.15;
if(s >= zeroPosX-0.04 && s <= zeroPosX+0.04 && t >= zeroPosY-0.06 && t <= zeroPosY+0.06)
    surfcolor = color(1,1,1);
if(s >= zeroPosX-0.02 && s <= zeroPosX+0.02 && t >= zeroPosY-0.05 && t <= zeroPosY+0.05)
    surfcolor = color(0,0,0);

//Zero
zeroPosX = 0.65;
zeroPosY = 0.15;
if(s >= zeroPosX-0.04 && s <= zeroPosX+0.04 && t >= zeroPosY-0.06 && t <= zeroPosY+0.06)
    surfcolor = color(1,1,1);
if(s >= zeroPosX-0.02 && s <= zeroPosX+0.02 && t >= zeroPosY-0.05 && t <= zeroPosY+0.05)
    surfcolor = color(0,0,0);       
Oi = Os;
  
Ci = Oi * Cs * surfcolor;
}
