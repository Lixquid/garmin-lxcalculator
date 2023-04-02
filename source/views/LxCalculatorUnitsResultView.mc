import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorUnitsResultView extends View {
    (:initialized)
    private var _from as String;
    (:initialized)
    private var _to as String;

    function initialize(from as String, to as String) {
        View.initialize();
        _from = from;
        _to = to;
    }

    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.UnitsResult(dc));
        (View.findDrawableById("From") as Text).setText(_from);
        (View.findDrawableById("To") as Text).setText(_to);
    }
}
