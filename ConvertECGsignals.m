clc
clear
close all
%%
% Load signals
for i = 1:243
load(strcat('1 (',num2str(i),').mat')); 
y1 = val(1,:); % the vector in the mat file
f=1000;
T = 1/f;
N = length(y1);
ls = size(y1);
t = (0 : N-1)/f;
y1new = y1(8001:10000);
% ax = axis; axis([ax(1:2) -3.2 3.2])
t2 = (0 : length (y1new)-1)/f;
fig = figure;
plot(y1new)
axis off
print(fig,num2str(i),'-dpng')

end
close all