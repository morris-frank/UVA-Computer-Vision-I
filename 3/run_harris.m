person = imread('person_toy/00000001.jpg');
pingpong = imread('pingpong/0000.jpeg');

[H, r, c] = harris_corner_detector(person, 0.0000001);
export_fig(1, 'harris_markers_person.png', '-native');

[H, r, c] = harris_corner_detector(pingpong, 0.0000001);
export_fig(1, 'harris_markers_pingpong.png', '-native');

person_45 = imrotate(person, 45, 'crop');
[H, r, c] = harris_corner_detector(person_45, 0.0000001);
export_fig(1, 'harris_markers_person_45.png', '-native');


person_90 = imrotate(person, 90, 'crop');
[H, r, c] = harris_corner_detector(person_90, 0.0000001);
export_fig(1, 'harris_markers_person_90.png', '-native');
