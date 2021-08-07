# Image-Denoising using Subband Wavelet Transform SWT

1. Biorthogonal Filters:
Wavelet transform was used in order to obtain a set of biorthogonal filters’ co-efficient which are used to convolve with the noisy image.The filter co-efficients were as given in [1] from Table II.
2. Symmetric Extension Method:
The boundary condition is dealt with using the symmetric extension method which generates a whole sample for odd length filters, which is the case here. The method is as per [2] proposed by Martucci.
3. Image Denoising
The original image is decomposed into several subbands (16 for pyramid and 22 for modified pyramid).These images were then reconstructed with the inverse SWT using the reversed bi-orthogonal filters. The images were reconstructed with the smallest band to the largest band.

References
1. M. Antonini, M. Barlaud, P. Mathieu and I. Daubechies, "Image coding using wavelet transform," in IEEE Transactions on Image Processing, vol. 1, no. 2, pp. 205-220, April 1992, doi: 10.1109/83.136597.
2. Martucci, S. (1991). Signal extension and noncausal filtering for subband coding of images. 
