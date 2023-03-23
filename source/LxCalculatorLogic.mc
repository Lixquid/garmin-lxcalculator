import Toybox.Lang;
import Toybox.Math;
import Toybox.StringUtil;
import Toybox.Test;

enum LX_OPERATOR {
    LX_OPERATOR_NONE,
    LX_OPERATOR_ADD,
    LX_OPERATOR_SUBTRACT,
    LX_OPERATOR_MULTIPLY,
    LX_OPERATOR_DIVIDE,
    LX_OPERATOR_POWER
}

var LxCalculatorOperatorDisplay = {
    LX_OPERATOR_NONE => "$1$",
    LX_OPERATOR_ADD => "$1$ + $2$",
    LX_OPERATOR_SUBTRACT => "$1$ - $2$",
    LX_OPERATOR_MULTIPLY => "$1$ × $2$",
    LX_OPERATOR_DIVIDE => "$1$ ÷ $2$",
    LX_OPERATOR_POWER => "$1$ ^ $2$"
} as Dictionary<LX_OPERATOR, String>;

class LxCalculatorLogic {

    var _left as Array<Char> = [] as Array<Char>;
    var _operator as LX_OPERATOR = LX_OPERATOR_NONE;
    var _right as Array<Char> = [] as Array<Char>;
    var _errored as Boolean = false;

    function addChar(char as Char) {
        if (_errored) { return; }

        var target = _operator == LX_OPERATOR_NONE ? _left : _right;

        switch (char) {
            case '.':
                if (target.indexOf(char) != -1) {
                    // Can't add multiple .
                    return;
                }
                if (target.size() == 0) {
                    // Turn "." into "0."
                    target.add('0');
                }
                target.add('.');
                return;
            case '0':
                if (target.size() == 0) {
                    // Don't add leading zeroes
                    return;
                }
                target.add('0');
                return;
            default:
                target.add(char);
                return;
        }
    }

    function delete() {
        if (_errored) { return; }

        if (_right.size() > 0) {
            if (_right.size() == 2 && _right[0] == '0' && _right[1] == '.') {
                _right = [];
            } else {
                _right = _right.slice(0, -1);
            }
        } else if (_operator != LX_OPERATOR_NONE) {
            _operator = LX_OPERATOR_NONE;
        } else {
            if (_left.size() == 2 && _left[0] == '0' && _left[1] == '.') {
                _left = [];
            } else if (_left.size() > 0) {
                _left = _left.slice(0, -1);
            }
        }
    }

    function clearAll() {
        _left = [];
        _right = [];
        _operator = LX_OPERATOR_NONE;
        _errored = false;
    }

    function setOperator(op as LX_OPERATOR) {
        if (_errored) { return; }

        if (_right.size() != 0) {
            // If we have an existing operation, calculate it before doing another
            // A + B - => AB -
            calculate();
        }
        _operator = op;
    }

    function calculate() {
        if (_errored) { return; }

        if (_operator == LX_OPERATOR_NONE) {
            // No operation to do
            return;
        }
        var left = StringUtil.charArrayToString(_left).toDouble();
        if (left == null) {
            left = 0d;
        }
        var right = StringUtil.charArrayToString(_right).toDouble();
        if (right == null) {
            right = 0d;
        }
        var result = 0d;
        switch (_operator) {
            case LX_OPERATOR_ADD:
                result = left + right;
                break;
            case LX_OPERATOR_SUBTRACT:
                result = left - right;
                break;
            case LX_OPERATOR_MULTIPLY:
                result = left * right;
                break;
            case LX_OPERATOR_DIVIDE:
                if (right == 0d) {
                    setErrored();
                    return;
                }
                result = left / right;
                break;
            case LX_OPERATOR_POWER:
                result = Math.pow(left, right);
                break;
        }
        if (result != result) {
            // NaN
            setErrored();
            return;
        }
        var resultStr = result.toString().toCharArray();

        if (resultStr.indexOf('.') != -1) {
            resultStr = stripTrailingZeroes(resultStr);
        }
        if (resultStr.size() == 1 && resultStr[0] == '0') {
            resultStr = [];
        }

        _left = resultStr;
        _operator = LX_OPERATOR_NONE;
        _right = [] as Array<Char>;
    }

    function setErrored() {
        _errored = true;
    }

    function stripTrailingZeroes(ar as Array<Char>) as Array<Char> {
        // Convert "1.200" to "1.2"
        // and "1.00" to "1"
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

    function format() {
        if (_errored) {
            return "ERR";
        }
        return Lang.format(LxCalculatorOperatorDisplay[_operator], [
            _left.size() == 0 ? "0" : StringUtil.charArrayToString(_left),
            _right.size() == 0 ? "0" : StringUtil.charArrayToString(_right)
        ] as Array<String>);
    }
}

(:test)
module LxCalculatorLogicTests {
    function eq_l(logger as Logger, l as LxCalculatorLogic, left as Array<Char>, op as LX_OPERATOR, right as Array<Char>) as Boolean {
        if (l._operator != op) {
            logger.error("Operators are different");
            logger.error("Expected: " + op.toString());
            logger.error("Actual: " + l._operator.toString());
            return false;
        }

        if (l._left.size() != left.size()) {
            logger.error("Left array is different size");
            logger.error("Expected: " + left.toString());
            logger.error("Actual: " + l._left.toString());
            return false;
        }
        for (var i = 0; i < left.size(); i++) {
            if (l._left[i] != left[i]) {
                logger.error("Left array differs at index " + i.toString());
                logger.error("Expected: " + left.toString());
                logger.error("Actual: " + l._left.toString());
                return false;
            }
        }

        if (l._right.size() != right.size()) {
            logger.error("Right array is different size");
            logger.error("Expected: " + right.toString());
            logger.error("Actual: " + l._right.toString());
            return false;
        }
        for (var i = 0; i < right.size(); i++) {
            if (l._right[i] != right[i]) {
                logger.error("Right array differs at index " + i.toString());
                logger.error("Expected: " + right.toString());
                logger.error("Actual: " + l._right.toString());
                return false;
            }
        }

        return true;
    }

