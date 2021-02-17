function [X] = analysis_filter_rows(X,rows,columns,row_offset,column_offset,h,g)
N = rows;
global delay
global filter_taps
for column = column_offset+1:columns+column_offset
    for n=1:delay-1
        x1(n)=X(delay-1-n+row_offset+1,column);
    end
    for n=1:N
        x1(n+delay-1) = X(n+row_offset,column);
    end
    for n=N+1:N+delay-1
        x1(n+delay-1) = X(2*N-n-2+row_offset,column);
    end
    for n=1:N+2*(delay-1)
        x2(n) = x1(n);
    end
    for m = 1:2:N
        sum = 0.0;
        for n= m-filter_taps:m-1
            sum = sum + x1(n+filter_taps)*h(m-n);%Convolve
        end
        z1(m) = sum;
    end
    for m = 2:2:N
        sum = 0.0;
        for n= m-filter_taps:m-1
            sum = sum + x1(n+filter_taps)*g(m-n);     %Convolve
        end
        z2(m) = sum;
    end    
%/* decimate and write back low-frequency result */    
    for row = 1:rows/2
        X(row+row_offset,column) = z1(row*2-1);
    end
    
%/* decimate and write back high-frequency result */
    for row = 1:rows/2
       X(row+row_offset+rows/2,column) = z2(row*2); 
    end
end

        