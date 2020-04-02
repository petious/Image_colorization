function ctarget = color_transfert_swatches(best_match,ctarget_swatches, gtarget)

ctarget = NaN(size(gtarget,1), size(gtarget,2), 3);

k=0;

csource_2=0;
csource_3=0;

%afin de correspondre à la concaténation des valeurs de luminance et de
%texture des swatches, on concatène de la même façon les valeurs en lab des
%swatches

for i=1:size(ctarget_swatches,2)

   current_ctarget = ctarget_swatches{1,i};
   
   current_csource_2 = reshape(current_ctarget(:,:,2)', size(current_ctarget,1)*size(current_ctarget,2), 1);
   current_csource_3 = reshape(current_ctarget(:,:,3)', size(current_ctarget,1)*size(current_ctarget,2), 1);

    if(csource_2==0)
        csource_2 = current_csource_2;
        csource_3 =current_csource_3;
    else
        csource_2 = vertcat(csource_2, current_csource_2);
        csource_3 = vertcat(csource_3, current_csource_3);
        
    end
end


for i=1:size(gtarget,1)
    for j=1:size(gtarget,2)
        k=k+1;
        ctarget(i,j,2) = csource_2(best_match(k));
        ctarget(i,j,3) = csource_3(best_match(k));
        
    end
end

ctarget(:,:,1) = gtarget*100;
end

        