# GFMEF
Source code for "Ghosting-Free Multi-Exposure Image Fusion in Gradient Domain"

This package is a MATLAB implementation of the HDR reconstruction algorithm described in:

K Ram Prabhakar and R. Venkatesh Babu "Ghosting-free multi-exposure image fusion in gradient domain", ICASSP, 2016. 

## Overview
This algorithm takes in a set of three low dynamic range images at different exposures (in .jpg or .png format) and produces an HDR image in .hdr format.  In our system, the HDR image is always aligned to the image with the middle  exposure. The code was written in MATLAB 2015b, and tested on Windows 7.

## Running test code
1. Compile test images in a folder
2. Simply open `demo.m` in MATLAB and run it
3. Locate the folder with input images in the UI prompt

## Citation
When citing this work, you should use the following Bibtex:

    @inproceedings{prabhakar2016ghosting,
      title={Ghosting-free multi-exposure image fusion in gradient domain},
      author={Prabhakar, K Ram and Babu, R Venkatesh},
      booktitle={IEEE international conference on acoustics, speech and signal processing (ICASSP)},
      pages={1766--1770},
      year={2016}
    }
