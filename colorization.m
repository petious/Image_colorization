function colorization(color_image,grey_image)


prompt = 'Do you want to use the swatch method ? yes=1, no=0\n';
swatch_method = str2num(input(prompt,'s'));

%conversion en lab
csource = imread(color_image);
csource = im2double(csource);
csource_lab = rgb2lab(csource);

gsource = rgb2gray(csource);
gsource_lab = rgb2lab(csource);


gtarget = imread(grey_image);
gtarget = im2double(gtarget);

if ndims(gtarget) == 3
    gtarget = rgb2gray(gtarget);
end

gtarget_lab=gtarget;


figure(1)
subplot(211)
imshow(csource);
title('color image');
subplot(212)
imshow(gtarget);
title('greyscale image');


if swatch_method
    
    %Méthode avec swatch
    [source_swatches, target_swatches] = switch_computation(csource,gtarget);
    close 1;
    
    ctarget_luminance = 0;
    
    for i=1:size(source_swatches,2)
        current_csource = source_swatches{i};
        current_csource_lab = rgb2lab(current_csource);
        
        current_gsource = rgb2gray(current_csource);
        current_gsource_lab = rgb2lab(current_csource);
        
        current_gtarget = target_swatches{i};
        
        if ndims(current_gtarget) == 3
            current_gtarget = rgb2gray(current_gtarget);
        end
        
        current_csource_luminance = luminance_remap(current_csource,current_gtarget);
        current_csource_lab(:,:,1)=current_csource_luminance;
        
        current_gsource_luminance = luminance_remap(current_gsource_lab,current_gtarget);
        current_gtarget_luminance = current_gtarget;
        
        voisinage = 5;
        current_gsource_texture = texture_computation(current_gsource, voisinage);
        current_gtarget_texture = texture_computation(current_gtarget, voisinage);
        
        best_match = find_best_match(current_gtarget_luminance, current_gtarget_texture, current_gsource_luminance, current_gsource_texture);
        
        %colorisation du swatch courant, et stockage
        ctarget_swatches{i} = color_transfert(best_match, current_csource_lab,current_gtarget);
        temp_ctarget = ctarget_swatches{i};
        
        %conversion en noir et blanc du swatch courant, extraction des
        %informations de luminance et de texture, puis vectorisation
        temp_ctarget = rgb2gray(lab2rgb(temp_ctarget));
        current_ctarget_luminance = temp_ctarget;
        current_ctarget_luminance = reshape(current_ctarget_luminance', size(current_ctarget_luminance,1)*size(current_ctarget_luminance,2),1);
        current_ctarget_texture = texture_computation(temp_ctarget, voisinage);
        current_ctarget_texture = reshape(current_ctarget_texture', size(current_ctarget_texture,1)*size(current_ctarget_texture,2),1);
        
        %concaténation des valeurs de luminance et de texture de tous les
        %swatches pour traitement ultérieur
        if(ctarget_luminance ==0)
            ctarget_luminance =current_ctarget_luminance;
            ctarget_texture =current_ctarget_texture;
        else
            ctarget_luminance = vertcat(ctarget_luminance, current_ctarget_luminance);
            ctarget_texture = vertcat(ctarget_texture, current_ctarget_texture);
            
        end
        
        
    end
    
    
    gtarget_luminance = gtarget;
    gtarget_texture = texture_computation(gtarget, voisinage);
    
    %grace à la concaténation précédente, on peut directement appeler
    %find_best_match sur l'ensemble des swatches (leurs valeurs étant
    %toutes contenues dans un vecteur)
    best_match = find_best_match(gtarget_luminance, gtarget_texture, ctarget_luminance, ctarget_texture);
    
    %colorisation finale
    ctarget = color_transfert_swatches(best_match,ctarget_swatches, gtarget);
    
    ctarget = lab2rgb(ctarget);
    
    figure(1)
    subplot(311)
    imshow(csource);
    title('color image');
    subplot(312)
    imshow(gtarget);
    title('greyscale image');
    subplot(313)
    imshow(ctarget);
    title('colorization result');
    
    
else
    
    %Méthode sans swatch
    
    close 1;
    
    csource_luminance = luminance_remap(csource_lab,gtarget_lab);
    csource_lab(:,:,1)=csource_luminance;
    
    gsource_luminance = luminance_remap(gsource_lab,gtarget_lab);
    
    gtarget_luminance = gtarget;
    
    voisinage = 5;
    gsource_texture = texture_computation(gsource, voisinage);
    gtarget_texture = texture_computation(gtarget, voisinage);
    
    best_match = find_best_match(gtarget_luminance, gtarget_texture, gsource_luminance, gsource_texture);
    
    ctarget = color_transfert(best_match, csource_lab,gtarget);
    ctarget = lab2rgb(ctarget);
    
    figure(1)
    subplot(311)
    imshow(csource);
    title('color image');
    subplot(312)
    imshow(gtarget);
    title('greyscale image');
    subplot(313)
    imshow(ctarget);
    title('colorization result');
end

end