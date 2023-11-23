import 'package:flutter/cupertino.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';

class Validator {
  static bool isValidated({
    required List<FormItem> items,
    required IFlutterNavigator navigator,
  }) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].text.isEmpty) {
        FocusTo(focusNode: items[i].focusNode, navigator: navigator);
        return false;
      }
    }
    return true;
  }
}

class FormItem {
  const FormItem({required this.text, required this.focusNode});
  final String text;
  final FocusNode focusNode;
}

class FocusTo {
  FocusTo({required this.focusNode, required this.navigator}) {
    FocusScope.of(navigator.context).requestFocus(focusNode);
  }
  final FocusNode focusNode;
  final IFlutterNavigator navigator;
}
