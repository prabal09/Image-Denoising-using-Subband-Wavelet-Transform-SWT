function [X] = analysis_filter_columns(X,rows,columns,row_offset,column_offset,h,g)
N = columns;
global delay
global filter_taps
for row = row_offset+1:rows+row_offset
    for n=1:delay-1
        x1(n) = X(row,delay-1-n+column_offset+1);
    end
    for n=1:N
        x1(n+delay-1) = X(row,n+column_offset);
    end
    for n = N+1:N+delay-1
        x1(n+delay-1) = X(row,2*N-n-2+column_offset);
    end
    for n=1:N+2*(delay-1)
        x2(n) = x1(n);
    end
    
    for m=1:2:N
        sum = 0.0;
        for n=m-filter_taps:m-1
            sum = sum + x1(n+filter_taps)*h(m-n);       %Convolve
        end
        z1(m) = sum;
    end
    for m=2:2:N
        sum = 0.0;
        for n=m-filter_taps:m-1
            sum = sum+x2(n+filter_taps)*g(m-n);           %Convolve
        end
        z2(m) = sum;
    end
    %    /* decimate and write back low-frequency result */
    for column = 1:columns/2
        X(row,column+column_offset) = z1(column*2-1);
    end
    %   /* decimate and write back high-frequency result */
    for column=1:columns/2
        X(row,column+column_offset+columns/2) = z2(column*2);
    end
end
        
        
        
        