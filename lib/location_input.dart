// import 'package:advantureing_app/screen/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../locatioin_helper.dart';
import 'map_screen.dart';

class LocationInput extends StatefulWidget {
  // final Function onSelectPlace;

  LocationInput();

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude as double, locData.longitude as double);
      // widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelected: true,
          latitude: locData.latitude as double,
          longitude: locData.longitude as double,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print("::::::::: test 1");
    print(selectedLocation.latitude);
    print(selectedLocation.longitude);
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    // widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.green)),
            child: _previewImageUrl == null
                ? const Text(
                    'No Location Is Chosen...!',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                // textColor: Theme.of(context).colorScheme.primary,
                label: const Text('Current Location'),
              ),
              TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select on Map'),
              )
            ],
          )
        ],
      ),
    );
  }
}