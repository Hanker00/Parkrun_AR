import 'package:flutter/material.dart';

class LicenseButton extends StatelessWidget {
  const LicenseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 102, 102, 102)),
          borderRadius: BorderRadius.circular(20.0)),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/license');
        },
        child: Text(
          "Licenses",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}