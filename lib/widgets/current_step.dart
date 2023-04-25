import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/providers/state_notifier_instructions.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:provider/provider.dart';

class CurrentStep extends StatefulWidget {
  const CurrentStep({super.key});

  @override
  State<CurrentStep> createState() => _CurrentStepState();
}

class _CurrentStepState extends State<CurrentStep> {
  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierInstruction>();
    final currentMarker = notifierState.notifierMarker[notifierState.counter];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: () => notifierState.goBack(),
              child: const Text("go back"),
            ),
            const Text(
              "Current Sign",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            OutlinedButton(
              onPressed: () => notifierState.increment(),
              child: const Text("next Sign"),
            ),
          ],
        ),
        Row(
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
                  notifierState
                      .notifierMarker[notifierState.counter].markerIcon,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notifierState.notifierMarker[notifierState.counter].title,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    notifierState
                        .notifierMarker[notifierState.counter].description,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${notifierState.counter + 1} / ${notifierState.notifierMarker.length.toString()} ',
                style: const TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(137, 137, 137, 100),
                ),
              ),
            ),
          ],
        ),
        Row(
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
              onPressed: () => null,
              child: const Text('use AR'),
            ),
          ],
        ),
      ],
    );
  }
}
