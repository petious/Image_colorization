function best_match = find_best_match(gtarget_luminance, gtarget_texture, gsource_luminance, gsource_texture);

gtarget_luminance = reshape(gtarget_luminance', size(gtarget_luminance,1)*size(gtarget_luminance,2),1);
gtarget_texture = reshape(gtarget_texture', size(gtarget_texture,1)*size(gtarget_texture,2),1);

gsource_luminance = reshape(gsource_luminance', size(gsource_luminance,1)*size(gsource_luminance,2),1);
gsource_texture = reshape(gsource_texture', size(gsource_texture,1)*size(gsource_texture,2),1);

best_match = NaN(size(gtarget_luminance,1)*size(gtarget_luminance,2),1);

for i=1:(size(gtarget_luminance,1)*size(gtarget_luminance,2))
    tic
    best_match(i) = best_match_value(gtarget_luminance(i), gtarget_texture(i), gsource_luminance,gsource_texture);
    toc
    i
end
    
    
    
