x = 3
y= 117
k =0

for i = x:y
   if mod(i,15)==0
		k = k+15
    elseif mod(i,3)==0
		k = k+3
    elseif mod(i,5)==0
		k = k+5
    
	else
		k = k+1
	end
end

k