clear
close all
%resolution
x_res=0.1;
y_res=0.1;
z_res=2.5;
%range
x_range=[0,70];
y_range=[-40,40];
z_range=[-2.5,0];
pc_dir="D:\data\object\training\velodyne\000008.bin";
fid=fopen(pc_dir,'rb');
velo = fread(fid,[4 inf],'single')';
fclose(fid);
x =velo(:, 1);
y =velo(:, 2);
z =velo(:, 3);
r= velo(:, 4);
points=numel(velo(:,1));
%figure,pcshow(velo(:,1:3),velo(:,4))
new_velo=zeros(points,4);
j=1;
%crop
for i=1:points
    if  velo(i,1)<x_range(2) && velo(i,1)>x_range(1) &&velo(i,2)<y_range(2)&&velo(i,2)>y_range(1)&&velo(i,3)>z_range(1)&&velo(i,3)<z_range(2)
        new_velo(j,:)=velo(i,:);
        j=j+1;
    end
end
%change Z
new_velo=new_velo(1:j,:);
new_velo(:,3)=new_velo(:,3)+2.5;

%figure,pcshow(new_velo(:,1:3),new_velo(:,4))
%initialize
x_max=(x_range(2)-x_range(1))/x_res;
y_max=(y_range(2)-y_range(1))/y_res;
z_max=(z_range(2)-z_range(1))/z_res;
cell_ini=zeros(x_max+1,y_max+1,z_max+1);
%convert to BEV
x_bev=round(new_velo(:,1)/x_res);
y_bev=round(new_velo(:,2)/y_res);

%grid
%figure,pcshow([x_bev, y_bev, z_bev])
 %for k=1:numel(new_velo(:,1))
     


