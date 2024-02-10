function DPCM()

%close graph windows
close all;

%variables
load('source.mat');
p=10;
N=3;
min_value = -3.5;
max_value = 3.5;

%length of input signal x (t=x)
%t = t(1:5000);
%t = t(5001:10000);
%t = t(10001:15000);
%t = t(15001:20000);
%t = t(0:20000);
x_length = length(t);
disp('Length of x:')
disp(x_length);

%autocorrelation matrix of dimension pxp
R = zeros(p,p);

%autocorrelation vector of dimension px1
r = zeros(p,1);

%calculate vector r
for i=1:p
    temp_sum=0;
    for n=p+1:x_length
       temp_sum = temp_sum + t(n)*t(n-i);
    end
    r(i) = temp_sum * 1/(x_length-p);
end

%calculate matrix R
for i=1:p
    for j=1:p
        temp_sum_R = 0;
        for n=p+1:x_length
           temp_sum_R = temp_sum_R + t(n-j)*t(n-i);
        end
        R(i,j) = temp_sum_R * 1/(x_length-p);
    end
end


%calculate vector a
%set N=8, min_value=-2, max_value=2 to compute the values
%using my_quantizer
a = R\r;
for i=1:p
    a(i) = my_quantizer(a(i),8,-2,2);   
end

%encoder
%quantized_difference = y^
%predicted_value = y'
memory = zeros(p,1);
y = zeros(x_length,1);
quantized_difference = zeros(x_length,1);
predicted_value = 0;
for i=1:x_length
    y(i) = t(i) - predicted_value;
    quantized_difference(i) = my_quantizer(y(i),N,min_value,max_value);
    y_hat_toned = quantized_difference(i) + predicted_value;
    memory = [y_hat_toned;memory(1:p-1)];  
    predicted_value = a'*memory;                       
end

%decoder
%predicted_value = y'
memory = zeros(p,1);
predicted_value = 0;
y_out = zeros(x_length,1);
for i=1:x_length
    y_out(i) = quantized_difference(i) + predicted_value;
    memory = [y_out(i);memory(1:p-1)];
    predicted_value = a'*memory;
end

%------------------------------Question 2
%plot x,y in the same figure
%initial input signal t
%error prediction signal y 
%p = 5 -> N = 1,2,3
%p = 6 -> N = 1,2,3

%uncomment from here for question 2

%plot(t) 
%hold
%plot(y) 
%xlabel('Input signal x') 
%ylabel('Error Prediction Signal y') 

%uncomment till here for question 2

% -----------------------------Question 3
%Median square error and values of a, then diagram of E
%p = 5:10 -> N=1,2,3
%Gather the E values for one by one p firstly by running code
%for p=5:1:10 and N=1:1:3

%uncomment from here for question 3

%E = mean(y.^2); 
%fprintf('Median Square Error (E): %f\n', E);
%N_values = [1 2 3];

%E_p5 = [7.4862 4.6948 3.4948];
%E_p6 = [7.4008 4.6464 3.4945];
%E_p7 = [5.3527 3.4288 2.4718];
%E_p8 = [4.6890 2.8736 2.1051];
%E_p9 = [4.8479 2.8717 2.0766];
%E_p10 = [4.5177 2.6438 1.9343];

%plot error for each p
%hold on;
%plot1 = plot(N_values,E_p5);
%plot2 = plot(N_values,E_p6);
%plot3 = plot(N_values,E_p7);
%plot4 = plot(N_values,E_p8);
%plot5 = plot(N_values,E_p9);
%plot6 = plot(N_values,E_p10);
%set(plot1,'Marker','square');
%set(plot2,'Marker','square');
%set(plot3,'Marker','square');
%set(plot4,'Marker','square');
%set(plot5,'Marker','square');
%set(plot6,'Marker','square');
%hold off;
%xlabel('N') 
%ylabel('E(Y^2)') 
%legend('E(Y^2) for p=5','E(Y^2) for p=6','E(Y^2) for p=7','E(Y^2) for p=8','E(Y^2) for p=9', 'E(Y^2) for p=10')

%uncomment till here for question 3

% -----------------------------Question 4
%Plot x and y_out in the same figure
%p = 5 -> N = 1,2,3
%p = 10 -> N = 1,2,3
%plot the first 200 elements of input signal x
%plot the first 200 elements of the decoding output y_out

%uncomment from here for question 4

%plot (t(1:200))     
%hold
%plot (y_out(1:200)) 
%xlabel('Input signal x') 
%ylabel('Decoded Output Signal y') 

%uncomment till here for question 4
end
