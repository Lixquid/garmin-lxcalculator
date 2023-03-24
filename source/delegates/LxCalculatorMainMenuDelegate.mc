import Toybox.WatchUi;

class LxCalculatorMainMenuDelegate extends Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
    function onSelect(item as MenuItem) {
        switch (item.getId()) {
            case "settings":
                createLxCalculatorSettingsMenu();
                break;
        }
    }
}

function createLxCalculatorMainMenu() {
    var menu = new Menu2({:title => STR_MAINMENUTITLE});
    menu.addItem(new MenuItem(
        STR_MAINMENUSETTINGS,
        null,
        "settings",
        {}
    ));
    menu.addItem(new MenuItem(
        "Lx Calculator",
        APP_VERSION,
        "",
        {}
    ));
    WatchUi.pushView(menu, new LxCalculatorMainMenuDelegate(), WatchUi.SLIDE_RIGHT);
}
