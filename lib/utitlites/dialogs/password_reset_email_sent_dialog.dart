import 'package:flutter/material.dart';
import 'package:free_code_camp/utitlites/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'We have sent your password reset link. Please chack your email for more information',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
