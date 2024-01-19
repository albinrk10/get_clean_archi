import 'package:clean_arch_get/domain/models/movit/movit.dart';
import 'package:flutter/material.dart';

class Movitgape extends StatelessWidget {
  final Future<Movit> movit;
  const Movitgape({super.key, required this.movit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movitgape 🚌')),
      body: FutureBuilder<Movit>(
        future: movit, // function to fetch Movit data
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.content.plan.itineraries.length,
              itemBuilder: (context, index) {
                final itinerary =
                    snapshot.data!.content.plan.itineraries[index];
                return ExpansionTile(
                  title: Text('Itinerary ${index + 1}'),
                  children: itinerary.legs.map((leg) {
                    return ExpansionTile(
                      title: Text('Leg: ${leg.mode}'),
                      children: <Widget>[
                        Text('Route: ${leg.route}'),
                        Text('Agency Name: ${leg.agencyName ?? 'N/A'}'),
                        Text(
                            'Route Short Name: ${leg.routeShortName ?? 'N/A'}'),
                        Text('From: ${leg.from.name}'),
                        Text('To: ${leg.to.name}'),
                        Text('From Longitude: ${leg.from.lon}'),
                        Text('From Latitude: ${leg.from.lat}'),
                        Text('To Longitude: ${leg.to.lon}'),
                        Text('To Latitude: ${leg.to.lat}'),
                        Text('Leg Geometry Points: ${leg.legGeometry.points}'),
                      ],
                    );
                  }).toList(),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
