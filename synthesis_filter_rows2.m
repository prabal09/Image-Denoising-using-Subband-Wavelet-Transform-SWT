function [X] = synthesis_filter_rows2(X,rows,columns,row_offset,column_offset,h,g)
N = rows*2;
global delay
global filter_taps
for column = column_offset+1:columns+column_offset
    for n=1:floor(delay/2)
        x1(n) = X(floor(delay/2)-n+row_offset+1,column);
    end
    for n=1:rows
        x1(n+floor(delay/2)) = X(n+row_offset,column);
    end
    for n=1+rows:rows+floor(delay/2)
        x1(n+floor(delay/2)) = X(2*rows-n-1+row_offset,column);
    end
    for n=1:rows+delay-1
        temp(2*n) = 0.0;
        temp(2*n-1) = x1(n);
    end
    for m=1:2:N
        sum = 0.0;
        for n= m+1-filter_taps:2:m-1
            sum = sum+temp(n+filter_taps+1)*h(m-n);          %convolve
        end
        z1(m) = sum;
        
        sum = 0.0;
        for n = m+2-filter_taps:2:m-1
            sum = sum+temp(n+filter_taps)*h(m+1-n);         %Convolve
        end
        z1(m+1) = sum;
    end    
    for n=1:floor(delay/2)
        x2(n) = X(floor(delay/2)-n+row_offset+1,column);
    end
    for n=1:rows
        x2(n+floor(delay/2)) = X(n+row_offset,column);
    end
    for n=1+rows:rows+floor(delay/2)
        x2(n+floor(delay/2)) = X(2*rows-n-1+row_offset,column);
    end
    for n=1:rows+delay-1
        temp(2*n) = 0.0;
        temp(2*n-1) = x2(n);
    end
    for m=1:2:N
        sum = 0.0;
        for n= m+1-filter_taps:2:m-1
            sum = sum+temp(n+filter_taps)*g(m-n);          %convolve
        end
        z2(m) = sum;
        
        sum = 0.0;
        for n = m+1-filter_taps:2:m-1
            sum = sum+temp(n+filter_taps)*g(m+1-n-1);         %Convolve
        end
        z2(m+1) = sum;
    end
    for row = 1:N
        X(row+row_offset,column) = z1(row) + z2(row);
    end
end