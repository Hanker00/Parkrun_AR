import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/stepper_notifier_model.dart';
import 'image_viwe.dart';

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
    final currentMarker = notifierState.notifierMarker[notifierState.counter];
    return SizedBox(
      child: Column(
        children: [
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
                // Will be dynamic in the future
                child: Text(
                  "${notifierState.counter + 1}/${notifierState.notifierMarker.length}",
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
                  child: Text(
                notifierState.notifierMarker[notifierState.counter].title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
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
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    notifierState
                        .notifierMarker[notifierState.counter].markerIcon,
                    size: 50,
                  ),
                ),
              ),

              // Description of the current step
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    notifierState
                        .notifierMarker[notifierState.counter].description,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyImagePage(
                          imagePath: currentMarker.imagePath,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(255, 204, 114, 100)),
                  ),
                  child: const Text("Show pictures",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(255, 204, 114, 100)),
                  ),
                  child: const Text("Show AR",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
