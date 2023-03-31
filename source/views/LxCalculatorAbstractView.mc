import Toybox.Attention;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

var lxVibeProfile = [
    new Attention.VibeProfile(25, 50)
];

class LxCalculatorAbstractView extends View {
    protected var _display as TextArea?;
    protected var _logic as LxCalculatorLogic?;

    public var width as Number = 0;
    public var height as Number = 0;

    function initialize(logic as LxCalculatorLogic) {
        View.initialize();
        _logic = logic;
    }

    function onLayout(dc as Dc) {
        _display = View.findDrawableById("Display");
        if (_display != null) {
            _display.setText(_logic.format());
        }
        width = dc.getWidth();
        height = dc.getHeight();
    }

    function onUpdate(dc as Dc) {
        _display.setText(
            _logic.format()
        );
        View.onUpdate(dc);
    }

    function onButton(x as Number, y as Number) {}
    function onPage(direction as LX_DIRECTION) {}
    function onConfirm() {
        _logic.calculate({ :addToHistory => true });
        vibrateIfEnabled();
        requestUpdate();
    }

    function vibrateIfEnabled() {
        if (Application.Properties.getValue(SETTING_VIBRATEONBUTTON)) {
            Attention.vibrate(lxVibeProfile);
        }
    }
}
