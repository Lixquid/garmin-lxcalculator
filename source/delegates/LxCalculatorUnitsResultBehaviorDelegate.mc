import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorUnitsResultBehaviorDelegate extends BehaviorDelegate {
    (:initialized)
    private var _logic as LxCalculatorLogic;
    (:initialized)
    private var _result as Double;

    function initialize(logic as LxCalculatorLogic, result as Double) {
        BehaviorDelegate.initialize();
        _logic = logic;
        _result = result;
    }

    function onSelect() as Boolean {
        createLxCalculatorUnitResultMenu(_logic, _result);
        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(slideIfEnabled(SLIDE_RIGHT));
        return true;
    }
}
