import Toybox.Lang;
import Toybox.WatchUi;

(:initialized) var APP_VERSION as String;

const STORAGE_STATE_VERSION = "saveState.version";
const STORAGE_STATE_LEFT = "saveState.left";
const STORAGE_STATE_OPERATOR = "saveState.operator";
const STORAGE_STATE_RIGHT = "saveState.right";
const STORAGE_STATE_ERRORED = "saveState.errored";

(:initialized) var SETTING_SWITCHAFTEROPERATOR as String;

function initializeConstants() {
    APP_VERSION = WatchUi.loadResource(Rez.Strings.AppVersion);
    SETTING_SWITCHAFTEROPERATOR = WatchUi.loadResource(Rez.Strings.SwitchAfterOperator);
}
