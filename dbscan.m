clear 
close all
load obs_points.mat
obs_points;
points_number=numel(obs_points(:,1));
index=1:points_number;
obs_points=[obs_points,index'];
% distance
eps=0.3;
% min points
minpts=100;     %distinguish by distance (x in kitti coordinate)
%neighborhood range and init
neighbor=zeros(points_number,5,2);
neighbor(:,:,1)=[obs_points(:,1:3,:)-eps,obs_points(:,4:5,:)];
neighbor(:,:,2)=[obs_points(:,1:3,:)+eps,obs_points(:,4:5,:)];

clusters={};   
n=0;
%find all core object
for i=1:points_number
    
    cro=obs_points(obs_points(:,1)>neighbor(i,1,1)&obs_points(:,2)>neighbor(i,2,1)&obs_points(:,3)>neighbor(i,3,1)...
        &obs_points(:,1)<neighbor(i,1,2)&obs_points(:,2)<neighbor(i,2,2)&obs_points(:,3)<neighbor(i,3,2),:);
    if numel(cro(:,1))>minpts
        n=n+1;
        clusters(n)={cro};
        core_object(n)=obs_points(i,5);
    end
        
end
%generate cluster
k=0;
visited(1:numel(clusters))=1;
while sum(visited)~=0
Q=clusters{1};
while numel(set)==1
   q= Q{1}(1,:);
   j=q(5);
   cro_cur=obs_points(obs_points(:,1)>neighbor(j,1,1)&obs_points(:,2)>neighbor(j,2,1)&obs_points(:,3)>neighbor(j,3,1)...
        &obs_points(:,1)<neighbor(j,1,2)&obs_points(:,2)<neighbor(j,2,2)&obs_points(:,3)<neighbor(j,3,2),:);
     if numel(cro_cur(:,1))>minpts
        n=n+1;
        clusters(n)={cro};
        sets(n)=i;
    end
    
    
    
    
    
    
end 
end 
    









