function [X] = synthesis_filter_columns(X,rows,columns,row_offset,column_offset,h,g)
N = columns*2;%temp = zeros(1000,1);%x1 = zeros(1000,1)
global delay
global filter_taps
for row = row_offset+1:rows+row_offset
    for n=1:floor(delay/2)
        x1(n) = X(row,floor(delay/2)-n+column_offset+1);
    end
    for n=1:columns
        x1(n+floor(delay/2)) = X(row,n+column_offset);
    end
    for n=1+columns:columns+floor(delay/2)
        x1(n+floor(delay/2)) = X(row,2*columns-n-1+column_offset);
    end
    for n=1:columns+delay-1
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
            sum = sum+temp(n+filter_taps)*h(m-n+1);         %Convolve
        end
        z1(m+1) = sum;
    end    
    %----%
    for n=1:floor(delay/2)
        x2(n) = X(row,floor(delay/2)-n+column_offset+1);
    end
    for n=1:columns
        x2(n+floor(delay/2)) = X(row,n+column_offset);
    end
    for n=1+columns:columns+floor(delay/2)
        x2(n+floor(delay/2)) = X(row,2*columns-n-1+column_offset);
    end
    for n=1:columns+delay-1
        temp(2*n) = 0.0;
        temp(2*n-1) = x2(n);
    end
    %-----%
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
    for column = 1:N
        X(row,column+column_offset) = z1(column) + z2(column);
    end
end