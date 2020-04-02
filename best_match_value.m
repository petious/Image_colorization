function best_match = best_match_value(val_luminance, val_texture, gsource_luminance,gsource_texture)

for i=1:length(gsource_luminance)
    
vector_match(i)= (0.5 * ((val_luminance-gsource_luminance(i))^2) ) + (0.5 * ((val_texture-gsource_texture(i))^2) );
   
end



[a, best_match] = min(vector_match);

end