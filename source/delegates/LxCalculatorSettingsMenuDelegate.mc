import Toybox.Application;
import Toybox.WatchUi;

class LxCalculatorSettingsMenuDelegate extends Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    function onBack() {
        WatchUi.popView(slideIfEnabled(WatchUi.SLIDE_RIGHT));
    }
    function onSelect(item as MenuItem) {
        switch (item.getId()) {
            case SETTING_SWITCHAFTEROPERATOR:
                Application.Properties.setValue(
                    SETTING_SWITCHAFTEROPERATOR,
                    !Application.Properties.getValue(
                        SETTING_SWITCHAFTEROPERATOR
                    )
                );
                break;
            case SETTING_VIBRATEONBUTTON:
                Application.Properties.setValue(
                    SETTING_VIBRATEONBUTTON,
                    !Application.Properties.getValue(SETTING_VIBRATEONBUTTON)
                );
                break;
            case SETTING_SCREENTRANSITIONS:
                Application.Properties.setValue(
                    SETTING_SCREENTRANSITIONS,
                    !Application.Properties.getValue(SETTING_SCREENTRANSITIONS)
                );
                break;
        }
    }
}

function createLxCalculatorSettingsMenu() {
    var menu = new Menu2({ :title => STR_MAINMENUSETTINGS });
    menu.addItem(
        new ToggleMenuItem(
            SETTING_SWITCHAFTEROPERATOR_TITLE,
            SETTING_SWITCHAFTEROPERATOR_PROMPT,
            SETTING_SWITCHAFTEROPERATOR,
            Application.Properties.getValue(SETTING_SWITCHAFTEROPERATOR),
            null
        )
    );
    menu.addItem(
        new ToggleMenuItem(
            SETTING_VIBRATEONBUTTON_TITLE,
            SETTING_VIBRATEONBUTTON_PROMPT,
            SETTING_VIBRATEONBUTTON,
            Application.Properties.getValue(SETTING_VIBRATEONBUTTON),
            null
        )
    );
    menu.addItem(
        new ToggleMenuItem(
            SETTING_SCREENTRANSITIONS_TITLE,
            SETTING_SCREENTRANSITIONS_PROMPT,
            SETTING_SCREENTRANSITIONS,
            Application.Properties.getValue(SETTING_SCREENTRANSITIONS),
            null
        )
    );
    WatchUi.pushView(
        menu,
        new LxCalculatorSettingsMenuDelegate(),
        slideIfEnabled(WatchUi.SLIDE_LEFT)
    );
}
