import 'package:flutter/material.dart';
import 'package:inlove/models/entities/short_user.dart';
import 'package:inlove/pages/tabs/settings/settings_cubit.dart';

Widget autocompleteTextfield(List<ShortUser> options, SettingsCubit cubit) {
  final names = <String>[];
  for (final user in options) {
    names.add(user.name);
  }
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      }
      return names.where((String option) {
        return option.contains(textEditingValue.text.toLowerCase());
      });
    },
    onSelected: (String selection) {
      for (final user in options) {
        if (user.name == selection) cubit.setParthnerId(user.id);
      }
      debugPrint('You just selected $selection:');
    },
  );
}
