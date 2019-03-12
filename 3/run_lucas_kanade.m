synth1 = imread('./synth1.pgm');
synth2 = imread('./synth2.pgm');

sphere1 = imread('./sphere1.ppm');
sphere2 = imread('./sphere2.ppm');

[Vx, Vy] = lucas_kanade(sphere1, sphere2);
export_fig(1, 'lucas_kanade_sphere.png')


[Vx, Vy] = lucas_kanade(synth1, synth2);
export_fig(1, 'lucas_kanade_synth.png')