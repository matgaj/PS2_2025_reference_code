% Mateusz Gajewski, Kamil Bochenek

% POLECENIE: 
% W ramach zadania wykonaj następujące podzadania: 
% 1.
%   Zapoznaj się z widmami i kształtem okien (przynajmniej prostokątnego,
%   Hamminga, Blackmana w aplikacji windowDesigner). Wektory o długości N
%   zawierające próbki okien można uzyskać za pomocą funkcji dostępnych w
%   Matlabie (rectwin(), hamming(), blackman() itp.).
% 2.
%   Wybierz sygnał o niewielkiej liczbie próbek (N<100), w którego
%   Dyskretnej Transformacie Fouriera (widmie) łatwo zaobserwować zjawisko
%   przecieku. Następnie porównaj je z widmem otrzymanym z sygnału
%   przemnożonego przez  okno (iloczyn Hadamarda - element per element).
%   Pytanie: Jaki wpływ ma zastosowanie okna w tym przypadku?
% 3.
%   Dla sygnału z pliku 356188__mtg__violin-a-major.wav zaprezentuj i
%   porównaj zmiany jakie wprowadzają poszczególne okna aplikowane na ramki
%   podczas obliczania STFT.

clear
close all

n_samples = 50;
fs = n_samples; % dla uproszczenia
t = linspace(0,1-1/fs,fs); % wektor czasu dla sygnału
x = sin(2*pi*17.3*t); % sygnał sin o f = 17.3 Hz; da przeciek dla fs = 50 Hz
f = linspace(0,fs-fs/n_samples,n_samples); % wektor częstotliwości dla wykresu dft
% x = x + rand(1,n_samples); % ew. dodanie szumu


figure
t = tiledlayout("vertical");
xlabel(t,"Częstotliwość [Hz]")
ylabel(t,"Amplituda")
title(t,"Porównanie okien w DFT")

% widać przeciek, ale też wyraźne maksimum w 17 Hz
S = fft(x); 
nexttile
stem(f,abs(S))
title("rectwin")

% dalsze częstotliwości mają dużo mniejsze amplitudy, ale maksimum jest
% mniej wyraźne
x1 = x .* hamming(n_samples)'; % mnożenie oknem Hamminga
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

%%
[x, fs] = audioread("356188__mtg__violin-a-major.wav");
figure
t = tiledlayout("flow");
title(t, "Porównanie okien na spektrogramie")
nexttile
% okno prostokątne; jako punkt odniesienia
spectrogram(x,rectwin(1000),'yaxis');
title("rectwin")
xlim([2e5 4e5])
ylim([0 0.25])


% okno Hamminga; wyraźniejsze prążki częstotliwości
nexttile
spectrogram(x,hamming(1000),'yaxis');
title("hamming")
xlim([2e5 4e5])
ylim([0 0.25])


% okno Blackmana; jeszcze lepiej widać prążki (zwłaszcza w wyższych
% częstotliwościach) ale są one grubsze
nexttile
spectrogram(x,blackman(1000),'yaxis');
title("blackman")
xlim([2e5 4e5])
ylim([0 0.25])

% z ciekawości, okno Blackmana, ale 256, nie 1000 próbek długości
% duża utrata rozdzielczości na osi częstotliwości
nexttile
spectrogram(x,blackman(256),'yaxis');
title("blackman 256")
xlim([2e5 4e5])
ylim([0 0.25])
