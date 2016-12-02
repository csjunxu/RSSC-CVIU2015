for j = 1:1:size(Y,3)
for i = 1:1:size(Y,2)
    facename = sprintf('%d%s%d%s',j,'th_face_',i,'.jpg');
    imwrite(uint8(reshape(Y(:,i,j),48,42)),facename,'jpeg');
end
end