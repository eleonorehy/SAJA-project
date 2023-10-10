function [FinalSquare, squareStuff] = DrawTheSquares(Size, ScreenStuff, xi)

xi = xi/2;
% squareStuff.Xpos = [(ScreenStuff.rect(3)+xi)*0.25 (ScreenStuff.rect(3)+xi)*0.25 (ScreenStuff.rect(3)-xi)*0.75 (ScreenStuff.rect(3)-xi)*0.75];
squareStuff.Xpos = [(ScreenStuff.rect(3)*0.2)+xi (ScreenStuff.rect(3)*0.2)+xi (ScreenStuff.rect(3)*0.8)-xi (ScreenStuff.rect(3)*0.8)-xi];
squareStuff.Ypos = [ScreenStuff.rect(4)*0.2 ScreenStuff.rect(4)*0.8 ScreenStuff.rect(4)*0.2 ScreenStuff.rect(4)*0.8];
squareStuff.Num = length(squareStuff.Xpos);

FinalSquare = nan(4,3);
for sq = 1:squareStuff.Num
FinalSquare(:,sq) = CenterRectOnPointd(Size, squareStuff.Xpos(sq), squareStuff.Ypos(sq));
end

end
