import 'package:flutter/material.dart';

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.chevron_left),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              Navigator.defaultRouteName, ModalRoute.withName('/')),
        );
      },
    );
  }
}
