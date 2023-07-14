import Toybox.Graphics;
import Toybox.Lang;

class LxCalculatorExtraView extends LxCalculatorAbstractView {
    function initialize(logic as LxCalculatorLogic) {
        LxCalculatorAbstractView.initialize(logic);
    }

    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.Extra(dc));
        LxCalculatorAbstractView.onLayout(dc);
    }

    // prettier-ignore
    function onButton(x as Number, y as Number) {
        switch (y) {
            case 0: switch (x) {
                case 0: {
                    var value = _logic.memory[0];
                    if (value == null) { return; }
                    _logic.setValue(value, {});
                    break;
                }
                case 1: {
                    var value = _logic.getAsDouble();
                    if (_logic._errored) {
                        return;
                    }
                    _logic.memory[0] = value;
                    _logic.saveState();
                    break;
                }
                case 2: {
                    var value = _logic.getAsDouble();
                    if (_logic._errored) {
                        return;
                    }
                    _logic.memory[0] = _logic.memory[0] == null ? value : _logic.memory[0] + value;
                    _logic.saveState();
                    break;
                }
            } break;
            case 1: switch (x) {
                case 0: return;
                case 1: _logic.setOperator(LX_OPERATOR_LOG); sw(); break;
                case 2: return;
            } break;
            case 2: switch (x) {
                case 0: return;
                case 1: return;
                case 2: return;
            } break;
            case 3: switch (x) {
                case 0: return;
                case 1: return;
                case 2: _logic.delete(); break;
            } break;
        }
        vibrateIfEnabled();
        requestUpdate();
    }

    function onPage(direction as LX_DIRECTION) {
        switch (direction) {
            case LX_DIRECTION_UP: {
                var view = new LxCalculatorNumbersView(_logic);
                WatchUi.switchToView(
                    view,
                    new LxCalculatorInputBehaviorDelegate(view),
                    slideIfEnabled(SLIDE_DOWN)
                );
                return;
            }
        }
    }

    function sw() {
        // Switch if setting is set
        if (Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR)) {
            onPage(LX_DIRECTION_UP);
        }
    }
}
