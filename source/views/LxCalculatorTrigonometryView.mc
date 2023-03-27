import Toybox.Graphics;
import Toybox.Lang;

class LxCalculatorTrigonometryView extends LxCalculatorAbstractView {
    var _pi = 3.141592653589793115997963468544185161590576171875d;
    var _e = 2.718281828459045090795598298427648842334747314453125d;

    function initialize(logic as LxCalculatorLogic) {
        LxCalculatorAbstractView.initialize(logic);
    }

    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.Trigonometry(dc));
        LxCalculatorAbstractView.onLayout(dc);
    }

    function onButton(x as Number, y as Number) {
        switch (y) {
            case 0: switch (x) {
                case 0: _logic.setValue(_pi, {}); sw(); break;
                case 1: _logic.setValue(_e, {}); sw(); break;
                case 2: _logic.setValue(Math.pow(_logic.getAsDouble(), 0.5), {:addToHistory => true}); sw(); break;
            } break;
            case 1: switch (x) {
                case 0: _logic.setValue(Math.sin(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
                case 1: _logic.setValue(Math.cos(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
                case 2: _logic.setValue(Math.tan(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
            } break;
            case 2: switch (x) {
                case 0: _logic.setValue(Math.asin(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
                case 1: _logic.setValue(Math.acos(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
                case 2: _logic.setValue(Math.atan(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
            } break;
            case 3: switch (x) {
                case 0: _logic.setValue(Math.ln(_logic.getAsDouble()), {:addToHistory => true}); sw(); break;
                case 1: _logic.setOperator(LX_OPERATOR_LOG); sw(); break;
                case 2: _logic.delete(); break;
            } break;
        }
        requestUpdate();
    }

    function onPage(direction as LX_DIRECTION) {
        switch (direction) {
            case LX_DIRECTION_RIGHT: {
                var view = new LxCalculatorNumbersView(_logic);
                WatchUi.switchToView(view, new LxCalculatorInputBehaviorDelegate(view), SLIDE_LEFT);
                return;
            }
        }
    }

    function sw() {
        // Switch if setting is set
        if (Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR)) {
            var view = new LxCalculatorNumbersView(_logic);
            WatchUi.switchToView(view, new LxCalculatorInputBehaviorDelegate(view), SLIDE_LEFT);
        }
    }
}
