import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Container(
          height: 60,
            width: 60,
            child: CircularProgressIndicator()),
      ),
    );
  }
}
