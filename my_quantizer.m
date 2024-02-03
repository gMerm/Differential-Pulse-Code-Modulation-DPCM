function y_out = my_quantizer(y,N,min_value,max_value)

%y belongs in [min_value, max_value]
%if y less than the lower bound, I set it equal to the lower bound value
%if y is greater than the upper bound, I set it equal to the upper bound value
if y < min_value
    y = min_value;
end
if y > max_value
    y = max_value;
end

%quantization step D
%(-οο, α1], (α1, α1+Δ)...
D = max_value/(2^(N-1));

%centers of the areas
%the largest positive quantization level corresponds to 1
%center(1) = max_val - D/2
%center(2^N) = min_val + D/2
centers = zeros(2^N,1);
centers(1) = max_value - D/2;
centers(2^N) = min_value + D/2;
for i=2:2^N-1
   centers(i) = centers(i-1) - D; 
end

%find where the sample y belongs (in which area) based on its value
index = find((y <= centers + D/2) & (y >= centers - D/2), 1);

%quantified sample
y_out = centers(index);

end
