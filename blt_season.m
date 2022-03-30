clear;clc
ncdisp('E:\MATLAB\观测BLT数据\blt_DTm02_c1m_reg2.0.nc');  %1961-2008
lon=ncread('E:\MATLAB\观测BLT数据\blt_DTm02_c1m_reg2.0.nc','lon');
lat=ncread('E:\MATLAB\观测BLT数据\blt_DTm02_c1m_reg2.0.nc','lat');  %从小到大
blt_ob=ncread('E:\MATLAB\观测BLT数据\blt_DTm02_c1m_reg2.0.nc','blt');
blt_ob(blt_ob<-235.4371)=NaN;
blt_ob(blt_ob>1769.1351)=NaN;
blt_ob(blt_ob==-9999)=NaN;
% blt_ob(blt_ob<0)=0;
blt122 = nanmean(cat(3,blt_ob(:,:,1:2),blt_ob(:,:,12)),3);
blt35 = nanmean(blt_ob(:,:,3:5),3);
blt68 = nanmean(blt_ob(:,:,6:8),3);
blt911 = nanmean(blt_ob(:,:,9:11),3);
blt1220=cat(1,blt122(21:56,42:63,:));
blt350=cat(1,blt35(21:56,42:63,:));
blt680=cat(1,blt68(21:56,42:63,:));
blt9110=cat(1,blt911(21:56,42:63,:));

blt = double(cat(3,blt1220,blt350,blt680,blt9110));

%%
fname = {'Dec-Jan-Feb','Mar-Apr-May','Jun-Jul-Aug','Sep-Oct-Nov'};
lon0 = lon(21:56); lat0 = lat(42:63);
[lons,lats]=meshgrid(lon0,lat0);
sz=get(0,'screensize');
figure('outerposition',sz);
ax = tight_subplot(2, 2,[.01 .045],[.25 .01],[.2 .18]); 
m_proj('miller','long',[40 110],'lat',[-5 30]);
for i = 1:4
    axes(ax(i));
    hold on    
    m_contourf(lons,lats,blt(:,:,i)',20,'lines','no');
    m_coast('patch',[0.7 0.7 0.7],'edgecolor','black');
    m_grid('xtick',40:15:110,'ytick',0:10:30,'linest','none','fontsize',22,'linewidth',1.5);
    WhiteBlueGreenYellowRed
    caxis([-5 55]);
    title(cell2mat(fname(i)),'fontsize',24);
end
    h = colorbar;
    set(h,'ticks',[-5:5:55],'ticklength',0.042,'linewidth',2,'fontsize',22); 
    set(h,'position',[0.835 0.292 0.015 0.654]);
