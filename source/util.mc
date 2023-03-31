import Toybox.WatchUi;

function slideIfEnabled(dir as WatchUi.SlideType) {
    return Toybox.Application.Properties.getValue(SETTING_SCREENTRANSITIONS)
        ? dir
        : WatchUi.SLIDE_IMMEDIATE;
}
