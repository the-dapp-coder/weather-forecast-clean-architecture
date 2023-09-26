import 'package:equatable/equatable.dart';

class LocationDataModel extends Equatable {
  final String? city;
  final String longitude;
  final String latitude;
  final String? country;
  const LocationDataModel({
    required this.latitude,
    required this.longitude,
    this.city,
    this.country,
  });

  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      city: json['name'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  @override
  List<Object?> get props => [];
}
