import Toybox.WatchUi;

class LxCalculatorMainMenuDelegate extends Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
    function onSelect(item as MenuItem) {
    }
}

function createLxCalculatorMainMenu() {
    var menu = new Menu2({:title => "Main Menu"});
    menu.addItem(new MenuItem(
        "Lx Calculator",
        APP_VERSION,
        "",
        {}
    ));
    WatchUi.pushView(menu, new LxCalculatorMainMenuDelegate(), WatchUi.SLIDE_RIGHT);
}
