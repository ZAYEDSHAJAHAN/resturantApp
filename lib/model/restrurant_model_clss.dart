// To parse this JSON data, do
//
//     final restaurants = restaurantsFromJson(jsonString);

import 'dart:convert';

Restaurants restaurantsFromJson(String str) =>
    Restaurants.fromJson(json.decode(str));

String restaurantsToJson(Restaurants data) => json.encode(data.toJson());

class Restaurants {
  List<Restaurant> restaurants;

  Restaurants({
    required this.restaurants,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  int id;
  String name;
  String neighborhood;
  String photograph;
  String address;
  Latlng latlng;
  String cuisineType;
  OperatingHours operatingHours;
  List<Review> reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.neighborhood,
    required this.photograph,
    required this.address,
    required this.latlng,
    required this.cuisineType,
    required this.operatingHours,
    required this.reviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        neighborhood: json["neighborhood"],
        photograph: json["photograph"],
        address: json["address"],
        latlng: Latlng.fromJson(json["latlng"]),
        cuisineType: json["cuisine_type"],
        operatingHours: OperatingHours.fromJson(json["operating_hours"]),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "neighborhood": neighborhood,
        "photograph": photograph,
        "address": address,
        "latlng": latlng.toJson(),
        "cuisine_type": cuisineType,
        "operating_hours": operatingHours.toJson(),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Latlng {
  double lat;
  double lng;

  Latlng({
    required this.lat,
    required this.lng,
  });

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class OperatingHours {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  OperatingHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
        monday: json["Monday"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thursday: json["Thursday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
        sunday: json["Sunday"],
      );

  Map<String, dynamic> toJson() => {
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
      };
}

class Review {
  String name;
  String date;
  int rating;
  String comments;

  Review({
    required this.name,
    required this.date,
    required this.rating,
    required this.comments,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        date: json["date"],
        rating: json["rating"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "rating": rating,
        "comments": comments,
      };
}
