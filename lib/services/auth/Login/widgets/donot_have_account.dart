import 'package:flutter/material.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';

class DonotHaveAccountWidget extends StatelessWidget {
  const DonotHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You don\'t have account? ',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              // decoration: TextDecoration.underline,
            ),
          ),
          GestureDetector(
            onTap: () {
              CustomNavigator.push(Routes.register);
            },
            child: Text(
              'Sign Up ',
              style: TextStyle(
                color: Colors.amber[600],
                fontWeight: FontWeight.w600,
                fontSize: 17,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ]);
  }
}
