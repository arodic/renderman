surface pong(	float	Kd = 0.6, /* [0 10]*/
						Ks = 0.8, /* [0 10]*/
						roughness = 0.1,
						player1 = 0.5, /* [0 1]*/
						player2 = 0.2, /* [0 1]*/
						ballY = 0.5, /* [0 1]*/
						ballX = 0.2, /* [0 1]*/
						offset = 0, /* [-1 1]*/
						freq1 = 0, /* [0 1000 1]*/
						freq2 = 0, /* [0 1000 1]*/
						freq3 = 0, /* [0 1000 1]*/
						amplitude = 0, /* [0 100]*/
						separation = 1, /* [0 1] */
						noiselevel = 1, /* [0 1] */
						frame = 0;
				color	hiliteColor = 1,
						surfColor = 0)
{
 

color surfcolor = surfColor;
normal	n = normalize(N);
normal  nf = faceforward(n, I);	
float si = (s);
float ti = (t);

//INETFERENCE OFSET
ti = ti + offset;
if (ti >= 1)
ti = ti - 1;
if (ti <= 0)
ti = ti + 1;

//INETFERENCE SINE
si = si + amplitude*(sin(t*freq1-1)+sin(t*freq2-2)+sin(t*freq3-3));
if (si >= 1)
si = si-1;
if (si >= 1)
si = si - 1;
if (si <= 0)
si = si + 1;

//Noise
float	whitenoise = noise(round((si+200*frame)*250)+0.5, round(((ti+1000*frame)+0.004)*200))*noiselevel;

//left paddle
if(si >= 0.03 && si <= 0.05 && ti >= player1-0.07 && ti <= player1+0.07)
    surfcolor = color(1,1,1);

//right paddle
if(si >= 0.95 && si <= 0.97 && ti >= player2-0.07 && ti <= player2+0.07)
    surfcolor = color(1,1,1);

//ball
if(si >= ballX-0.015 && si <= ballX+0.015 && ti >= ballY-0.015 && ti <= ballY+0.015)
    surfcolor = color(1,1,1);

//middle line
if(si >= 0.49 && si <= 0.51 && ti >= 0.04 && ti <= 0.96)
    surfcolor = color(1,1,1);

//border
float loop;
for (loop = 0.01; loop <= 1; loop += 0.04)
{
	if((si >= loop && si <= loop+0.02)&&(ti >= 0.96 && ti <= 0.98 || ti >= 0.02 && ti <= 0.04))
	surfcolor = color(1,1,1);
}

//Zero
float zeroPosX = 0.4;
float zeroPosY = 0.15;
if(si >= zeroPosX-0.04 && si <= zeroPosX+0.04 && ti >= zeroPosY-0.06 && ti <= zeroPosY+0.06)
    surfcolor = color(1,1,1);
if(si >= zeroPosX-0.02 && si <= zeroPosX+0.02 && ti >= zeroPosY-0.05 && ti <= zeroPosY+0.05)
    surfcolor = surfColor;

//Zero
zeroPosX = 0.65;
zeroPosY = 0.15;
if(si >= zeroPosX-0.04 && si <= zeroPosX+0.04 && ti >= zeroPosY-0.06 && ti <= zeroPosY+0.06)
    surfcolor = color(1,1,1);
if(si >= zeroPosX-0.02 && si <= zeroPosX+0.02 && ti >= zeroPosY-0.05 && ti <= zeroPosY+0.05)
    surfcolor = surfColor;

// diffuse component
color diffusecolor = 1;
if (surfcolor != color(1,1,1)){
	color diffusecolor = diffuse(nf) * Kd * surfcolor;
}

// Fill Removal (when noise)
surfcolor = surfcolor*(1-noiselevel)+whitenoise;


//Stripes

for (loop = 0.00; loop <= 1; loop += 0.004)
{
	if(si >= loop && si <= loop+0.001)
	surfcolor = surfcolor * (1, separation, separation);
	if(si >= loop+0.001 && si <= loop+0.002)
	surfcolor = surfcolor * (separation, 1, separation);
	if(si >= loop+0.002 && si <= loop+0.003)
	surfcolor = surfcolor * (separation, separation, 1);
	if(si >= loop+0.003 && si <= loop+0.004)
	{
	//surfcolor = surfcolor*(1, 1, 1);
	surfcolor = surfcolor*(separation);
	}
}     

for (loop = 0.00; loop <= 1; loop += 0.005)
{
	if(ti >= loop+0.003 && ti <= loop+0.004)
	surfcolor = surfcolor*(separation);
}  
 
// specular component
vector i = normalize(-I);
color speccolor = specular(nf, i, roughness) * hiliteColor * Ks; 

Oi = Os;
Ci = Oi * Cs * surfcolor * (diffusecolor + speccolor) + speccolor;
}
