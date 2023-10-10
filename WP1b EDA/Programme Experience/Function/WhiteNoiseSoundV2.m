sca% function WhiteNoiseSoundV2


sr = 44100;
d = 1;
  
noise = (rand(1, round(sr*d))*2)-1;
sound(noise,sr);


% end

 