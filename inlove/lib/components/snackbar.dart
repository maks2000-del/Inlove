import 'package:flutter/material.dart';

Widget snackBar({
  required BuildContext context,
  required String snackbarsText,
  required String snackbarsActionButtonLabe,
  required String snackbarsAction,
  required String snackbarsButtonLable,
}) {
  return ElevatedButton(
    onPressed: () {
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
    },
    child: Text(snackbarsButtonLable),
  );
}
