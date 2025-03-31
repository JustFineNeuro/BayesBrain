area='pMD'
load('2_H_Pac_pMD.mat')
if strcmp(area,'pMD')
    win_shift=30;
else
    win_shift=75;
end
sub_start=0;
[psths] = cut_psth(psths,win_shift,sub_start);

tmpd=sqrt([((((vars{i}.self_pos{1}(:,1)-960)/960)-((vars{i}.prey_pos{1}(:,1)-960)/960)).^2)+((((vars{i}.self_pos{1}(:,2)-540)/540)-((vars{i}.prey_pos{1}(:,2)-540)/540)).^2)])


self_spd=[];
prey_spd=[];
prey_dist=[];
for i=1:length(vars)
if vars{i}.numPrey==1
if vars{i}.numNPCs==1
self_spd=[self_spd;sqrt((gradient((vars{i}.self_pos{1}(:,1)-960)/960)*60).^2+(gradient((vars{i}.self_pos{1}(:,2)-540)/540)*60).^2)];
prey_spd=[prey_spd;sqrt((gradient((vars{i}.prey_pos{1}(:,1)-960)/960)*60).^2+(gradient((vars{i}.prey_pos{1}(:,2)-540)/540)*60).^2)];
tmpd=sqrt([((((vars{i}.self_pos{1}(:,1)-960)/960)-((vars{i}.prey_pos{1}(:,1)-960)/960)).^2)+((((vars{i}.self_pos{1}(:,2)-540)/540)-((vars{i}.prey_pos{1}(:,2)-540)/540)).^2)]);
prey_dist=[prey_dist;tmpd];
end
end
end

psth=[]
for i=1:length(vars)
if vars{i}.numPrey==1
if vars{i}.numNPCs==1
psth=[psth;psths{i}];
end
end
end

%Just choose a few
n1=psth(:,6);
n2=psth(:,8);
n3=psth(:,9);
n4=psth(:,11);
n5=psth(:,12);

rewardVal=[]
for i=1:length(vars)
    if vars{i}.numPrey==1
        if vars{i}.numNPCs==1
            rewardVal=[rewardVal;repmat(vars{i}.valNPCs,size(vars{i}.self_pos{1},1),1)];
        end
    end
end

rewardVal=discretize(rewardVal,5);




data.n1=n1;
data.n2=n2;
data.n3=n3;
data.n4=n4;
data.n5=n5;

data.prey_spd=prey_spd;
data.self_spd=self_spd;
data.prey_dist=prey_dist;
data.rewardVal=rewardVal;
data.psth=psth;
save('/Users/user/PycharmProjects/PacManMain/GLM/exampleData/PMD.mat','data')


