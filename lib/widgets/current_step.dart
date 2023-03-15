import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';

class CurrentStep extends StatelessWidget {
  final MapMarker currentSign;
  final int totalMarkers;
  const CurrentStep(
      {super.key, required this.currentSign, required this.totalMarkers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Current step",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "${4}/${6}",
                  style: TextStyle(
                      fontSize: 24, color: Color.fromRGBO(137, 137, 137, 100)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                currentSign.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
            ],
          ),
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
                    currentSign.markerIcon,
                    size: 50,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentSign.description,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