    function addAll(l as LxCalculatorLogic, str as String) {
        var c = str.toCharArray();
        for (var i = 0; i < c.size(); i++) {
            l.addChar(c[i]);
        }
    }

    module addChar {
        (:test)
        function addsChars(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "23");
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "23");
            return eq_l(logger, l, ['2', '3'], LX_OPERATOR_ADD, ['2', '3']);
        }

        (:test)
        function noDoubleDot(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "2.3.5");
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "2.3.5");
            return eq_l(logger, l, ['2', '.', '3', '5'], LX_OPERATOR_ADD, ['2', '.', '3', '5']);
        }

        (:test)
        function autoPrefixZero(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, ".3");
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, ".3");
            return eq_l(logger, l, ['0', '.', '3'], LX_OPERATOR_ADD, ['0', '.', '3']);
        }
    }

    module setOperator {
        (:test)
        function overwrite(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.addChar('1');
            l.setOperator(LX_OPERATOR_ADD);
            l.setOperator(LX_OPERATOR_SUBTRACT);
            return eq_l(logger, l, ['1'], LX_OPERATOR_SUBTRACT, []);
        }

        (:test)
        function calculate(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.addChar('1');
            l.setOperator(LX_OPERATOR_ADD);
            l.addChar('2');
            l.setOperator(LX_OPERATOR_ADD);
            return eq_l(logger, l, ['3'], LX_OPERATOR_ADD, []);
        }
    }

    module stripTrailingZeroes {
        (:test)
        function stripTrailingZeroes_Nop(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            return l.stripTrailingZeroes(['2', '.', '3']).toString().equals(['2', '.', '3'].toString());
        }

        (:test)
        function stripTrailingZeroes_Zeroes(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            return l.stripTrailingZeroes(['2', '.', '3', '0', '0']).toString().equals(['2', '.', '3'].toString());
        }

        (:test)
        function stripTrailingZeroes_Decimal(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            return l.stripTrailingZeroes(['1', '2', '.', '0']).toString().equals(['1', '2'].toString());
        }
    }

    module calculate {
        (:test)
        function noOperator(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.addChar('2');
            l.calculate();
            return eq_l(logger, l, ['2'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function add(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "1.5");
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "2.25");
            l.calculate();
            return eq_l(logger, l, ['3', '.', '7', '5'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function sub(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "1.5");
            l.setOperator(LX_OPERATOR_SUBTRACT);
            addAll(l, "2.25");
            l.calculate();
            return eq_l(logger, l, ['-', '0', '.', '7', '5'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function mul(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "1.5");
            l.setOperator(LX_OPERATOR_MULTIPLY);
            addAll(l, "2.25");
            l.calculate();
            return eq_l(logger, l, ['3', '.', '3', '7', '5'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function div(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "1.5");
            l.setOperator(LX_OPERATOR_DIVIDE);
            addAll(l, "2");
            l.calculate();
            return eq_l(logger, l, ['0', '.', '7', '5'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function pow(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "1.5");
            l.setOperator(LX_OPERATOR_POWER);
            addAll(l, "2");
            l.calculate();
            return eq_l(logger, l, ['2', '.', '2', '5'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function emptyOnZero(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.setOperator(LX_OPERATOR_MULTIPLY);
            l.calculate();
            l.addChar('1');
            return eq_l(logger, l, ['1'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function err_div0(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            // 0 / 0 (divide by zero)
            l.setOperator(LX_OPERATOR_DIVIDE);
            l.calculate();
            return l._errored;
        }

        (:test)
        function err_nan(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            // -1 ^ 0.5 (square root of a negative number)
            l.setOperator(LX_OPERATOR_SUBTRACT);
            l.addChar('1');
            l.setOperator(LX_OPERATOR_POWER);
            addAll(l, ".5");
            l.calculate();
            return l._errored;
        }
    }

    module format {
        (:test)
        function noOperator(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "12");
            return l.format().equals("12");
        }

        (:test)
        function add(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "12");
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "34");
            return l.format().equals("12 + 34");
        }
    }

    module delete {
        (:test)
        function left(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "123");
            l.delete();
            return eq_l(logger, l, ['1', '2'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function operator(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.addChar('1');
            l.setOperator(LX_OPERATOR_ADD);
            l.delete();
            return eq_l(logger, l, ['1'], LX_OPERATOR_NONE, []);
        }

        (:test)
        function right(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.addChar('1');
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "123");
            l.delete();
            return eq_l(logger, l, ['1'], LX_OPERATOR_ADD, ['1', '2']);
        }

        (:test)
        function clearZero_left(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "0.");
            l.delete();
            return eq_l(logger, l, [], LX_OPERATOR_NONE, []);
        }

        (:test)
        function clearZero_right(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.addChar('1');
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "0.");
            l.delete();
            return eq_l(logger, l, ['1'], LX_OPERATOR_ADD, []);
        }
    }

    module clearAll {
        (:test)
        function clears(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            addAll(l, "123");
            l.setOperator(LX_OPERATOR_ADD);
            addAll(l, "123");
            l.clearAll();
            return eq_l(logger, l, [], LX_OPERATOR_NONE, []);
        }

        (:test)
        function clear_err(logger as Logger) as Boolean {
            var l = new LxCalculatorLogic();
            l.setOperator(LX_OPERATOR_DIVIDE);
            l.calculate();
            l.clearAll();
            return !l._errored;
        }
    }
}
