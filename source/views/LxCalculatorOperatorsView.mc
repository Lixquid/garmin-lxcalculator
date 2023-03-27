import Toybox.Graphics;
import Toybox.Lang;

class LxCalculatorOperatorsView extends LxCalculatorAbstractView {
    function initialize(logic as LxCalculatorLogic) {
        LxCalculatorAbstractView.initialize(logic);
    }

    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.Operators(dc));
        LxCalculatorAbstractView.onLayout(dc);
    }

    function onButton(x as Number, y as Number) {
        switch (y) {
            case 0: switch (x) {
                case 0: _logic.setOperator(LX_OPERATOR_ADD); sw(); break;
                case 1: _logic.setOperator(LX_OPERATOR_SUBTRACT); sw(); break;
                case 2: _logic.setOperator(LX_OPERATOR_MULTIPLY); sw(); break;
            } break;
            case 1: switch (x) {
                case 0: _logic.setOperator(LX_OPERATOR_DIVIDE); sw(); break;
                case 1: _logic.setOperator(LX_OPERATOR_POWER); sw(); break;
                case 2: _logic.calculate({ :addToHistory => true }); break;
            } break;
            case 2: switch (x) {
                case 0: return;
                case 1: return;
                case 2: return;
            } break;
            case 3: switch (x) {
                case 0: _logic.clearAll(); sw(); break;
                case 1: return;
                case 2: _logic.delete(); break;
            } break;
        }
        vibrateIfEnabled();
        requestUpdate();
    }

    function onPage(direction as LX_DIRECTION) {
        switch (direction) {
            case LX_DIRECTION_LEFT: {
                var view = new LxCalculatorNumbersView(_logic);
                WatchUi.switchToView(view, new LxCalculatorInputBehaviorDelegate(view), SLIDE_RIGHT);
                return;
            }
        }
    }

    function sw() {
        // Switch if setting is set
        if (Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR)) {
            var view = new LxCalculatorNumbersView(_logic);
            WatchUi.switchToView(view, new LxCalculatorInputBehaviorDelegate(view), SLIDE_RIGHT);
        }
    }
}
