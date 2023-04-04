import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/providers/StateNotifierRoute.dart';
import 'package:parkrun_ar/models/section_number.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:parkrun_ar/widgets/NavButton.dart';
import 'package:provider/provider.dart';

class DropDownItem extends StatefulWidget {
  final SectionNumber section;
  const DropDownItem({super.key, required this.section});

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem>
    with TickerProviderStateMixin {
  late bool _expanded;
  Color backgroundColor = Colors.white;
  bool? _rotateTrailing;
  bool? _noTrailing;
  Widget? trailing = Icon(Icons.keyboard_arrow_down);
  late AnimationController _controller;
  late AnimationController _iconController;


  // When the duration of the ListTile animation is NOT provided. This value will be used instead.
  Duration defaultDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _expanded = false;
    _rotateTrailing = true;
    _controller = AnimationController(vsync: this, duration: defaultDuration);
    _controller.forward();
    _iconController =
        AnimationController(duration: defaultDuration, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _iconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierRoute>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
            tileColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(color: colorPrimary, width: 2.0)),
            title: Text(widget.section.title, style: Theme.of(context).textTheme.displayMedium,),
           
            trailing: _trailingIcon(),
            onTap: () {
              setState(() {
                // Checks if the ListTile is expanded and sets state accordingly.
                if (_expanded) {
                  notifierState.setRoute("");
                  backgroundColor = Colors.white;
                  _expanded = !_expanded;
                  _controller.forward();
                  _iconController.reverse();
                } else {
                  notifierState.setRoute(widget.section.route);
                  backgroundColor = colorPrimary;
                  _expanded = !_expanded;
                  _controller.reverse();
                  _iconController.forward();
                }
              });
            }),
        AnimatedCrossFade(
          firstCurve: Curves.fastLinearToSlowEaseIn,
          secondCurve: Curves.fastLinearToSlowEaseIn,
          crossFadeState:
              _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: defaultDuration,
          firstChild: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: colorPrimary, width: 1.0)),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: <Widget> [Column(children: 
              widget.section.mapMarkers.map((e) => 
              Text(e.title, style: Theme.of(context).textTheme.displaySmall,)
                ).toList() 
            ),NavButton(route: notifierState.notifierRoute, name: Text("Continue"))]
            ),
          ),
          secondChild: Container(),
        )
      ],
    );
  }
  Widget? _trailingIcon() {
    if (trailing != null) {
      if (_rotateTrailing!) {
        return RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(_iconController),
            child: trailing);
      } else {
        // If developer sets rotateTrailing to false the widget will just be returned.
        return trailing;
      }
    } else {
      // Default trailing is an Animated Menu Icon.
      return AnimatedIcon(
          icon: AnimatedIcons.close_menu, progress: _controller);
    }
  }
}
