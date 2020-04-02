function sds = texture_computation(image, neighborhood_size)
    if nargin < 2
        %valeur type donné par le papier de recherche
        neighborhood_size = 5;
    end
    amt_to_pad = (neighborhood_size - 1) / 2;
    [y, x] = size(image);
    sds = zeros([y, x]);
    %on met une marge à l'image afin que chaque pixel de cette dernière ai
    %un voisinage
    padded = padarray(image, [amt_to_pad, amt_to_pad]);
    for i = amt_to_pad+1:y+2
        for j = amt_to_pad+1:x+2
            region = padded(i-2:i+2, j-2:j+2);
            %la texture associée au pixel est donnée par l'écart type entre
            %des valeurs de son voisinage
            sd = std(region(:));
            sds(i-2, j-2) = sd;
        end
    end
end