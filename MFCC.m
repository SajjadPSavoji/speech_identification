function [mfcc] = MFCC(sound , FS , N , M)
%this function extracts sound featuers using mel frequency cepstrum
%coefficients
% N is block length and M is offset of statrintg points of blocks
L=size(sound);
L=L(1);
number_of_blocks=floor((L-(N-M))/M);
blocks=zeros(N,number_of_blocks);
%% frame blocking , windowing and power spectrum
for i=1:number_of_blocks
    blocks(:,i) = abs(fft(sound( (i-1)*M +1 : (i-1)*M + N,1) .* hamming(N))).^2;
end
%% half of power spectrum
blocks=blocks(1:N/2,:);
%% mel spectrum coefficients and cepstrum
p=20;
filters=melfb(p,N-1,FS);
filters=filters.';
mel_coefs=zeros(p,number_of_blocks);
for i=1:number_of_blocks
    for j=1:p
        mel_coefs(j,i)=log10(sum(blocks(:,i).*filters(:,j)));
    end
end
%% DCT inverse
mfcc=zeros(p,number_of_blocks);
for i=1:number_of_blocks
    mfcc(:,i)=idct(mel_coefs(:,i));
end
%% modify mfcc matrix to have 100 middle frames
desire_no_blocks=100; % can be changed
exess=number_of_blocks - desire_no_blocks;
mfcc=mfcc(:,floor(exess/2):end - exess +floor(exess/2) -1);

%% modify mfccs to have values frome indices 2 throgh 13 of each frame
index_start=2; %can be changed 
index_end=13;  %can be changed
mfcc=mfcc(index_start:index_end,:);

