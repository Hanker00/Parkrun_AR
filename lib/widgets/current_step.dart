import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/providers/state_notifier_instructions.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:parkrun_ar/screens/launch_screen.dart';
import 'package:parkrun_ar/widgets/nav_button.dart';
import 'package:parkrun_ar/models/basic_ar_geolocation_android.dart';
import 'package:provider/provider.dart';

class CurrentStep extends StatefulWidget {
  // takes in a marker and also the total amount of markers
  const CurrentStep({super.key});

  @override
  State<CurrentStep> createState() => _CurrentStepState();
}

class _CurrentStepState extends State<CurrentStep> {
  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierInstruction>();

    if (notifierState.counter == notifierState.notifierMarker.length - 1) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                  onPressed: () => notifierState.goBack(),
                  child: const Text("Go back")),
              const Text("There are no more signs")
            ],
          ),
          returnToHomeScreen(notifierState, context)
        ],
      );
    }
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
              onPressed: () => notifierState.goBack(),
              child: const Text("Go back")),
          const Text(
            "Current Sign",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          OutlinedButton(
              onPressed: () => notifierState.goForward(),
              child: const Text("Next Sign")),
        ],
      ),
      markersDescription(notifierState, context),
      showPhotoAndAr(notifierState, context)
    ]);
  }

  Row markersDescription(
      StateNotifierInstruction notifierState, BuildContext context) {
    return Row(
        //icon||description | 1/8
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [colorPrimaryLight, colorPrimary],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(
                notifierState.notifierMarker[notifierState.counter].markerIcon,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),

          //title of current sign and the description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notifierState.notifierMarker[notifierState.counter].title,
                    style: Theme.of(context).textTheme.displayMedium),
                Text(
                    notifierState
                        .notifierMarker[notifierState.counter].description,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Builder(builder: (context) {
                return Text(
                  '${notifierState.counter + 1} / ${notifierState.notifierMarker.length.toString()} ',
                  style: const TextStyle(
                      fontSize: 24, color: Color.fromRGBO(137, 137, 137, 100)),
                );
              }))
        ]);
  }

  Row returnToHomeScreen(
      //When the there are no markers left, the buttons will change to a single one
      StateNotifierInstruction notifierState,
      BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              Navigator.defaultRouteName, ModalRoute.withName('/')),
          child: const Text("Return to start screen"))
    ]);
  }
}

Row showPhotoAndAr(
    StateNotifierInstruction notifierState, BuildContext context) {
  final currentMarker = notifierState.notifierMarker[notifierState.counter];

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Marker Photo'),
              content: Image.asset(
                currentMarker.imagePath,
                fit: BoxFit.cover,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        child: const Text('Show photo'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BasicArGeolocation(
                  flag: notifierState.notifierMarker[notifierState.counter]),
            ),
          );
        },
        child: const Text('Use AR'),
      ),
    ],
  );
}
