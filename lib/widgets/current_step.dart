import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:parkrun_ar/widgets/NavButton.dart';
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
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //button to go back a step, to previous sign
          TextButton(onPressed: () => null, child: Text("go back")),
          // Shows which step currently is at will have state once state management is in place
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Current Sign",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${notifierState.counter + 1} / ${notifierState.notifierMarker.length.toString()} ',
              style: const TextStyle(
                  fontSize: 24, color: Color.fromRGBO(137, 137, 137, 100)),
            ),
          ),
          //button to go to next sign
          ElevatedButton(onPressed: ()=> null, child: Text("next Sign")),
        ],
      ),

      // Marker icon for current sign
      Row(
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
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                notifierState.notifierMarker[notifierState.counter].markerIcon,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          
          //title of current sign and the description
          Column(
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
        ],
        
      ),
      // Buttons with AR and show pictures, inactive for now
       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(onPressed: () => null, child: Text("Show photo")),
        ElevatedButton(onPressed: ()=> null, child: Text("use AR"), ),
      ])
    ]);
    
  } 
}
