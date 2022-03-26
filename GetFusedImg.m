function FusedImg    = GetFusedImg(LatentImgs)

    NumberOfImages = length(LatentImgs);  
    %% Read the input images
    for i = 1:NumberOfImages
        I(:,:,:,i) = LatentImgs{i};
    end
    %% Fuse
    FusedImg = GradientFusion(I);
end