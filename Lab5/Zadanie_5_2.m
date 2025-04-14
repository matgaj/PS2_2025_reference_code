% Mateusz Gajewski, Kamil Bochenek

n_samples = 50;
fs = n_samples;
t = linspace(0,1-1/fs,fs); % wektor czasu dla sygnału
x = sin(2*pi*17.3*t); % sygnał sin o f = 17.3 Hz; da przeciek dla fs = 50 Hz
f = linspace(0,fs-fs/n_samples,n_samples); % wektor częstotliwości dla wykresu dft
% x = x + rand(1,n_samples); % ew. dodanie szumu


figure
tiledlayout("vertical")

% widać przeciek, ale też wyraźne maksimum w 17 Hz
S = fft(x,fs); 
nexttile
stem(f,abs(S))
title("rectwin")

% dalsze częstotliwości mają dużo mniejsze amplitudy, ale maksimum jest
% mniej wyraźne
x1 = x .* hamming(n_samples)'; % mnożenie oken Hamminga
S = fft(x1);
nexttile
stem(f,abs(S))
title("hamming")

% jeszcze większe rozrzucenie wokół bliskich częstotliwości
x1 = x .* blackman(n_samples)'; % mnożenie oknem Blackmana
S = fft(x1);
nexttile
stem(f,abs(S))
title("blackman")

[x, fs] = audioread("356188__mtg__violin-a-major.wav");
figure
% okno prostokątne jako punkt odniesienia
spectrogram(x,rectwin(1000),'yaxis');

% okno Hamminga; wyraźniejsze prążki częstotliwości
spectrogram(x,hamming(1000),'yaxis');

% okno Blackmana; jeszcze lepiej widać prążki (zwłaszcza w wyższych
% częstotliwościach) ale są one grubsze
spectrogram(x,blackman(1000),'yaxis');

% z ciekawości, okno Blackmana, ale 256, nie 1000 próbek długości
% duża utrata rozdzielczości na osi częstotliwości
spectrogram(x,blackman(256),'yaxis');
