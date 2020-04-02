function ctarget = color_transfert(best_match,csource, gtarget)

ctarget = NaN(size(gtarget,1), size(gtarget,2), 3);
k=0;
%vectorisation des matrices de csource
csource_2 = reshape(csource(:,:,2)', size(csource,1)*size(csource,2), 1);
csource_3 = reshape(csource(:,:,3)', size(csource,1)*size(csource,2), 1);

for i=1:size(gtarget,1)
    for j=1:size(gtarget,2)
        k=k+1;
        ctarget(i,j,2) = csource_2(best_match(k));
        ctarget(i,j,3) = csource_3(best_match(k));
        
    end
end

%on garde la luminance de l'image à coloriser
ctarget(:,:,1) = gtarget*100;
end