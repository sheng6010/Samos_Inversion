
load('samos_30s.mat')
lon=srtm30plus.longitude;
lat=srtm30plus.latitude;
z= double(srtm30plus.z);
[lon,lat] = meshgrid(lon,lat);
in=inpolygon(lon,lat,[25.75 25.75 27.75 27.75 25.75],[37.25 38.25 38.25 37.25 37.25]);
lon=reshape(lon(in),120,240); 
lat=reshape(lat(in),120,240);
z=reshape(z(in),120,240);

eq=load('catalog.txt');
% Date  Time  Lat. Long. Depth  Magnitude
%            (N,7) (E,8)  (Km)     (ML)
in=inpolygon(eq(:,8),eq(:,7),[25.75 25.75 27.75 27.75 25.75],[37.25 38.25 38.25 37.25 37.25]);
x=eq(in,8);
y=eq(in,7);
dep=-eq(in,9);


%plot3(x,y,dep,'.','markeredgecolor',[.7 .7 .7])


path='/Users/yu-shengsun/Documents/Diego/Slip_Inv/';

project='samos_d5';


subplot(2,1,1)
plot_fault([path 'run/creat_' project '_fault.py'],[0,.6,1])
hold on 
contour(lon,lat,z,[0 0],'k','LineWidth',1.25);

view([0 90])
axis equal tight
axis([25.75 27.75 37.25 38.25 -30 5])
axis([25.75+0.25 27.75-0.25 37.25+0.15 38.25-0.05 -30 5])

box on
ylabel('Latitude')

title(project,'Interpreter','none','fontweight','normal')
ax = gca;
ax.FontSize = 16;
yticks(ax,[37.4 37.8 38.2])

subplot(2,1,2)

plot_fault([path 'run/creat_' project '_fault.py'],[0,.6,1])
hold on 
contour(lon,lat,z,[0 0],'k','LineWidth',1);
z(z<0)=nan;
%mesh(lon(1:2:end,1:2:end),lat(1:2:end,1:2:end),z(1:2:end,1:2:end)./1000,'facecolor','none','edgecolor',[.6 .6 .6])
plot3(lon(:,128),lat(:,128),z(:,128)./1000,'color',[.5 .5 .5],'LineWidth',1)

view([-90 0])
axis equal tight
axis([25.75 27.75 37.25 38.25 -30 3])
axis([25.75+0.25 27.75-0.25 37.25+0.15 38.25-0.05 -30 5])

box on
daspect([1 1 100])
ylabel('Latitude')
zlabel('Depth (km)')

ax = gca;
ax.FontSize = 16;

set(gcf,'PaperPosition',[.3 0 15 15])
print('-dpng',[path '/' project '/fault.png'],'-r300')

close