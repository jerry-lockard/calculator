import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:calculator/models/input_type.dart';
import 'package:calculator/services/remote_config_service.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorViewModel extends ChangeNotifier {
  final RemoteConfigService _remoteConfig;
  String _inputExpression = '';
  double result = 0;

  CalculatorViewModel(this._remoteConfig);

  String get inputHeaderText => _inputExpression.isEmpty
      ? _doubleToDisplayText(result)
      : _convertOperatorForDisplay(_inputExpression);

  bool get _canAddExpression =>
      _inputExpression.length < _remoteConfig.maxInputLength;

  /// Handles input button press.
  ///
  /// [inputType] is the type of input button that was pressed.
  ///
  /// [onTextOverflow] is a callback that will be called if the expression
  /// exceeds the maximum length allowed.
  ///
  /// The method will update [inputHeaderText] accordingly.
  ///
  /// The method will also notify the listeners if the state has changed.
  void onPressButton({
    required InputType inputType,
    required VoidCallback onTextOverflow,
  }) {
    switch (inputType) {
      case InputType.number0:
      case InputType.number1:
      case InputType.number2:
      case InputType.number3:
      case InputType.number4:
      case InputType.number5:
      case InputType.number6:
      case InputType.number7:
      case InputType.number8:
      case InputType.number9:
        var number = inputType.name.replaceFirst('number', '');
        return _onAddExpression(input: number, onTextOverflow: onTextOverflow);
      case InputType.point:
        return _onAddExpression(input: '.', onTextOverflow: onTextOverflow);
      case InputType.addition:
        return _onAddExpression(input: '+', onTextOverflow: onTextOverflow);
      case InputType.subtraction:
        return _onAddExpression(input: '-', onTextOverflow: onTextOverflow);
      case InputType.multiplication:
        return _onAddExpression(input: '*', onTextOverflow: onTextOverflow);
      case InputType.division:
        return _onAddExpression(input: '/', onTextOverflow: onTextOverflow);
      case InputType.percent:
        return _onAddExpression(input: '%', onTextOverflow: onTextOverflow);
      case InputType.equality:
        return _onPressEquality();
      case InputType.clear:
        return _onPressClear();
      case InputType.delete:
        return _onPressDelete();
    }
  }

  /// Adds an expression to the input expression.
  ///
  /// [input] is the expression to add.
  ///
  /// [onTextOverflow] is a callback that will be called if the expression
  /// exceeds the maximum length allowed.
  ///
  /// The method will update [inputHeaderText] accordingly.
  ///
  /// The method will also notify the listeners if the state has changed.
  ///
  /// If [input] is not a number and the last input was not a number, the method
  /// will replace the last input with [input].
  ///
  /// If the expression exceeds the maximum length allowed, the method will call
  /// [onTextOverflow].
  ///
  /// If the expression is '0', the method will replace it with an empty string.
  void _onAddExpression({
    required String input,
    required VoidCallback onTextOverflow,
  }) {
    if (!_isNumber(input) && !_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1) + input;
      notifyListeners();
      return;
    }

    if (!_canAddExpression) {
      onTextOverflow.call();
      return;
    }

    if (_inputExpression == '0') {
      _inputExpression = '';
    }

    _inputExpression += input;
    notifyListeners();
  }

  bool get _isLastInputNumber {
    if (_inputExpression.isEmpty) {
      return false;
    }

    var lastInput = _inputExpression[_inputExpression.length - 1];
    return _isNumber(lastInput);
  }

  /// Replaces mathematical operators with their corresponding Unicode
  /// characters for display purposes.
  ///
  /// For example, '*' is replaced with '×' and '/' is replaced with '÷'.
  ///
  /// [expression] is the expression to replace the operators in.
  ///
  /// Returns the expression with the operators replaced.
  String _convertOperatorForDisplay(String expression) {
    expression = expression.replaceAll('*', '×');
    expression = expression.replaceAll('/', '÷');
    return expression;
  }

  /// Returns true if [input] is a number, false otherwise.
  ///
  /// A number is defined as a string that can be parsed into an integer.
  ///
  /// For example, '123' is a number, but 'a' is not.
  bool _isNumber(String input) {
    return int.tryParse(input) != null;
  }

  /// Resets the expression and the result to their initial values.
  ///
  /// This method is called when the 'C' button is pressed.
  ///
  /// The method also notifies the listeners of the state change.
  void _onPressClear() {
    _inputExpression = '';
    result = 0;
    notifyListeners();
  }

  /// Deletes the last character of the expression.
  ///
  /// This method is called when the 'DEL' button is pressed.
  ///
  /// The method also notifies the listeners of the state change.
  void _onPressDelete() {
    _inputExpression =
        _inputExpression.substring(0, _inputExpression.length - 1);
    result = 0;
    notifyListeners();
  }

  /// Handles the 'Equality' button press.
  ///
  /// If the last input was not a number, the method will delete the last
  /// character of the expression.
  ///
  /// The method will then update the expression and notify the listeners of
  /// the state change.
  void _onPressEquality() {
    if (!_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1);
    }

    _updateExpression();
  }

  /// Updates the expression and result by evaluating the current expression
  /// using the [math_expressions] library.
  ///
  /// If the expression is invalid, the method will log the error and leave the
  /// state unchanged.
  ///
  /// The method will also notify the listeners of the state change.
  void _updateExpression() {
    try {
      Expression exp = Parser().parse(_inputExpression);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      result = eval;
      _inputExpression = _doubleToDisplayText(result);
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  /// Converts a double to a string with a limited number of decimal places.
  ///
  /// If [value] is an integer, the method will return the integer as a string.
  ///
  /// If [value] is not an integer, the method will return the string
  /// representation of [value] with a maximum of
  /// [RemoteConfig.maxDecimalLength] decimal places.
  String _doubleToDisplayText(double value) {
    if (value.truncateToDouble() == value) {
      return value.truncate().toString();
    } else {
      var text = value.toString();
      var decimalIndex = text.indexOf('.');
      var decimalLength = text.length - decimalIndex - 1;
      if (decimalLength > _remoteConfig.maxDecimalLength) {
        text = value.toStringAsFixed(_remoteConfig.maxDecimalLength);
      }
      return text;
    }
  }
}
