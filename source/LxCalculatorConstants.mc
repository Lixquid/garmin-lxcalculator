import Toybox.Lang;
import Toybox.WatchUi;

const STORAGE_STATE_VERSION = "saveState.version";
const STORAGE_STATE_LEFT = "saveState.left";
const STORAGE_STATE_OPERATOR = "saveState.operator";
const STORAGE_STATE_RIGHT = "saveState.right";
const STORAGE_STATE_ERRORED = "saveState.errored";

(:initialized) var APP_VERSION as String;

(:initialized) var STR_MAINMENUTITLE as String;
(:initialized) var STR_MAINMENUSETTINGS as String;

(:initialized) var SETTING_SWITCHAFTEROPERATOR as String;
(:initialized) var SETTING_SWITCHAFTEROPERATOR_TITLE as String;
(:initialized) var SETTING_SWITCHAFTEROPERATOR_PROMPT as String;

function initializeConstants() {
    APP_VERSION = WatchUi.loadResource(Rez.Strings.AppVersion);

    STR_MAINMENUTITLE = WatchUi.loadResource(Rez.Strings.MainMenuTitle);
    STR_MAINMENUSETTINGS = WatchUi.loadResource(Rez.Strings.MainMenuSettings);

    SETTING_SWITCHAFTEROPERATOR = WatchUi.loadResource(Rez.Strings.SwitchAfterOperator);
    SETTING_SWITCHAFTEROPERATOR_TITLE = WatchUi.loadResource(Rez.Strings.SwitchAfterOperatorTitle);
    SETTING_SWITCHAFTEROPERATOR_PROMPT = WatchUi.loadResource(Rez.Strings.SwitchAfterOperatorPrompt);
}
