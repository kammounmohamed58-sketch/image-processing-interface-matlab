clc
clear
close all

%PARTIE1
%AFFICHAGE ET LECTURE DE L'IMAGE ET SA TAILLE

img=imread('LENA.BMP');
subplot(4,4,1)
imshow(img)
title('LENA')
%s=size(img)
[~,~] = size(img);

%ROTATION DE L'IMAGE D'UN ANGLE DONNE "A"
A=60;
imgROT = imrotate(img,A);
subplot(4,4,2)
imshow(imgROT)
title('LENA60')

%OCCURENCE DU NIVEAU DU GRIS "NG"
ng=70;
occ=0;

for i = 1:256
    for j = 1:256
        if  img(i,j)==ng
            occ=occ+1;
           
        end
    end
end        
fprintf(' occ= %d.\n',occ);

%INVERSION DE COULEUR

imgINV=256-img;
subplot(4,4,3)
imshow(imgINV)
title('LENA-1')

%IMAGE BLANCHE
L=256;
C=256;
img_w = uint8(255 * ones(L, C));

%EXTRACTION D'UN BLOC
LB_debut=70;
LB_fin=200;
CB_debut=70;
CB_fin=200;

bloc = img(LB_debut:LB_fin, CB_debut:CB_fin);
img_w(LB_debut:LB_fin, CB_debut:CB_fin) = bloc;
subplot(4,4,4)
imshow(img_w)
title('LENAB')

%PARTIE2
%HISTOGRAMME:OCCURENCE DES NIVEAUX DE GRIS  
subplot(4,4,5)
imhist(img)
title('HISTOGRAMME')

%profil d'intensité
numL=130;
profil = img(numL, :);    
num_colonnes = 1:length(profil);

subplot(4,4,6)
plot( profil);
grid on;
xlabel('Numéro des colonnes');
ylabel('Niveau de gris');
ylim([0 255]);
title('PROFIL D"INTENSITE')

%scanning
niveau=7;
lenaScan=(img==niveau);
subplot(4,4,7)
imshow(lenaScan)
title('IMAGE SCANE')

%PARTIE3
%AJOUTER_BRUIT
%BRUIT_GAUSSIEN
lenaG=imnoise(img,'gaussian',0,0.01);
subplot(4,4,8)
imshow(lenaG)
title('BRUIT GAUSSIAN')

%BRUIT_SALTPEPPER
lenaSP=imnoise(img,'salt & pepper',0.02);
subplot(4,4,9)
imshow(lenaSP)
title('BRUIT SALT&PEPPER')

%BRUIT_SPECKLE
lenaSPC=imnoise(img,'speckle',0.04);
subplot(4,4,10)
imshow(lenaSP)
title('SPECKLE')

%FILTRE MOYENNEUR
h = fspecial('average',[3,3]);
img_moyenneur = imfilter(lenaG,h);
subplot(4,4,11)
imshow(img_moyenneur)
title('img moyenneur')

%FILTRE MEDIAN
img_median = medfilt2(lenaSP,[3,3]);
subplot(4,4,12)
imshow(img_median)
title('img median')

%CALCUL PSNR
psnr_value=psnr(img_moyenneur ,img);
if psnr_value<20
    disp('qualité mauvaise')
elseif psnr_value<30
    disp('qualité moyenne')
elseif psnr_value<40
    disp('qualité bonne')
else
    disp('qualité trés bonne')
end

%FILTRAGE PASSE HAUT
%FILTRE DE ROBERT
hx=[1 0;0 -1];
hy=[0 1;-1 0];

gx=imfilter(double(img),hx);
gy=imfilter(double(img),hy);
G=sqrt(gx.^2 +gy.^2);
subplot(4,4,13)
imshow(uint8(G))
title('img ROBERT')

%FILTRE DE SOBEl

%gx1=imfilter(double(img),fspecial('sobel'));
%gy1=imfilter(double(img),fspecial('sobel'));
%G1=sqrt(gx1.^2 +gy1.^2);
G1=edge(img , 'sobel')
subplot(4,4,14)
imshow(G)
title('img SOBEL')

%FILTRE DE LAPLACAN
h1=fspecial('laplacian',0.2);
G2=imfilter(img,h1);
subplot(4,4,15)
imshow(uint8(G2))
title('img LAPLACIAN')
