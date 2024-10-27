clear
clf
%Physics constants
g = 9.81;

%trebuchet constants
m1 = 1000;
m2 = 10;
l1 = 1;
l2 = 4;

%initial values
a0 = 0;
v0 = 0;
theta(1) = deg2rad(225); % Note:0 degrees is arm  point straight up

%moment of intertia
momOfInert = m1*l1^2 + m2*l2^2; 

%initial torque
torque = g*sin(theta)*(m1*l1-m2*l2);

%acceleration, velocity
angA(1) = 0;
angV(1) = 0;

i = 1;
h = 0.01;

for t = 0:h:4
    angA(i + 1) = (-g*sin(theta(i))*(m1*l1-m2*l2))/momOfInert;
    
    angV(i + 1) = angV(i) + (angA(i + 1)*h);
    
    theta(i + 1) = theta(i) + (angV(i + 1)*h);
   
  
    plot(sin(theta)*l2+2.44, cos(theta)*l2 + 4.29, 'xb',0,0,'.',sin(theta+pi)*l1+2.44, cos(theta+pi)*l1 + 4.29,'xr');
    axis equal
    axis([-8 8 -8 8])
    
    c(i) = cos(theta(i))*l2 + 4.29;
    d(i) = sin(theta(i))*l2 + 2.44;
    drawnow;
    
    i = i + 1;
    
    if(theta(i) >= deg2rad(322))
        break;
    end
    
end

c(i) = cos(theta(i))*l2 + 4.29;
d(i) = sin(theta(i))*l2 + 2.44;
% plot(yline(-3))
 hold on
%clf
hold off

%Throwing motion variables
initial_velocity = l2 * angV(i);
teta = deg2rad(38);
height = 7.46;
start_x = -2.44;
i = 1;

for t2 = 0:h:15
    b(i) = initial_velocity*sin(teta)*t2 - (g*t2^2)/2 + height;
    a(i) = initial_velocity*cos(teta)*t2;
    if(b(i) <= 0)
        break;
    end
    
    i = i + 1;
end
plot(a,b, 'm.')
axis equal
hold on

%Air resistance variables
C = 1/2;
p = 1.225;
A = pi*(0.3^2);

xVelocity = initial_velocity * cos(teta);
yVelocity = initial_velocity * sin(teta);

y(1) = cos(theta(72))*l2 + 4.29;
x(1) = 0;
i = 1;
for t2 = 0:h:15
    
    if (yVelocity > 0)
        yDrag = (C*p*A*(yVelocity^2))/2;
        yAcceleration = (-yDrag)/m2 - g;
    else 
        yDrag = (C*p*A*(yVelocity^2))/2;
        yAcceleration = (yDrag)/m2 - g;
    end

    xDrag = (C*p*A*(xVelocity^2))/2;
    xAcceleration = -xDrag/m2;

    yVelocity = yVelocity + yAcceleration*h;
    xVelocity = xVelocity + xAcceleration*h;

    y(i+1) = y(i) + yVelocity*h;
    x(i+1) = x(i) + xVelocity*h;

    if(y(i+1) <= 0)
        break;
    end
    i = i + 1;
end

plot(x,y, 'bx')
hold on
plot(d,c,'ro')
hold on
plot([-2 50], [0 0])
title("Projektilens position")
legend("Kastparabel", "Kastparabel med luftmotstånd","Position i kastarm", 'Orientation', 'horizontal')
XY1 = [d; c];
XY2 = [x; y];
file = fopen('xy_keyframes.txt','w');
fprintf(file,'%f#%f\n',XY1);
fprintf(file,'%f#%f\n',XY2);
fclose(file);
theta = -(theta - deg2rad(90));

file = fopen('theta_keyframes.txt','w');
fprintf(file,'%f\n',theta);
fclose(file);



