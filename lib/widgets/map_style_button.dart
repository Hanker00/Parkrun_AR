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

class MapExample extends StatefulWidget {
  const MapExample({Key? key}) : super(key: key);

  @override
  _MapExampleState createState() => _MapExampleState();
}

class _MapExampleState extends State<MapExample> {
  String _currentStyle = 'mapbox/streets-v11';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Style Switcher Example'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.7749, -122.4194),
          zoom: 12.0,
          plugins: [
            // Add the MapBox plugin
          ],
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: {
              'accessToken': Env.mapkey,
              'id': _currentStyle,
            },
          ),
        ],
      ),
      floatingActionButton: MapStyleSwitcherButton(
        onChanged: (style) {
          setState(() {
            _currentStyle = style;
          });
        },
      ),
    );
  }
}
