# Image-Denoising using Subband Wavelet Transform SWT

1. Biorthogonal Filters:
Wavelet transform was used in order to obtain a set of biorthogonal filters’ co-efficient which are used to convolve with the noisy image.The filter co-efficients were as given in [1] from Table II.
2. Symmetric Extension Method:
The boundary condition is dealt with using the symmetric extension method which generates a whole sample for odd length filters, which is the case here. The method is as per [2] proposed by Martucci.
3. Image Denoising
The original image is decomposed into several subbands (16 for pyramid and 22 for modified pyramid).These images were then reconstructed with the inverse SWT using the reversed bi-orthogonal filters. The images were reconstructed with the smallest band to the largest band.
![Lena_noisy_FFT](https://user-images.githubusercontent.com/32479901/128588428-d491a239-1024-411b-b0e0-514aaa869dbc.png)
![Lena_6sb_0_FFT](https://user-images.githubusercontent.com/32479901/128588551-2cd25ef8-c736-493c-a149-299e029d8a22.png)

References
1. M. Antonini, M. Barlaud, P. Mathieu and I. Daubechies, "Image coding using wavelet transform," in IEEE Transactions on Image Processing, vol. 1, no. 2, pp. 205-220, April 1992, doi: 10.1109/83.136597.
2. Martucci, S. (1991). Signal extension and noncausal filtering for subband coding of images. 
