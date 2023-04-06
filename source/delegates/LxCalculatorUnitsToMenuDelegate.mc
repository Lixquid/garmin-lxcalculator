import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class LxCalculatorUnitsToMenuDelegate extends Menu2InputDelegate {
    (:initialized)
    private var _logic as LxCalculatorLogic;
    (:initialized)
    private var _category as String;
    (:initialized)
    private var _from as String;

    function initialize(logic as LxCalculatorLogic, category as String, from as String) {
        Menu2InputDelegate.initialize();
        _logic = logic;
        _category = category;
        _from = from;
    }

    function onSelect(item as MenuItem) {
        var units = lxCalculatorUnitsJson[_category];

        var fromData = null as LxCalculatorUnitData?;
        for (var i = 0; i < units.size(); i++) {
            if (units[i]["name"].equals(_from)) {
                fromData = units[i];
                break;
            }
        }

        var toData = null as LxCalculatorUnitData?;
        for (var i = 0; i < units.size(); i++) {
            if (units[i]["name"].equals(item.getId())) {
                toData = units[i];
                break;
            }
        }

        var value = _logic.getAsDouble();
        var fromAffine = fromData["affine"];
        if (fromAffine == null) { fromAffine = 0d; }
        var toAffine = toData["affine"];
        if (toAffine == null) { toAffine = 0d; }
        var result = ((value - fromAffine) * fromData["factor"]) / toData["factor"] + toAffine;
        WatchUi.pushView(
            new LxCalculatorUnitsResultView(
                doubleToStr(value) + fromData["unit"],
                doubleToStr(result) + toData["unit"]
            ),
            new LxCalculatorUnitsResultBehaviorDelegate(_logic, result),
            slideIfEnabled(SLIDE_LEFT)
        );
    }

    function onBack() {
        WatchUi.popView(slideIfEnabled(WatchUi.SLIDE_RIGHT));
    }
}

function createLxCalculatorToMenuDelegate(logic as LxCalculatorLogic, category as String, from as String) {
    var menu = new Menu2({ :title => STR_CONVERTMENUTO });
    var entries = lxCalculatorUnitsJson[category];
    for (var i = 0; i < entries.size(); i++) {
        if (entries[i]["name"].equals(from)) {
            continue;
        }
        menu.addItem(new MenuItem(entries[i]["name"], entries[i]["unit"], entries[i]["name"], {}));
    }
    WatchUi.pushView(
        menu,
        new LxCalculatorUnitsToMenuDelegate(logic, category, from),
        slideIfEnabled(WatchUi.SLIDE_LEFT)
    );
}
