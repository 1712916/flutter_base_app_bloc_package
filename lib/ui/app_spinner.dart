import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/resources/view_size/spacing.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  const Center(
      child: const SizedBox(
        height: ViewSize.size_24,
        width: ViewSize.size_24,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }
}
