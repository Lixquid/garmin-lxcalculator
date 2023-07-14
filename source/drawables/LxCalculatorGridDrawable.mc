import Toybox.Graphics;
import Toybox.WatchUi;

class LxCalculatorGridDrawable extends Drawable {
    // TODO: Make this draw to a buffered bitmap and use that instead

    function initialize() {
        Drawable.initialize({
            :identifier => "Grid",
        });
    }

    function draw(dc as Dc) {
        var w = dc.getWidth();
        var h = dc.getHeight();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(w * 0.1, h * 0.1, w * 0.9, h * 0.1);
        dc.drawLine(w * 0.9, h * 0.1, w * 0.9, h * 0.9);
        dc.drawLine(w * 0.1, h * 0.9, w * 0.9, h * 0.9);
        dc.drawLine(w * 0.1, h * 0.1, w * 0.1, h * 0.9);
        dc.drawLine(w * 0.1, h * 0.25, w * 0.9, h * 0.25);
        dc.drawLine(w * 0.3666, h * 0.25, w * 0.3666, h * 0.9);
        dc.drawLine(w * 0.6332, h * 0.25, w * 0.6332, h * 0.9);
        dc.drawLine(w * 0.1, h * 0.4125, w * 0.9, h * 0.4125);
        dc.drawLine(w * 0.1, h * 0.575, w * 0.9, h * 0.575);
        dc.drawLine(w * 0.1, h * 0.7375, w * 0.9, h * 0.7375);
    }
}
