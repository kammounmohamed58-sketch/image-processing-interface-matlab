clc;
close all;
clear;
A = imread('LENA.BMP');
% imshow(A);
% [hauteur,largeur]= size(A);
% fprintf('Taille de l image: %d * %d  \n',hauteur,largeur)
% angle=input(' entrer l angle de rotation d?sir?: \n');
% 
% A_rot= imrotate(A,angle);
% imshow(A_rot);
% c=input('entrer la valeur de pixel desir? :  \n');
% frequence = sum(A(:)==c);
% fprintf('le nobre d occurence de la valeur %d dans l image est: %d \n',c ,frequence);
% img_inverse =255 - A;
% imshow(img_inverse);
% ligne_debut =input('donner la ligne de debut de bloc:  \n');
% ligne_fin =input('donner la ligne de fin de bloc: \n');
% colonne_debut =input('donner la colonne de debut de bloc:   \n');
% colonne_fin =input('donner la colonne de fin de bloc:  \n');
% bloc=A(ligne_debut:ligne_fin,colonne_debut:colonne_fin, :);
% background =255*ones(256,256,'uint8');
% 
% background(ligne_debut:ligne_fin,colonne_debut:colonne_fin, :)= bloc;
% 
% imshow(background);

% 
% Partie 2
% imhist(A);
% ligne=input('donner la ligne qui tu veux faire avec le profil d intensit?: \n');
% 
% colonne=input('donner la colonne qui tu veux faire avec le profil d intensit?: \n');
% i=A(ligne,:);
% figure;
% subplot(1,2,1);
% 
% plot(i)
% title(sprintf('Profil dintensite -Ligne %d',ligne));
% 
% col=A(colonne,:);
% subplot(1,2,2);
% plot(i);
% 
% title(sprintf('Profil dintensite -colonne %d',colonne));


% seuil = input('Entrer la valeur de seuil pour le scanning (0-255) : ');
%  
% image_scannee = (A == seuil);
% 
% figure;
% subplot(1,2,1)
% imshow(A)
% title('Image Originale');
% 
% subplot(1,2,2)
% imshow(image_scannee)
% title(['Image Scannée (Seuil: ', num2str(seuil), ')']);
% pause;   % empêche la fermeture automatique
% % partie3:
% 
d_salt = input('Entrer la coefficient de bruit Salt & Pepper (ex: 0.05) : ');
A_salt = imnoise(A, 'salt & pepper', d_salt);

var_gauss = input('Entrer la coefficient de bruit Gaussien (ex: 0.01) : ');
A_gauss = imnoise(A, 'gaussian', 0, var_gauss); % 0 est la moyenne (mean)

var_speckle = input('Entrer la coefficient de bruit Speckle (ex: 0.04) : ');
A_speckle = imnoise(A, 'speckle', var_speckle);

figure;
subplot(2,2,1); imshow(A); title('Image Originale');
subplot(2,2,2); imshow(A_salt); title(['Salt & Pepper (d=', num2str(d_salt), ')']);
subplot(2,2,3); imshow(A_gauss); title(['Gaussien (v=', num2str(var_gauss), ')']);
subplot(2,2,4); imshow(A_speckle); title(['Speckle (v=', num2str(var_speckle), ')']);

% --- FILTRAGE SIMPLIFIÉ ---

%  On applique les deux filtres sur l'image bruitée (ex: A_salt)
img_filtre_moy = imfilter(A_salt, ones(3,3)/9); %ones(3,3)/9 définit la zone ET la règle de calcul (faire la moyenne).
%On veut que la somme totale soit égale à 1 pour ne pas changer la luminosité de l'image.
img_filtre_med = medfilt2(A_salt, [3 3]);  %[3 3] définit juste la zone de recherche.
%Plus ces chiffres sont grands (ex: 5,5 ou 7,7), plus le bruit disparaît, mais plus l'image devient floue.
psnr_moy = psnr(img_filtre_moy, A);
psnr_med = psnr(img_filtre_med, A);

figure;
subplot(1,2,1); imshow(img_filtre_moy);
title(['Moyenneur (PSNR: ', num2str(psnr_moy), ' dB)']);

subplot(1,2,2); imshow(img_filtre_med);
title(['Médian (PSNR: ', num2str(psnr_med), ' dB)']);

img_sobel = edge(A, 'sobel');
img_roberts = edge(A, 'roberts');

figure;
subplot(1,3,1); 
imshow(img_sobel); 
title('Contours : Filtre de Sobel');

subplot(1,3,2); 
imshow(img_roberts); 
title('Contours : Filtre de Roberts');
%FILTRE DE LAPLACAN
h1=fspecial('laplacian',0.2);
G2=imfilter(A,h1);
subplot(1,3,3)
imshow(uint8(G2))
title(' LAPLACIAN')


