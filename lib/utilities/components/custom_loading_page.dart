import 'package:flutter/material.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
