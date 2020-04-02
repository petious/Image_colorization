# Image_colorization
Matlab program to colorize greyscale images, using a colorized image as a reference.

The principal function is `colorization.m` ; for example :`colorization(‘tree_c.jpg’,’forest_g.jpg’))` will attempt to colorize the image `'forest_g.jpg'` using `'tree_c.jpg'` as a reference. The program will then ask the user if he wants to use the "swatches method", via the command line. The colorized image is then saved in the same folder.

The details of this project, such as the papers references and general algorithm architecture are explained in [Rapport](https://github.com/petious/Image_colorization/blob/master/Rapport.pdf) (in french)




