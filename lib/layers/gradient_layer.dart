
import 'package:flutter/material.dart';

class GradientLayer extends StatelessWidget {
  const GradientLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.1),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}
