import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:provider/provider.dart';

import '../models/stepper_notifier_model.dart';

class CurrentStep extends StatefulWidget {
  // takes in a marker and also the total amount of markers

  const CurrentStep({super.key});

  @override
  State<CurrentStep> createState() => _CurrentStepState();
}

class _CurrentStepState extends State<CurrentStep> {
  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierModel>();
    return SizedBox(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Shows which step currently is at will have state once state management is in place
         const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Current step",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${notifierState.counter + 1 } / ${notifierState.notifierMarker.length.toString()} ',
              style: const TextStyle(
                  fontSize: 24, color: Color.fromRGBO(137, 137, 137, 100)),
            ),
          ),
        ],
      ),
      // Title of the current step
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Row(
                children: [
                  Text(
                      notifierState.notifierMarker[notifierState.counter].title,
                      style: Theme.of(context).textTheme.displaySmall),
                      ],
              )
                  )
        ],
      ),

      // Marker icon
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
               
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [colorPrimaryLight,colorPrimary],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                notifierState.notifierMarker[notifierState.counter].markerIcon,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),

          // Description of the current step
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notifierState.notifierMarker[notifierState.counter].description,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      // Buttons with AR and show pictures 
      //disabled for now
      const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(onPressed: null, child: Text("show photo")),
        ElevatedButton( onPressed: null, child: Text("show AR"))
      ])
    ]));
  }
}
