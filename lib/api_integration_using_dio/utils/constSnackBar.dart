import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showCustomSnackBar(context) => showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.error(
        message: "Something went wrong,please check your credentials!!!"));
//we can create same method for some other error messages or info's also
//we are just creating as method by passing context