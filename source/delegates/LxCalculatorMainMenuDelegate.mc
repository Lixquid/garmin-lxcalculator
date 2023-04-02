import Toybox.WatchUi;

class LxCalculatorMainMenuDelegate extends Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    function onBack() {
        WatchUi.popView(slideIfEnabled(WatchUi.SLIDE_LEFT));
    }
    function onSelect(item as MenuItem) {
        switch (item.getId()) {
            case "convert":
                createLxCalculatorUnitsCategoryMenu();
                break;
            case "settings":
                createLxCalculatorSettingsMenu();
                break;
        }
    }
}

function createLxCalculatorMainMenu() {
    var menu = new Menu2({:title => STR_MAINMENUTITLE});
    menu.addItem(new MenuItem(
        STR_MAINMENUCONVERT,
        null,
        "convert",
        {}
    ));
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
    WatchUi.pushView(menu, new LxCalculatorMainMenuDelegate(), slideIfEnabled(WatchUi.SLIDE_RIGHT));
}
