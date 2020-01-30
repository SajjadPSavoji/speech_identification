function [yp] = iterative_intp(y,m,F0,Fs,N)
%this function impliments the iterative compensatation of interpolation
%distortion
sum = ones(1,length(y));
for i=1:N
    sum=sum + En(y,m,F0,Fs,i);
end
yp=sum.*y;
end

