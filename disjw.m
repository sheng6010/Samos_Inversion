function  [JJ,WW,Ang21]=disjw(Jd,Wd,Dis,Angle)       
% [JJ,WW,Ang21]=disjw(Jd,Wd,Dis,Angle)
% 此函?已知???距Dis(以米??位)、与正北?角Angle（以°??位）和一?的??度（Jd，Wd），
% ?算另一?的??度（JJ，WW）123
 
e=2.718282;
re=6371000;      %
a=6378245;
a=6371009;

e2=0.0067385241;
 
jd=Jd*pi/180;
wd=Wd*pi/180;
angle=Angle*pi/180;
 
A=sqrt(1+e2*cos(wd)^4);
B=sqrt(1+e2*cos(wd)^2);
C=sqrt(1+e2);
cgm=Dis*B^2/(a*C);
temp_x=B*cos(wd)-tan(cgm)*sin(wd)*cos(angle);
%    if(temp_x<0.001)
%    temp_x=0.001;
jj=jd+(1/A)*atan(A*tan(cgm)*sin(angle)/temp_x);
W=A*(jj-jd)/2;
x=cos(angle);
y=(1/A)*sin(wd)*sin(angle)*tan(W);
z=sin(cgm)*(x-y);
D=0.5*asin(z);
ww=wd+2*D*(B-(3.0/2.0)*e2*D*sin(2*wd+(4.0/3.0)*B*D));
E=cos(cgm)*(tan(cgm)*tan(wd)-B*cos(angle));
F=-B*sin(angle);
ang21=atan2(F,E);
if ang21<0
    ang21=ang21+2*pi;
end
JJ=jj*180/pi;
WW=ww*180/pi;
Ang21=ang21*180/pi;
  