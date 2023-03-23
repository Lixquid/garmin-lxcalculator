import Toybox.Graphics;
import Toybox.WatchUi;

class LxCalculatorGridDrawable extends Drawable {
    // TODO: Make this draw to a buffered bitmap and use that instead

    function initialize() {
        Drawable.initialize({
            :identifier => "Grid"
        });
    }

    function draw(dc as Dc) {
        var w = dc.getWidth();
        var h = dc.getHeight();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(w*.1, h*.1, w*.9, h*.1);
        dc.drawLine(w*.9, h*.1, w*.9, h*.9);
        dc.drawLine(w*.1, h*.9, w*.9, h*.9);
        dc.drawLine(w*.1, h*.1, w*.1, h*.9);
        dc.drawLine(w*.1, h*.25, w*.9, h*.25);
        dc.drawLine(w*.3666, h*.25, w*.3666, h*.9);
        dc.drawLine(w*.6332, h*.25, w*.6332, h*.9);
        dc.drawLine(w*.1, h*.4125, w*.9, h*.4125);
        dc.drawLine(w*.1, h*.575, w*.9, h*.575);
        dc.drawLine(w*.1, h*.7375, w*.9, h*.7375);
    }
}
