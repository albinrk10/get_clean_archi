// To parse this JSON data, do
//
//     final movit = movitFromJson(jsonString);

import 'dart:convert';

Movit movitFromJson(String str) => Movit.fromJson(json.decode(str));

String movitToJson(Movit data) => json.encode(data.toJson());

class Movit {
    final Content content;
    final bool isValid;
    final List<dynamic> exceptions;

    Movit({
        required this.content,
        required this.isValid,
        required this.exceptions,
    });

    factory Movit.fromJson(Map<String, dynamic> json) => Movit(
        content: Content.fromJson(json["content"]),
        isValid: json["isValid"],
        exceptions: List<dynamic>.from(json["exceptions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "content": content.toJson(),
        "isValid": isValid,
        "exceptions": List<dynamic>.from(exceptions.map((x) => x)),
    };
}

class Content {
    final Plan plan;

    Content({
        required this.plan,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        plan: Plan.fromJson(json["plan"]),
    );

    Map<String, dynamic> toJson() => {
        "plan": plan.toJson(),
    };
}

class Plan {
    final List<Itinerary> itineraries;

    Plan({
        required this.itineraries,
    });

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        itineraries: List<Itinerary>.from(json["itineraries"].map((x) => Itinerary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "itineraries": List<dynamic>.from(itineraries.map((x) => x.toJson())),
    };
}

class Itinerary {
    final List<Leg> legs;

    Itinerary({
        required this.legs,
    });

    factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
    };
}

class Leg {
    final Mode mode;
    final LegGeometry legGeometry;
    final String route;
    final String? agencyName;
    final String? routeShortName;
    final From from;
    final From to;

    Leg({
        required this.mode,
        required this.legGeometry,
        required this.route,
        required this.agencyName,
        required this.routeShortName,
        required this.from,
        required this.to,
    });

    factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        mode: modeValues.map[json["mode"]]!,
        legGeometry: LegGeometry.fromJson(json["legGeometry"]),
        route: json["route"],
        agencyName: json["agencyName"],
        routeShortName: json["routeShortName"],
        from: From.fromJson(json["from"]),
        to: From.fromJson(json["to"]),
    );

    Map<String, dynamic> toJson() => {
        "mode": modeValues.reverse[mode],
        "legGeometry": legGeometry.toJson(),
        "route": route,
        "agencyName": agencyName,
        "routeShortName": routeShortName,
        "from": from.toJson(),
        "to": to.toJson(),
    };
}

class From {
    final String name;
    final double lon;
    final double lat;
    final VertexType vertexType;

    From({
        required this.name,
        required this.lon,
        required this.lat,
        required this.vertexType,
    });

    factory From.fromJson(Map<String, dynamic> json) => From(
        name: json["name"],
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        vertexType: vertexTypeValues.map[json["vertexType"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lon": lon,
        "lat": lat,
        "vertexType": vertexTypeValues.reverse[vertexType],
    };
}

enum VertexType {
    NORMAL,
    TRANSIT
}

final vertexTypeValues = EnumValues({
    "NORMAL": VertexType.NORMAL,
    "TRANSIT": VertexType.TRANSIT
});

class LegGeometry {
    final String points;

    LegGeometry({
        required this.points,
    });

    factory LegGeometry.fromJson(Map<String, dynamic> json) => LegGeometry(
        points: json["points"],
    );

    Map<String, dynamic> toJson() => {
        "points": points,
    };
}

enum Mode {
    BUS,
    WALK
}

final modeValues = EnumValues({
    "BUS": Mode.BUS,
    "WALK": Mode.WALK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
