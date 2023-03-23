import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorNumbersView extends LxCalculatorAbstractView {
    function initialize(logic as LxCalculatorLogic) {
        LxCalculatorAbstractView.initialize(logic);
    }

    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.Numbers(dc));
        LxCalculatorAbstractView.onLayout(dc);
    }

    function onButton(x as Number, y as Number) {
        switch (y) {
            case 0: switch (x) {
                case 0: _logic.addChar('7'); break;
                case 1: _logic.addChar('8'); break;
                case 2: _logic.addChar('9'); break;
            } break;
            case 1: switch (x) {
                case 0: _logic.addChar('4'); break;
                case 1: _logic.addChar('5'); break;
                case 2: _logic.addChar('6'); break;
            } break;
            case 2: switch (x) {
                case 0: _logic.addChar('1'); break;
                case 1: _logic.addChar('2'); break;
                case 2: _logic.addChar('3'); break;
            } break;
            case 3: switch (x) {
                case 0: _logic.addChar('.'); break;
                case 1: _logic.addChar('0'); break;
                case 2: _logic.delete(); break;
            } break;
        }
        requestUpdate();
    }

    function onPage(direction as LX_DIRECTION) {
        switch (direction) {
            case LX_DIRECTION_RIGHT: {
                var view = new LxCalculatorOperatorsView(_logic);
                WatchUi.switchToView(view, new LxCalculatorInputBehaviorDelegate(view), SLIDE_LEFT);
                return;
            }
        }
    }
}
