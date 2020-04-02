function [source_swatches, target_swatches] = switch_computation(csource,gtarget)


prompt = 'Enter number of swatches\n';
nb_swatch = str2num(input(prompt,'s'));

for i=1:nb_swatch
    subplot(211)
    hold on
    r(i)=imrect();
    subplot(212)
    hold on
    r2(i)=imrect();
end

%close 1;

source_swatches = cell(1,nb_swatch);
target_swatches = cell(1,nb_swatch);

for i=1:nb_swatch
    
    % % Rectangle position is given as [xmin, ymin, width, height]
    pos_r = r(i).getPosition();
    % % Round off so the coordinates can be used as indices
    pos_r = round(pos_r);
    % % Select part of the image
    source_swatch = imcrop(csource, pos_r);
    source_swatches{i} = source_swatch;
    
    pos_r2 = r2(i).getPosition();
    % % Round off so the coordinates can be used as indices
    pos_r2 = round(pos_r2);
    % % Select part of the image
    target_swatch = imcrop(gtarget, pos_r2);
    target_swatches{i} = target_swatch;
    
end

end