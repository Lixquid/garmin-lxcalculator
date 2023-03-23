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
                case 0: _logic.setOperator(LX_OPERATOR_ADD); break;
                case 1: _logic.setOperator(LX_OPERATOR_SUBTRACT); break;
                case 2: _logic.setOperator(LX_OPERATOR_MULTIPLY); break;
            } break;
            case 1: switch (x) {
                case 0: _logic.setOperator(LX_OPERATOR_DIVIDE); break;
                case 1: _logic.setOperator(LX_OPERATOR_POWER); break;
                case 2: _logic.calculate(); break;
            } break;
            case 2: switch (x) {
                case 0: break;
                case 1: break;
                case 2: break;
            } break;
            case 3: switch (x) {
                case 0: _logic.clearAll(); break;
                case 1: break;
                case 2: _logic.delete(); break;
            } break;
        }
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
}
