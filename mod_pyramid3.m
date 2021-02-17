function [X] = mod_pyramid3(image,set2zero)
    Y = imread(image); %imshow(Y);
    Y = mat2gray(Y,[0,255]); %imshow(Y);
    global h1;    global h2;
    global g1;    global g2;
    global global_rows; global global_columns; global filter_taps;
    global delay;
    rows = global_rows;columns = global_columns;
    h1n = h1;h2n = h2;g2n=g2;g1n = g1;
    %Divide the image into 4 equal-sized subbands */
    row_offset = 0;
    column_offset = 0;
    X = analysis_filter_rows(Y,rows,columns,row_offset,column_offset,h1n,g1n);    
    row_offset = 0;
    column_offset = 0;    
    X = analysis_filter_columns(X,rows/2,columns,row_offset,column_offset,h1n,g1n);   
    row_offset = rows/2;
    column_offset = 0;
    X = analysis_filter_columns(X,rows/2,columns,row_offset,column_offset,h1n,g1n);   %imshow(X(1:end/2,1:end/2))
    %/* Further divide each quarter-sized subband into 4 equal-sized subbands */
    %/* filter upper left-hand corner */
    row_offset = 0;
    column_offset = 0;
    X = analysis_filter_rows(X,rows/2,columns/2,row_offset,column_offset,h1n,g1n);    
    row_offset = 0;
    column_offset = 0;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);    
    row_offset = rows/4;
    column_offset = 0;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     %imshow(X)

    %/* Filter upper right-hand corner */
    row_offset = 0;
    column_offset = columns/2;
    X = analysis_filter_rows(X,rows/2,columns/2,row_offset,column_offset,h1n,g1n);       

    row_offset = 0;
    column_offset = columns/2;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     
    row_offset = rows/4;
    column_offset = columns/2;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     %imshow(X)
    
    %/* Filter lower left-hand corner */
    row_offset = rows/2;
    column_offset = 0;
    X = analysis_filter_rows(X,rows/2,columns/2,row_offset,column_offset,h1n,g1n);        

    row_offset = rows/2;
    column_offset = 0;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     
    
    row_offset = rows/2 + rows/4;
    column_offset = 0;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     %imshow(X)

    %/* Filter lower right-hand corner */
    row_offset = rows/2;
    column_offset = columns/2;
    X = analysis_filter_rows(X,rows/2,columns/2,row_offset,column_offset,h1n,g1n);       %imshow(X)

    row_offset = rows/2;
    column_offset = columns/2;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     %imshow(X)
    row_offset = rows/2 + rows/4;
    column_offset = columns/2;
    X = analysis_filter_columns(X,rows/4,columns/2,row_offset,column_offset,h1n,g1n);     %imshow(X)

    %/* Further divide lower left-hand subband into 4 subbands creating 19 subbands */

  row_offset = 0;
  column_offset = 0;
  X = analysis_filter_rows(X,rows/4,columns/4,row_offset,column_offset,h1n,g1n);              %imshow(X)

  row_offset = 0;
  column_offset = 0;
  X = analysis_filter_columns(X,rows/8,columns/4,row_offset,column_offset,h1n,g1n);       
  row_offset = rows/8;
  column_offset = 0;
  X = analysis_filter_columns(X,rows/8,columns/4,row_offset,column_offset,h1n,g1n);       %imshow(X)
    
    %/* Further divide lower left-hand subband into 4 subbands creating 22 subbands */

  row_offset = 0;
  column_offset = 0;
  X = analysis_filter_rows(X,rows/8,columns/8,row_offset,column_offset,h1n,g1n);          

  row_offset = 0;
  column_offset = 0;
  X = analysis_filter_columns(X,rows/16,columns/8,row_offset,column_offset,h1n,g1n);      
  row_offset = rows/16;
  column_offset = 0;
  X = analysis_filter_columns(X,rows/16,columns/8,row_offset,column_offset,h1n,g1n);      %imshow(X)

    %/* Synthesis filter upper left-hand corner (from 22 subbands) */
  row_offset = 0;
  column_offset = 0;
  X = synthesis_filter_columns(X,rows/16,columns/16,row_offset,column_offset,h2n,g2n);        
  row_offset = rows/16;
  column_offset = 0;
  X = synthesis_filter_columns(X,rows/16,columns/16,row_offset,column_offset,h2n,g2n);

  row_offset = 0;
  column_offset = 0;
  X = synthesis_filter_rows2(X,rows/16,columns/8,row_offset,column_offset,h2n,g2n);   %imshow(X)


    %/* Synthesis filter upper left-hand corner (from 19 subbands) */
  row_offset = 0;
  column_offset = 0;
  X = synthesis_filter_columns(X,rows/8,columns/8,row_offset,column_offset,h2n,g2n);
  row_offset = rows/8;
  column_offset = 0;
  X = synthesis_filter_columns(X,rows/8,columns/8,row_offset,column_offset,h2n,g2n);

  row_offset = 0;
  column_offset = 0;
  X = synthesis_filter_rows2(X,rows/8,columns/4,row_offset,column_offset,h2n,g2n);    %imshow(X)


    %/* Synthesis filter upper left-hand corner (from 16 subbands) */
     if set2zero == 15
         figure,imshow(mat2gray(X(1:end/4,1:end/4)))
         title('mod_pyramid:15 subband set to 0')
     else
        row_offset = 0;
        column_offset = 0;
        X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)
        row_offset = rows/4;
        column_offset = 0;
        X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)

        row_offset = 0;
        column_offset = 0;
        X = synthesis_filter_rows2(X,rows/4,columns/2,row_offset,column_offset,h2n,g2n);    %imshow(X)

        %/* Synthesis filter upper right-hand corner */
          row_offset = 0;
          column_offset = columns/2;
          X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)
          row_offset = rows/4;
          column_offset = columns/2;
          X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)
          row_offset = 0;
          column_offset = columns/2;
          if set2zero == 10
              figure,imshow(mat2gray(X(1:end/2,1:end/2)))
              title('mod pyramid:10 subband set to 0')
          else
              X = synthesis_filter_rows2(X,rows/4,columns/2,row_offset,column_offset,h2n,g2n);    %imshow(X)

                %/* Synthesis filter lower left-hand corner */
              row_offset = rows/2;
              column_offset = 0;
              X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)
              row_offset = rows/2 + rows/4;
              column_offset = 0;
              X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)

              row_offset = rows/2;
              column_offset = 0;
              X = synthesis_filter_rows2(X,rows/4,columns/2,row_offset,column_offset,h2n,g2n);    %imshow(X)

                %/* Synthesis filter lower right-hand corner */
              row_offset = rows/2;
              column_offset = columns/2;
              X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)
              row_offset = rows/2 + rows/4;
              column_offset = columns/2;
              X = synthesis_filter_columns(X,rows/4,columns/4,row_offset,column_offset,h2n,g2n);  %imshow(X)

              row_offset = rows/2;
              column_offset = columns/2;
              X = synthesis_filter_rows2(X,rows/4,columns/2,row_offset,column_offset,h2n,g2n);    %imshow(X)
              % /* Synthesis filter entire image */
            if set2zero == 3
                figure,imshow(mat2gray(X(1:end/2,1:end/2)))
                title('mod pyramid:3 subband set to 0')
            else
              row_offset = 0;
              column_offset = 0;
              X = synthesis_filter_columns(X,rows/2,columns/2,row_offset,column_offset,h2n,g2n);  %imshow(X)
                  row_offset = rows/2;
                  column_offset = 0;
                  X = synthesis_filter_columns(X,rows/2,columns/2,row_offset,column_offset,h2n,g2n);  %imshow(X)

              row_offset = 0;
              column_offset = 0;
              X = synthesis_filter_rows2(X,rows/2,columns,row_offset,column_offset,h2n,g2n);
              %X = double(X);
              figure,imshow(mat2gray(X))
              title('mod pyramid:no subband set to 0')
            end
          end
     end



   
    



