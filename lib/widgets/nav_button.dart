import "package:flutter/material.dart";

class NavButton extends StatelessWidget {
  final String route;
  final Text name;

  const NavButton({
    super.key,
    required this.route,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
      child: name,
    );
  }
}
