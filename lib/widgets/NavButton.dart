import "package:flutter/material.dart";

class NavButton extends StatelessWidget {
  final Widget route;
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: name,
    );
  }
}
