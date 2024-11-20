import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:flutter/material.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'You have account? ',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              // decoration: TextDecoration.underline,
            ),
          ),
          GestureDetector(
            onTap: () {
              CustomNavigator.push(Routes.login);
            },
            child: Text(
              'Sign In ',
              style: TextStyle(
                color: Colors.amber[600],
                fontWeight: FontWeight.w600,
                fontSize: 17,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

