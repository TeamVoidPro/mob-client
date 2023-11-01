

import 'Prediction.dart';

class PlacesAutoCompleteResponse {
  List<Prediction> predictions;

  PlacesAutoCompleteResponse({required this.predictions});

  factory PlacesAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    var list = json['predictions'] as List;
    List<Prediction> predictions = list.map((i) => Prediction.fromJson(i)).toList();

    return PlacesAutoCompleteResponse(
      predictions: predictions,
    );
  }
}