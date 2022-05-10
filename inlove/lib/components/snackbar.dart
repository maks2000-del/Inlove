import 'package:flutter/material.dart';

void snackBar({
  required BuildContext context,
  required String snackbarsText,
  required String snackbarsActionButtonLabe,
  required String snackbarsAction,
  required String snackbarsButtonLable,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(snackbarsText),
      action: SnackBarAction(
        label: snackbarsActionButtonLabe,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarsAction),
            ),
          );
        },
      ),
    ),
  );
}
