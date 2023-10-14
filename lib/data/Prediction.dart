


class Prediction {
  final String description; // The name or description of the place
  final String placeId;    // A unique identifier for the place

  Prediction({
    required this.description,
    required this.placeId,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
    );
  }
}
