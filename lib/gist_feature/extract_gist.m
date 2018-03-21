function [feat, x, y, wid, hgt] = extract_gist(img, c)
%
% Copyright Aditya Khosla http://mit.edu/khosla
%
% Please cite this paper if you use this code in your publication:
%   A. Khosla, J. Xiao, A. Torralba, A. Oliva
%   Memorability of Image Regions
%   Advances in Neural Information Processing Systems (NIPS) 2012
%

if(~exist('c', 'var'))
  c = conf();
end

feature = 'gist';
p = c.feature_config.(feature);
feat = LMgist(img, [], p);
x = []; y=[]; wid=[]; hgt=[];
% end
% 
% 
% extract_gist('C:/Users/fy2232/Downloads/feature-extraction-master/images/train/0001.jpg')
% extract_gist('C:\Users\fy2232\Downloads\feature-extraction-master\images\train\0001.jpg')