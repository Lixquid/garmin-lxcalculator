import Toybox.WatchUi;
import Toybox.Lang;

enum LX_DIRECTION {
    LX_DIRECTION_UP,
    LX_DIRECTION_RIGHT,
    LX_DIRECTION_DOWN,
    LX_DIRECTION_LEFT,
}

class LxCalculatorInputBehaviorDelegate extends BehaviorDelegate {
    private var _view as LxCalculatorAbstractView?;

    function initialize(view as LxCalculatorAbstractView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onSwipe(swipeEvent as SwipeEvent) as Boolean {
        switch (swipeEvent.getDirection()) {
            case SWIPE_UP:
                _view.onPage(LX_DIRECTION_DOWN);
                return true;
            case SWIPE_RIGHT:
                _view.onPage(LX_DIRECTION_LEFT);
                return true;
            case SWIPE_DOWN:
                _view.onPage(LX_DIRECTION_UP);
                return true;
            case SWIPE_LEFT:
                _view.onPage(LX_DIRECTION_RIGHT);
                return true;
        }
        return false;
    }

    function onTap(clickEvent as ClickEvent) as Boolean {
        if (clickEvent.getType() != CLICK_TYPE_TAP) {
            return false;
        }
        var coords = clickEvent.getCoordinates();
        var x = coords[0].toDouble() / _view.width;
        var y = coords[1].toDouble() / _view.height;

        if (x < 0.1) {
            _view.onPage(LX_DIRECTION_LEFT);
            return true;
        }
        if (x > 0.9) {
            _view.onPage(LX_DIRECTION_RIGHT);
            return true;
        }
        if (y < 0.1) {
            _view.onPage(LX_DIRECTION_UP);
            return true;
        }
        if (y < 0.25) {
            _view.onConfirm();
            return true;
        }
        if (y > 0.9) {
            _view.onPage(LX_DIRECTION_DOWN);
            return true;
        }

        // 3x4 grid, 0.1 spacing, display is 0.15 tall
        // button width = (1 - 0.1 * 2) / 3 = 0.2666
        // button height = (1 - 0.1 * 2 - 0.15) / 4 = 0.1625
        _view.onButton(((x - 0.1) / 0.2666).toNumber(), ((y - 0.25) / 0.1625).toNumber());
        return true;
    }

    function onHold(clickEvent as ClickEvent) as Boolean {
        if (clickEvent.getType() != CLICK_TYPE_HOLD) {
            return false;
        }

        var coords = clickEvent.getCoordinates();
        var x = coords[0].toDouble() / _view.width;
        var y = coords[1].toDouble() / _view.height;
        if (x < 0.1 || x > 0.9 || y < 0.25 || y > 0.9) {
            return true;
        }

        _view.onButtonHeld(((x - 0.1) / 0.2666).toNumber(), ((y - 0.25) / 0.1625).toNumber());
        return true;
    }

    function onKey(keyEvent as KeyEvent) as Boolean {
        switch (keyEvent.getKey()) {
            case KEY_DOWN:
                _view.onPage(LX_DIRECTION_RIGHT);
                return true;
            case KEY_UP:
                _view.onPage(LX_DIRECTION_LEFT);
                return true;
            case KEY_ENTER:
                _view.onConfirm();
                return true;
        }
        return false;
    }

    function onMenu() as Boolean {
        createLxCalculatorMainMenu();
        return true;
    }

}
