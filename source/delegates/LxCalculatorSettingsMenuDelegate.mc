import Toybox.Application;
import Toybox.WatchUi;

class LxCalculatorSettingsMenuDelegate extends Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
    function onSelect(item as MenuItem) {
        switch (item.getId()) {
            case SETTING_SWITCHAFTEROPERATOR:
                Application.Properties.setValue(SETTING_SWITCHAFTEROPERATOR,
                    !Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR));
                break;
        }
    }
}

function createLxCalculatorSettingsMenu() {
    var menu = new Menu2({:title => STR_MAINMENUSETTINGS});
    menu.addItem(new ToggleMenuItem(
        SETTING_SWITCHAFTEROPERATOR_TITLE,
        SETTING_SWITCHAFTEROPERATOR_PROMPT,
        SETTING_SWITCHAFTEROPERATOR,
        Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR),
        null));
    WatchUi.pushView(menu, new LxCalculatorSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
}
