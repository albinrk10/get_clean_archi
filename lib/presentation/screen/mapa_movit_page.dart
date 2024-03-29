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

  double currentLocationLat = -11.915728408209805;
  double currentLocationLon = -77.05261230468751;

  double destinationLat = -12.113515738274808;
  double destinationLon = -77.02617645263673;

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
      // Add marker for start location (current location)
  markers.add(Marker(
    markerId: MarkerId('start'),
    position: LatLng(currentLocationLat, currentLocationLon), // replace with your current location coordinates
    infoWindow: InfoWindow(title: 'Start'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ));

  // Add marker for end location (destination)
  markers.add(Marker(
    markerId: MarkerId('end'),
    position: LatLng(destinationLat, destinationLon), // replace with your destination coordinates
    infoWindow: InfoWindow(title: 'End'),
     //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  ));
    for (var leg in selectedItinerary!.legs) {
      // Create a marker for the start and end of the leg
      markers.add(Marker(
        markerId: MarkerId('from_${leg.from.name}'),
        position: LatLng(leg.from.lat, leg.from.lon),
       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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
  return Scaffold(
    appBar: AppBar(
      title: Text('Map'),
      actions: [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              markers.clear();
              polylines.clear();
            });
          },
        ),
      ],
    ),
    body: selectedItinerary == null
        ? Center(child: Text('No itinerary selected'))
        : GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(selectedItinerary!.legs[0].from.lat,
                  selectedItinerary!.legs[0].from.lon),
              zoom: 14.0,
            ),
            markers: markers,
            polylines: polylines,
          ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.directions),
      onPressed: () {
        showItineraryDialog(context, widget.movit.content.plan.itineraries);
      },
    ),
    
  );
}
}
