import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorApp extends AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        var view = new LxCalculatorNumbersView(new LxCalculatorLogic());
        return [view, new LxCalculatorInputBehaviorDelegate(view)];
    }

}
