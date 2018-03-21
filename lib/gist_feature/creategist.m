gistfea = zeros(3000,512);
for i=1:3000
    i
    %jpgdir = ['../data/train/images/'  sprintf('%04d',i)  '.jpg'];
    jpgdir = ['C:/Users/fy2232/Downloads/feature-extraction-master/images/train/'  sprintf('%04d',i)  '.jpg'];
    jpgfile = imread(jpgdir);
    gistfea(i,:) = extract_gist(jpgfile);
end
csvwrite('gistfea.csv',gistfea)
csvwrite('gistfea.dat',gistfea)