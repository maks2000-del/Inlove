import 'package:flutter/material.dart';

Widget autocompleteTextfield(List<String> options) {
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      }
      return options.where((String option) {
        return option.contains(textEditingValue.text.toLowerCase());
      });
    },
    onSelected: (String selection) {
      debugPrint('You just selected $selection');
    },
  );
}
