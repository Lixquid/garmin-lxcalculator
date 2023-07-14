import Toybox.WatchUi;

class LxCalculatorHistoryMenuDelegate extends Menu2InputDelegate {
    (:initialized)
    private var _logic as LxCalculatorLogic;

    function initialize(logic as LxCalculatorLogic) {
        Menu2InputDelegate.initialize();
        _logic = logic;
    }

    function onSelect(item) {
        if (item.getId() == "") {
            return;
        }
        _logic.setValue(
            _logic.history[(item.getId() as Toybox.Lang.String).toNumber()],
            {}
        );
        onBack();
    }

    function onBack() {
        WatchUi.popView(slideIfEnabled(SLIDE_UP));
    }
}

function createLxCalculatorHistoryMenu(logic as LxCalculatorLogic) {
    var menu = new Menu2({ :title => STR_HISTORYMENUTITLE });
    if (logic.history.size() == 0) {
        menu.addItem(new MenuItem(STR_HISTORYMENUNOENTRIES, null, "", {}));
    } else {
        for (var i = 0; i < logic.history.size(); i++) {
            menu.addItem(
                new MenuItem(
                    doubleToStr(logic.history[i]),
                    null,
                    i.toString(),
                    null
                )
            );
        }
        menu.setFocus(logic.history.size() - 1);
    }
    WatchUi.pushView(
        menu,
        new LxCalculatorHistoryMenuDelegate(logic),
        slideIfEnabled(WatchUi.SLIDE_DOWN)
    );
}
