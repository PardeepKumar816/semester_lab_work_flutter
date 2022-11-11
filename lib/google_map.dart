import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: '19SW37',
          snippet: 'Coordinates(20.42796133580664, 75.885749655962)',
        )),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        title: Text("GoogleMaps"),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          //  compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print("${value.latitude} ${value.longitude}");

            List<Placemark> addresses =
                await placemarkFromCoordinates(value.latitude, value.longitude);

            _markers.add(Marker(
              markerId: const MarkerId("2"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                title: addresses.first.street,
              ),
            ));
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
