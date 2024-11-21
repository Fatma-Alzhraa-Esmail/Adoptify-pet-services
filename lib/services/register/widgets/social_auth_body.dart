import 'package:peto_care/services/register/widgets/facebook_auth_widget.dart';
import 'package:peto_care/services/register/widgets/google_auth_widget.dart';
import 'package:flutter/material.dart';

class SocialAuthBody extends StatelessWidget {
  const SocialAuthBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: GoogleAuthWidget()),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: FacebookAuthWidget())
          ],
        ),
      ),
    );
  }
}

