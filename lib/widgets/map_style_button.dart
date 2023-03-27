import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkrun_ar/env/env.dart';

class MapStyleSwitcherButton extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const MapStyleSwitcherButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _MapStyleSwitcherButtonState createState() => _MapStyleSwitcherButtonState();
}

class _MapStyleSwitcherButtonState extends State<MapStyleSwitcherButton> {
  String _currentStyle = 'mapbox/streets-v11';
  final _styles = {
    'mapbox/streets-v11': 'Streets',
    'mapbox/satellite-v9': 'Satellite',
  };

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentStyle = _currentStyle == 'mapbox/streets-v11'
              ? 'mapbox/satellite-v9'
              : 'mapbox/streets-v11';
        });
        widget.onChanged(_currentStyle);
      },
      child: Text(
        'Switch to ${_styles[_currentStyle]}',
      ),
    );
  }
}
