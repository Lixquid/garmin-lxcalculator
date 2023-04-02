import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorUnitsFromMenuDelegate extends Menu2InputDelegate {
    (:initialized) private var _logic as LxCalculatorLogic;
    (:initialized) private var _category as String;

    function initialize(logic as LxCalculatorLogic, category as String) {
        Menu2InputDelegate.initialize();
        _logic = logic;
        _category = category;
    }

    function onSelect(item as MenuItem) {
        createLxCalculatorToMenuDelegate(_logic, _category, item.getId());
    }

    function onBack() {
        WatchUi.popView(slideIfEnabled(WatchUi.SLIDE_RIGHT));
    }
}

function createLxCalculatorFromMenuDelegate(logic as LxCalculatorLogic, category as String) {
    var menu = new Menu2({ :title => STR_CONVERTMENUFROM });
    var entries = lxCalculatorUnitsJson[category];
    for (var i = 0; i < entries.size(); i++) {
        menu.addItem(new MenuItem(entries[i]["name"], entries[i]["unit"], entries[i]["name"], {}));
    }
    WatchUi.pushView(menu, new LxCalculatorUnitsFromMenuDelegate(logic, category), slideIfEnabled(WatchUi.SLIDE_LEFT));
}
