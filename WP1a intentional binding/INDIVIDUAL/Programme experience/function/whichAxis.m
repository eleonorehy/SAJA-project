function [] = whichAxis(Key, dot, pixelsPerPress, axis)
if axis == 1
    if keyCode(Key.left)
        dot.Xpos = dot.Xpos - pixelsPerPress;
    elseif keyCode(Key.right)
        dot.Xpos = dot.Xpos + pixelsPerPress;
    elseif keyCode(Key.up)
        dot.Ypos = dot.Ypos;
    elseif keyCode(Key.down)
        dot.Ypos = dot.Ypos;
    end
elseif axis == 2 
    if keyCode(Key.left)
        dot.Xpos = dot.Xpos;
    elseif keyCode(Key.right)
        dot.Xpos = dot.Xpos;
    elseif keyCode(Key.up)
        dot.Ypos = dot.Ypos - pixelsPerPress;
    elseif keyCode(Key.down)
        dot.Ypos = dot.Ypos + pixelsPerPress;
    end
end
end