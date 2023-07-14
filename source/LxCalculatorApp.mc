import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorApp extends AppBase {
    var logic as LxCalculatorLogic = new LxCalculatorLogic();

    function initialize() {
        AppBase.initialize();
        initializeConstants();
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        logic.loadState();
        var view = new LxCalculatorNumbersView(logic);
        return [view, new LxCalculatorInputBehaviorDelegate(view)];
    }
}
