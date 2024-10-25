class TouristRoute {
  final String routeId;
  final String routeName;
  final List<PointOfInterest> pointsOfInterest;
  final List<Suggestion>? suggestions;

  TouristRoute({
    required this.routeId,
    required this.routeName,
    required this.pointsOfInterest,
    this.suggestions,
  });
}

class PointOfInterest {
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  PointOfInterest({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}

class Suggestion {
  final String name;
  final String type; // e.g., restaurant, shop, rest area
  final double latitude;
  final double longitude;

  Suggestion({
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
  });
}
