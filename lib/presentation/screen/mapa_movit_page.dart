import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../domain/models/movit/movit.dart';

class MapScreen extends StatefulWidget {
  final Movit movit;

  MapScreen({required this.movit});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Itinerary? selectedItinerary;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showItineraryDialog(context, widget.movit.content.plan.itineraries);
    });
  }

  void showItineraryDialog(BuildContext context, List<Itinerary> itineraries) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('eligue tu ruta ideal 🚌'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: itineraries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Itinerary ${index + 1}'),
                  onTap: () {
                    setState(() {
                      selectedItinerary = itineraries[index];
                      _createMarkersAndPolylines();
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _createMarkersAndPolylines() {
    markers.clear();
    polylines.clear();
    for (var leg in selectedItinerary!.legs) {
      // Create a marker for the start and end of the leg
      markers.add(Marker(
        markerId: MarkerId('from_${leg.from.name}'),
        position: LatLng(leg.from.lat, leg.from.lon),
      ));
      markers.add(Marker(
        markerId: MarkerId('to_${leg.to.name}'),
        position: LatLng(leg.to.lat, leg.to.lon),
      ));

      // Decode the polyline points
      List<PointLatLng> decodedPoints =
          PolylinePoints().decodePolyline(leg.legGeometry.points);

      // Create a polyline for the leg
      polylines.add(Polyline(
        polylineId: PolylineId('leg_${leg.route}'),
        points: decodedPoints
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
        color: leg.mode == Mode.BUS ? Colors.green : Colors.black,
        width: 3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return selectedItinerary == null
        ? const Center(child: Text('No itinerary selected'))
        : GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(selectedItinerary!.legs[0].from.lat,
                  selectedItinerary!.legs[0].from.lon),
              zoom: 14.0,
            ),
            markers: markers,
            polylines: polylines,
          );
  }
}
