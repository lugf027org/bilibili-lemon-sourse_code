function y = get_wave(tone, rythm, keynote_change, keynote_type, up_down)
% get_wave： 
%   tone: 取哪个音节;  rythm: 节拍数; keynote_change:升降调8度; keynote_type:当前基调; up_down:音节升降

    Fs = 8192;
    keynote_B = 493; % 开始的节奏降E
    keynote_Ab = 415; % 中间变为降A
    
    rythm = 1.25 * rythm;
    tones_normal = [1, 3, 5, 6, 8, 10, 12]; % 1-7 到 C D E F G A B映射

    if nargin == 5  % 有改变基调&可能有升降调&可能有音节升降
        if keynote_type == 'A'
            keynote = keynote_Ab;
        elseif keynote_type == 'B'
            keynote = keynote_B;
        end
        keynote = keynote * keynote_change;
    end
    
    if tone == 0    % 停顿
        tone = 13;
    else
        tone = tones_normal(tone);
    end
    
    freqs = [1, 1.059, 1.122, 1.189, 1.260, 1.335, 1.414, 1.498, 1.587, 1.682, 1.782, 1.888, 0] .* keynote.*(1.059^up_down);
    x = linspace(0, 2*pi*rythm, floor(Fs*rythm));
    y = sin(freqs(tone) * x) .* (1 - x/(2*pi*rythm));
end

% F(C),1.059F(C#/Db),1.122F(D),1.189F(D#/Eb),1.260F(E),1.335F(F),
% 1.414F(F#/Gb),1.498F(G),1.587F(G#/Ab),1.682F(A),1.782F(A#/Bb),1.888F(B)
%
%     C4   #C4  D4   #D4  E4   F4   #F4  G4   #G4  A4   #A4  B4   C5
% 4: [261, 277, 293, 311, 329, 349, 369, 391, 415, 440, 466, 493, 523]
%[523,587,659,698,783,880,988];
% 5: [554, 587, 622, 659, 698, 739, 783, 830, 880, ]
%
%[1047,1175,1319,1397,1568,1760,1976];
%
%[2093,2349,2637,2794,3136,3520,3951];
    %tones_up = [2, 4, 6, 7, 9, 11, 1]; % #1, #2, #3, #4, #5, #6, #7(需要升度)
    %tones_down = [12, 2, 4, 5, 7, 9, 11]; % not b1, b7, b6, b5, b4, b3, b2, but b1(需要降度), b2, b3, b4, b5, b6, b7
