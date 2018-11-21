clear
close all
%resolution
tic;
x_res=0.1;
y_res=0.1;
res=0.3;
%range
x_range=[0,70];
y_range=[-40,40];
z_range=[-5,2];
pc_dir="D:\data\KITTI\object\training\velodyne\000008.bin";
fid=fopen(pc_dir,'rb');
velo = fread(fid,[4 inf],'single')';
fclose(fid);
x =velo(:, 1);
y =velo(:, 2);
z =velo(:, 3);
r= velo(:, 4);
points=numel(velo(:,1));
ind=1:points;
velo=[velo,ind'];
%figure,pcshow(velo(:,1:3),velo(:,4))
new_velo=zeros(points,5);
j=1;
%crop
for i=1:points
    if  velo(i,1)<x_range(2) && velo(i,1)>x_range(1) &&velo(i,2)<y_range(2)&&velo(i,2)>y_range(1)&&velo(i,3)>z_range(1)&&velo(i,3)<z_range(2)
        new_velo(j,:)=velo(i,:);
        j=j+1;
    end
end
%change positive
new_velo=new_velo(1:j,:);
new_velo(:,3)=new_velo(:,3)+abs(z_range(1));
new_velo(:,2)=new_velo(:,2)+abs(y_range(1));
new_velo(:,1)=new_velo(:,1);
%figure,pcshow(new_velo(:,1:3),new_velo(:,4))
%initialize
x_max=(x_range(2)-x_range(1))/x_res;
y_max=(y_range(2)-y_range(1))/y_res;
cell_max=zeros(x_max+1,y_max+1);
cell_min=zeros(x_max+1,y_max+1)+abs(z_range(1));
%convert to BEV
x_bev=round(new_velo(:,1)/x_res)+1;
y_bev=round(new_velo(:,2)/y_res)+1;
grid_velo=[x_bev,y_bev,new_velo(:,3:5)];
%grid and find obstacle points
%figure,pcshow([x_bev, y_bev, z_bev])
 for k=1:numel(grid_velo(:,1))
     if new_velo(k,3)>cell_max(grid_velo(k,1),grid_velo(k,2))
     cell_max(grid_velo(k,1),grid_velo(k,2))=grid_velo(k,3);
     end
     
    if grid_velo(k,3)<cell_min(grid_velo(k,1),grid_velo(k,2))
     cell_min(grid_velo(k,1),grid_velo(k,2))=grid_velo(k,3);
    end
 end
cell_res=cell_max-cell_min;
[m,n]=find(cell_res(:,:)>res);
%inverse BEV
ind_obs=[];
for p=1:numel(m)
for q=1:numel(grid_velo(:,1))
    if grid_velo(q,1)==m(p)&&grid_velo(q,2)==n(p)
        ind_obs=[ind_obs,grid_velo(q,5)];
    end
end
end
obs_points_num=numel(ind_obs);
obs_points=zeros(obs_points_num,5);
for t=1:obs_points_num
    obs_points(t,:)=velo(ind_obs(t),:);
end
figure,pcshow(obs_points(:,1:3),obs_points(:,4))   
obs_points=obs_points(:,1:4);      
%toc
%%% one person pcshow
% per_points=obs_points(obs_points(:,1)<11.76&obs_points(:,1)>11.36&obs_points(:,2)>-3&obs_points(:,2)<-2.5,:);
% figure,pcshow(per_points(:,1:3),per_points(:,4)) 