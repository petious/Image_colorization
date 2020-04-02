function remapped = luminance_remap(source, target)
    source_luminance = source(:,:,1) / 100;
    mu_a = mean(source_luminance(:));
    mu_b = mean(target(:));
    sigma_a = std(source_luminance(:));
    sigma_b = std(target(:));
    %formule générale de luminance remap
    remapped = sigma_b / sigma_a * (source_luminance - mu_a) + mu_b;
end