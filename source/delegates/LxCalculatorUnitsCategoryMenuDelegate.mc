import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

typedef LxCalculatorUnitData as {
    "name" as String,
    "unit" as String,
    "factor" as Double,
};

var lxCalculatorUnitsJson as Dictionary<String, Array<LxCalculatorUnitData> >?;

class LxCalculatorUnitsCategoryMenuDelegate extends Menu2InputDelegate {
    (:initialized)
    private var _logic as LxCalculatorLogic;

    function initialize(logic as LxCalculatorLogic) {
        Menu2InputDelegate.initialize();
        _logic = logic;
    }

    function onSelect(item as MenuItem) {
        createLxCalculatorFromMenuDelegate(_logic, item.getId() as String);
    }

    function onBack() {
        WatchUi.popView(slideIfEnabled(WatchUi.SLIDE_RIGHT));
    }
}

function createLxCalculatorUnitsCategoryMenu() {
    if (lxCalculatorUnitsJson == null) {
        lxCalculatorUnitsJson = Application.loadResource(
            Rez.JsonData.UnitsData
        );
    }

    // TODO: Account for errored logic

    var logic = (Application.getApp() as LxCalculatorApp).logic;
    var menu = new Menu2({ :title => STR_MAINMENUCONVERT });
    var keys = lxCalculatorUnitsJson.keys();
    for (var i = 0; i < keys.size(); i++) {
        menu.addItem(new MenuItem(keys[i], null, keys[i], {}));
    }
    WatchUi.pushView(
        menu,
        new LxCalculatorUnitsCategoryMenuDelegate(logic),
        slideIfEnabled(WatchUi.SLIDE_LEFT)
    );
}
