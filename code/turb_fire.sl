surface
turb_fire(float 	angle = 360,
					shift = 0,
					freq = 1,
					blur = 0.04;)
{
float i = 0;
float j = 0;
float opacity = 0; //shows control grid
float incadescence = 1; //fire brightness/opacity
float phase = 1;//third dimension of the flame
float shape = 1;
float shape2 = 1;
float shape3 = 1;
float display = 0;

//creates secondary ST space for deformation
float ti = t;float tj = t;
float si = s;float sj = s;
color surfcolor = color(1.0,0.6,0.2);



//SWIRL START/////////////////////////////////////////////////////////////////////////////////////
//variables for turbulent swirls
float dropoff = 0;
float rotation = 0;
float pivot_s = 0;
float pivot_t = 0;
//constants for turbulent swirls relative to t(ti) value
float radius = (1-ti)+2;
float angle = (-ti)*angle;

//SWIRL LOOP
for (j = -1; j <= 2; j += 0.75)
{
	angle = -angle; /*  */
	pivot_s = 0.5-(0.5-noise(j+t))+(0.5-noise(ti-shift/3))*t/5;
	pivot_t = j+shift/2;
	while (pivot_t > 2) /* brings the swirl pivots back to the bottom*/
		{
		pivot_t -= 3;
		}
	dropoff = pow(pow(abs(pivot_s-si)*2*(1/radius),2)+pow(abs(pivot_t-ti)*2*(1/radius),2),1/2);
	dropoff = 1 - dropoff;
		if (dropoff < 0) dropoff = 0;
		dropoff = pow(dropoff, 5)*(1-t+1);//sets the dropoff value relative to t position
	rotation = angle*dropoff*(1-t/5);
		
	//rotate 3D
	point stPnt = point(si, 0, ti);
	point p1 = point(pivot_s, 0, pivot_t);point p2 = point(pivot_s, 1, pivot_t);
	point stRot = rotate(stPnt, radians(rotation), p1, p2);
	si = stRot[0];ti = stRot[2];
}

//FLAME SHAPE (distorted) //////////////////////////////////////////////////

ti = ti-shift/2;
point PP = (si*freq*6, ti*freq*6, phase);

incadescence = noise(PP*2);

shape = 1-pow((pow(abs(0.5-si)*2,2)+pow(t/2,2)),1/2);
shape2 = 1-pow((pow(abs(0.5-s)*2,2)+pow(t,2)),1/2);
if (shape < 0) shape = 0;//?Do I even need this?
incadescence = 1.5*incadescence*(pow(shape,2))*shape2; //normalizes and removes the flame from the sides	
shape3 = incadescence;

//FLAME SHAPE (noise) //////////////////////////////////////////////////
tj = tj-shift/2;
tj = ti;
sj = si;
for (i = 1; i <= 100; i += 1)
{
	point PP = (sj*freq*6, tj*freq*6, phase);
	phase = phase + 0.001;
	//tj = tj + 0.0003;

	incadescence = noise(PP*1);
	incadescence = incadescence + 0.5-noise(PP*2.5);
	incadescence = incadescence + 0.5-noise(PP*6);
	incadescence = incadescence + 0.5-noise(PP*10);
	incadescence = incadescence*shape3;
	//incadescence = (incadescence + noise(PP*2) + noise(PP*4))/2.2;
	
	
	incadescence = pow(smoothstep(0.15-0.1*blur,0.15,incadescence)*(1-pow(smoothstep(0.15,0.15+0.85*blur,incadescence),1/2)),12);
	//incadescence = smoothstep(0.2-0.05*blur,0.2,incadescence);
	//display = incadescence;printf("%f\n", incadescence);
	incadescence = incadescence;
	opacity = opacity+incadescence/100;
}

//finally
Oi = Os * opacity;
Ci = Oi * Cs * surfcolor;

}
