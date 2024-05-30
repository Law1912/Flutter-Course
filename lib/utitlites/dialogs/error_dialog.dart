import 'package:flutter/material.dart';
import 'package:free_code_camp/utitlites/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An Error Occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
