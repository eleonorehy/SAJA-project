function [FinalSquare, squareStuff] = DrawTheSquaresTer(Size, ScreenStuff, xi)

xi = xi/1.15;

% squareStuff.Xpos = [(ScreenStuff.rect(3)+xi)*0.25 (ScreenStuff.rect(3)+xi)*0.25 (ScreenStuff.rect(3)-xi)*0.75 (ScreenStuff.rect(3)-xi)*0.75];
squareStuff.Xpos = [(ScreenStuff.rect(3)*0.1)+xi (ScreenStuff.rect(3)*0.1)+xi (ScreenStuff.rect(3)*0.9)-xi (ScreenStuff.rect(3)*0.9)-xi];
squareStuff.Ypos = [(ScreenStuff.rect(4)*0.4) (ScreenStuff.rect(4)*0.6) (ScreenStuff.rect(4)*0.4) (ScreenStuff.rect(4)*0.6)];
squareStuff.Num = length(squareStuff.Xpos);

FinalSquare = nan(4,3);
for sq = 1:squareStuff.Num
FinalSquare(:,sq) = CenterRectOnPointd(Size, squareStuff.Xpos(sq), squareStuff.Ypos(sq));
end

end
