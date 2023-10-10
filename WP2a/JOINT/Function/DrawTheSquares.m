function [FinalSquare, squareStuff] = DrawTheSquares(Size, ScreenStuff, xi)

xi = xi/1.15;
%squareStuff.Xpos = [(ScreenStuff.rect(3)+xi)*0.25 (ScreenStuff.rect(3)+xi)*0.25 (ScreenStuff.rect(3)-xi)*0.75 (ScreenStuff.rect(3)-xi)*0.75];
squareStuff.Xpos = [(ScreenStuff.rect(3)*0.1)+xi (ScreenStuff.rect(3)*0.1)+xi (ScreenStuff.rect(3)*0.9)-xi (ScreenStuff.rect(3)*0.9)-xi]; %0.8 0.2
squareStuff.Ypos = [ScreenStuff.rect(4)*0.1 ScreenStuff.rect(4)*0.9 ScreenStuff.rect(4)*0.1 ScreenStuff.rect(4)*0.9];
squareStuff.Num = length(squareStuff.Xpos);

FinalSquare = nan(4,3);
for sq = 1:squareStuff.Num
FinalSquare(:,sq) = CenterRectOnPointd(Size, squareStuff.Xpos(sq), squareStuff.Ypos(sq));
end

end
