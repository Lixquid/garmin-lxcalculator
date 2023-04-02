import Toybox.Lang;
import Toybox.StringUtil;
import Toybox.WatchUi;

function slideIfEnabled(dir as WatchUi.SlideType) {
    return Toybox.Application.Properties.getValue(SETTING_SCREENTRANSITIONS)
        ? dir
        : WatchUi.SLIDE_IMMEDIATE;
}

function doubleToCharArray(num as Double) as Array<Char> {
    var ar = num.toString().toCharArray();
    var i = ar.size();
    while (i > 0) {
        i -= 1;
        switch (ar[i]) {
            case '0':
                break;
            case '.':
                return ar.slice(0, i);
            default:
                return ar.slice(0, i + 1);
        }
    }
    return [] as Array<Char>;
}

function doubleToStr(num as Double) as String {
    return StringUtil.charArrayToString(doubleToCharArray(num));
}
