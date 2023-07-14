import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorUnitsResultMenuDelegate extends Menu2InputDelegate {
    (:initialized)
    private var _logic as LxCalculatorLogic;
    (:initialized)
    private var _result as Double;

    function initialize(logic as LxCalculatorLogic, result as Double) {
        Menu2InputDelegate.initialize();
        _logic = logic;
        _result = result;
    }

    function onSelect(item as MenuItem) {
        switch (item.getId()) {
            case "set":
                _logic.setValue(_result, { :addToHistory => true });
            case "discard":
                WatchUi.popView(SLIDE_IMMEDIATE); // result
                WatchUi.popView(SLIDE_IMMEDIATE); // to menu
                WatchUi.popView(SLIDE_IMMEDIATE); // from menu
                WatchUi.popView(SLIDE_IMMEDIATE); // category menu
                WatchUi.popView(SLIDE_IMMEDIATE); // main menu
                WatchUi.popView(SLIDE_IMMEDIATE); // display
                return;
        }
    }

    function onBack() {
        WatchUi.popView(slideIfEnabled(SLIDE_RIGHT));
    }
}

function createLxCalculatorUnitResultMenu(
    logic as LxCalculatorLogic,
    result as Double
) {
    var menu = new Menu2({ :title => doubleToStr(result) });
    menu.addItem(
        new MenuItem(
            WatchUi.loadResource(Rez.Strings.ConvertMenuResultDiscard),
            null,
            "discard",
            null
        )
    );
    menu.addItem(
        new MenuItem(
            WatchUi.loadResource(Rez.Strings.ConvertMenuResultSet),
            null,
            "set",
            null
        )
    );
    WatchUi.pushView(
        menu,
        new LxCalculatorUnitsResultMenuDelegate(logic, result),
        slideIfEnabled(WatchUi.SLIDE_LEFT)
    );
}
