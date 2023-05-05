import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/providers/state_notifier_route.dart';
import 'package:parkrun_ar/models/section_number.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:parkrun_ar/widgets/nav_button.dart';
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
  Widget? trailing = const Icon(Icons.keyboard_arrow_down);
  late AnimationController _controller;
  late AnimationController _iconController;

  // When the duration of the ListTile animation is NOT provided. This value will be used instead.
  Duration defaultDuration = const Duration(milliseconds: 200);

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
    final List<String> listOfTitles =
        widget.section.mapMarkers.map((e) => e.title.toString()).toList();

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
            title: Text(
              widget.section.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            trailing: _trailingIcon(),
            onTap: () {
              setState(() {
                // Checks if the ListTile is expanded and sets state accordingly.
                if (_expanded) {
                  notifierState.setRoute("/");
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
            padding: const EdgeInsets.all(16),
            //decoration: BoxDecoration(
            //color: Colors.white,
            // border: Border.all(color: colorPrimary.withOpacity(1), width: 1.0)),
            child: Column(
                //dragStartBehavior: DragStartBehavior.down,
                //  physics: const ClampingScrollPhysics(), padding: const EdgeInsets.all(8.0),shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Signs to carry for this section",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  chipList(listOfTitles),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: NavButton(
                          route: notifierState.notifierRoute,
                          name: const Text("Continue with this section")),
                    ),
                  )
                ]),
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

  chipList(List<String> list) {
    //creates a list of chips for each sign
    final map = counter(list);
    list.sort();
    return Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: list.toSet().map((e) => _buildChip(e, map[e])).toList());
  }

  counter(list) {
    //A list of the titles of map markers, sorted i alphabetical order
    list.sort();

    //mapping the list of titles with a zero
    final Map<String, int> map = Map.fromIterables(
        list.toSet(), List<int>.filled(list.toSet().length, 0));
    //counting the number of occurence of each sign and save to the map
    for (var i = 0; i < list.length; i++) {
      List<String> marks = [
        'Höger',
        'Vänster',
        'Rakt fram',
        '1 km',
        '2 km',
        '3 km',
        '4 km'
      ];
      for (var j = 0; j < marks.length; j++) {
        if (list[i] == marks[j]) {
          map.update(marks[j],
              (value) => list.where((element) => element == marks[j]).length);
        }
      }
    }
    return map;
  }

  Widget _buildChip(String text, int nr) {
    return Chip(
      avatar: CircleAvatar(
        foregroundColor: colorSecondary,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: calculateIcon(text, nr),
      ),
      label: Text(
        text.toString(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  calculateIcon(text, nr) {
    if (text.contains('km')) {
      return const Icon(Icons.signpost_outlined);
    } else {
      return Text(nr.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
    }
  }
}
