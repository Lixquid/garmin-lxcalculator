import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

var lxAngModeDisplay =
    {
        LX_ANGMODE_DEGREES => "DEG",
        LX_ANGMODE_RADIANS => "RAD",
        LX_ANGMODE_GRADIANS => "GRAD",
    } as Dictionary<LX_ANGMODE, String>;

class LxCalculatorTrigonometryView extends LxCalculatorAbstractView {
    private var _pi = 3.141592653589793115997963468544185161590576171875d;
    private var _e = 2.718281828459045090795598298427648842334747314453125d;

    private var _angMode as Text?;

    function initialize(logic as LxCalculatorLogic) {
        LxCalculatorAbstractView.initialize(logic);
    }

    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.Trigonometry(dc));
        _angMode = View.findDrawableById("AngMode");
        if (_angMode != null) {
            _angMode.setText(lxAngModeDisplay[_logic.angMode]);
        }
        LxCalculatorAbstractView.onLayout(dc);
    }

    // prettier-ignore
    function onButton(x as Number, y as Number) {
        switch (y) {
            case 0: switch (x) {
                case 0: _logic.setValue(_pi, {}); sw(); break;
                case 1: {
                    switch (_logic.angMode) {
                        case LX_ANGMODE_DEGREES:
                            _logic.angMode = LX_ANGMODE_RADIANS; break;
                        case LX_ANGMODE_RADIANS:
                            _logic.angMode = LX_ANGMODE_GRADIANS; break;
                        case LX_ANGMODE_GRADIANS:
                            _logic.angMode = LX_ANGMODE_DEGREES; break;
                    }
                    _logic.saveState();
                    break;
                }
                case 2: return;
            } break;
            case 1: switch (x) {
                case 0:
                    _logic.setValue(Math.sin(gR()), {:addToHistory => true});
                    sw();
                    break;
                case 1:
                    _logic.setValue(Math.cos(gR()), {:addToHistory => true});
                    sw();
                    break;
                case 2:
                    _logic.setValue(Math.tan(gR()), {:addToHistory => true});
                    sw(); break;
            } break;
            case 2: switch (x) {
                case 0: sR(Math.asin(_logic.getAsDouble())); sw(); break;
                case 1: sR(Math.acos(_logic.getAsDouble())); sw(); break;
                case 2: sR(Math.atan(_logic.getAsDouble())); sw(); break;
            } break;
            case 3: switch (x) {
                case 0: _logic.setValue(_e, {}); sw(); break;
                case 1: _logic.setValue(Math.ln(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
                case 2: _logic.delete(); break;
            } break;
        }
        vibrateIfEnabled();
        requestUpdate();
    }

    function onPage(direction as LX_DIRECTION) {
        switch (direction) {
            case LX_DIRECTION_RIGHT: {
                var view = new LxCalculatorNumbersView(_logic);
                WatchUi.switchToView(view, new LxCalculatorInputBehaviorDelegate(view), slideIfEnabled(SLIDE_LEFT));
                return;
            }
        }
    }

    function onUpdate(dc as Dc) {
        if (_angMode != null) {
            _angMode.setText(lxAngModeDisplay[_logic.angMode]);
        }
        LxCalculatorAbstractView.onUpdate(dc);
    }

    function gR() as Double {
        var value = _logic.getAsDouble();
        switch (_logic.angMode) {
            case LX_ANGMODE_DEGREES:
                return (value / 180) * _pi;
            case LX_ANGMODE_RADIANS:
                return value;
            case LX_ANGMODE_GRADIANS:
                return (value / 200) * _pi;
        }
        return 0d;
    }

    function sR(value as Double) {
        switch (_logic.angMode) {
            case LX_ANGMODE_DEGREES:
                _logic.setValue((value / _pi) * 180, { :addToHistory => true });
                break;
            case LX_ANGMODE_RADIANS:
                _logic.setValue(value, { :addToHistory => true });
                break;
            case LX_ANGMODE_GRADIANS:
                _logic.setValue((value / _pi) * 200, { :addToHistory => true });
                break;
        }
    }

    function sw() {
        // Switch if setting is set
        if (Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR)) {
            onPage(LX_DIRECTION_RIGHT);
        }
    }
}
