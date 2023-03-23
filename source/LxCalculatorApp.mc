import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorApp extends AppBase {

    function initialize() {
        AppBase.initialize();
        initializeConstants();
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        var logic = new LxCalculatorLogic();
        logic.loadState();
        var view = new LxCalculatorNumbersView(logic);
        return [view, new LxCalculatorInputBehaviorDelegate(view)];
    }

}
