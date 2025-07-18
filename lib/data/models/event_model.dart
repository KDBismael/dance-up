import 'package:dance_up/data/entities/event.dart';

enum EventType {
  all,
  past,
  upcoming;

  String description() {
    switch (this) {
      case EventType.all:
        return "All";
      case EventType.past:
        return "Past";
      case EventType.upcoming:
        return "Upcoming";
      default:
        throw "Error";
    }
  }
}

enum DanceStyle {
  salsa,
  batchata,
  kizomba,
  twoSteps,
  country,
  tango;

  String description() {
    switch (this) {
      case DanceStyle.salsa:
        return "Salsa";
      case DanceStyle.batchata:
        return "Batchata";
      case DanceStyle.kizomba:
        return "Kizomba";
      case DanceStyle.country:
        return "Country";
      case DanceStyle.twoSteps:
        return "Two Steps";
      case DanceStyle.tango:
        return "Tango";
      default:
        throw "Error";
    }
  }
}

enum Price {
  free,
  paid;

  String description() {
    switch (this) {
      case Price.free:
        return "Free";
      case Price.paid:
        return "Paid";

      default:
        throw "Error";
    }
  }
}

enum EventTag {
  chill,
  energetic,
  liveMusic,
  touristy,
  cultural;

  String description() {
    switch (this) {
      case EventTag.chill:
        return "Chill";
      case EventTag.energetic:
        return "Energetic";
      case EventTag.liveMusic:
        return "Live music";
      case EventTag.touristy:
        return "Touristy";
      case EventTag.cultural:
        return "Cultural";
    }
  }
}

enum DancePosition {
  indoor,
  outdoor;

  String description() {
    switch (this) {
      case DancePosition.indoor:
        return "Indoor";
      case DancePosition.outdoor:
        return "Outdoor";

      default:
        throw "Error";
    }
  }
}

enum DanceLevel {
  beginner,
  intermediate,
  professional;

  String description() {
    switch (this) {
      case DanceLevel.beginner:
        return "Beginner";
      case DanceLevel.intermediate:
        return "Intermediate";
      case DanceLevel.professional:
        return "Professional";
    }
  }
}

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.name,
    required super.description,
    required super.locationName,
    super.locationAddress,
    required super.startDate,
    required super.endDate,
    super.imageUrl,
    super.organizerId,
    required super.tags,
    required super.danceStyle,
    required super.danceLevel,
    super.price = Price.free,
    String? priceAmount,
    super.dancePosition = DancePosition.indoor,
    List<String>? attendeesIds,
    List<String>? reviewsIds,
  }) : super(
          priceAmount: priceAmount ?? "0",
          attendeesIds: attendeesIds ?? [],
          reviewsIds: reviewsIds ?? [],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'locationName': locationName,
      'locationAddress': locationAddress,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'imageUrl': imageUrl,
      'organizerId': organizerId,
      'tags': tags.map((e) => e.name).toList(),
      'danceStyle': danceStyle.name,
      'danceLevel': danceLevel.name,
      'priceAmount': priceAmount,
      'price': price.name,
      'Danceposition': dancePosition,
      'attendeesIds': attendeesIds,
      'reviewsIds': reviewsIds,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      locationName: json['locationName'],
      locationAddress: json['locationAddress'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      imageUrl: json['imageUrl'],
      organizerId: json['organizerId'],
      tags: (json['tags'] as List?)
              ?.map((e) => eventTagFromString(e.toString()))
              .whereType<EventTag>()
              .toList() ??
          [],
      danceLevel:
          danceLevelFromString(json['danceLevel']) ?? DanceLevel.beginner,
      danceStyle: danceStyleFromString(json['danceStyle']) ?? DanceStyle.salsa,
      priceAmount: json['priceAmount'],
      price: Price.values.firstWhere((e) => e.name == json['price']),
      dancePosition: dancepositionFromString(json['dancePosition']) ??
          DancePosition.indoor,
      attendeesIds:
          (json['attendeesIds'] as List?)?.map((e) => e.toString()).toList(),
      reviewsIds:
          (json['reviewsIds'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

EventTag? eventTagFromString(String value) {
  return EventTag.values.firstWhere(
    (e) => e.description().toLowerCase() == value.toLowerCase(),
    orElse: () => EventTag.chill,
  );
}

DanceStyle? danceStyleFromString(String value) {
  return DanceStyle.values.firstWhere(
    (e) => e.description().toLowerCase() == value.toLowerCase(),
    orElse: () => DanceStyle.salsa,
  );
}

Price? priceFromString(String value) {
  return Price.values.firstWhere(
    (e) => e.description().toLowerCase() == value.toLowerCase(),
    orElse: () => Price.free,
  );
}

DancePosition? dancepositionFromString(String value) {
  return DancePosition.values.firstWhere(
    (e) => e.description().toLowerCase() == value.toLowerCase(),
    orElse: () => DancePosition.indoor,
  );
}

DanceLevel? danceLevelFromString(String value) {
  return DanceLevel.values.firstWhere(
    (e) => e.description().toLowerCase() == value.toLowerCase(),
    orElse: () => DanceLevel.beginner,
  );
}

final List<EventModel> sampleEvents = [
  EventModel(
    id: "1",
    name: "Salsa Night Fever",
    description: "An unforgettable salsa dance party.",
    locationName: "Dance Studio A",
    locationAddress: "123 Salsa Street",
    startDate: DateTime.now().add(const Duration(days: 2)),
    endDate: DateTime.now().add(const Duration(days: 2, hours: 3)),
    imageUrl:
        "https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg",
    organizerId: "2rgXLpBwDGSjR7z8jJLR3Bx1oLi1",
    tags: [EventTag.energetic, EventTag.liveMusic],
    danceStyle: DanceStyle.salsa,
    danceLevel: DanceLevel.beginner,
    price: Price.paid,
    priceAmount: "15",
    dancePosition: DancePosition.indoor,
    attendeesIds: ["AADXBNieMtPgoLLH4rtsYlNh31e2"],
    reviewsIds: ["r1"],
  ),
  EventModel(
    id: "2",
    name: "Afro Beats Jam",
    description: "Feel the rhythm with afrobeat dance.",
    locationName: "Outdoor Arena",
    locationAddress: "456 Afro Ave",
    startDate: DateTime.now().add(const Duration(days: 4)),
    endDate: DateTime.now().add(const Duration(days: 4, hours: 2)),
    imageUrl:
        "https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg",
    organizerId: "2rgXLpBwDGSjR7z8jJLR3Bx1oLi1",
    tags: [EventTag.cultural],
    danceStyle: DanceStyle.kizomba,
    danceLevel: DanceLevel.beginner,
    price: Price.free,
    priceAmount: null,
    dancePosition: DancePosition.outdoor,
    attendeesIds: ["AADXBNieMtPgoLLH4rtsYlNh31e2"],
    reviewsIds: [],
  ),
  EventModel(
    id: "3",
    name: "Kizomba Chill Vibes",
    description: "Relaxed and romantic kizomba sessions.",
    locationName: "Kizomba Club",
    locationAddress: null,
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
    imageUrl:
        "https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg",
    organizerId: "2rgXLpBwDGSjR7z8jJLR3Bx1oLi1",
    tags: [EventTag.chill],
    danceStyle: DanceStyle.kizomba,
    danceLevel: DanceLevel.beginner,
    price: Price.paid,
    priceAmount: "10",
    dancePosition: DancePosition.indoor,
    attendeesIds: null,
    reviewsIds: null,
  ),
  EventModel(
    id: "4",
    name: "Tango Under the Stars",
    description: "Outdoor tango experience under moonlight.",
    locationName: "Central Park",
    locationAddress: "789 Tango Terrace",
    startDate: DateTime.now().add(const Duration(days: 7)),
    endDate: DateTime.now().add(const Duration(days: 7, hours: 3)),
    imageUrl:
        "https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg",
    organizerId: "2rgXLpBwDGSjR7z8jJLR3Bx1oLi1",
    tags: [EventTag.cultural, EventTag.touristy],
    danceStyle: DanceStyle.tango,
    danceLevel: DanceLevel.beginner,
    price: Price.paid,
    priceAmount: "20",
    dancePosition: DancePosition.outdoor,
    attendeesIds: ["AADXBNieMtPgoLLH4rtsYlNh31e2"],
    reviewsIds: ["r2", "r3"],
  ),
  EventModel(
    id: "5",
    name: "Bachata Express",
    description: "Quick fun bachata lessons & party.",
    locationName: "Club B",
    locationAddress: "987 Bachata Blvd",
    startDate: DateTime.now().add(const Duration(days: 3)),
    endDate: DateTime.now().add(const Duration(days: 3, hours: 1)),
    imageUrl:
        "https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg",
    organizerId: "2rgXLpBwDGSjR7z8jJLR3Bx1oLi1",
    tags: [EventTag.energetic],
    danceStyle: DanceStyle.batchata,
    danceLevel: DanceLevel.beginner,
    price: Price.free,
    priceAmount: null,
    dancePosition: DancePosition.indoor,
    attendeesIds: [],
    reviewsIds: ["AADXBNieMtPgoLLH4rtsYlNh31e2"],
  ),
  EventModel(
    id: "6",
    name: "HipHop Street Dance",
    description: "Street-style hiphop battles and jams.",
    locationName: "Urban Center",
    locationAddress: "Street 001",
    startDate: DateTime.now().add(const Duration(days: 5)),
    endDate: DateTime.now().add(const Duration(days: 5, hours: 4)),
    imageUrl:
        "https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg",
    organizerId: "2rgXLpBwDGSjR7z8jJLR3Bx1oLi1",
    tags: [EventTag.liveMusic],
    danceStyle: DanceStyle.batchata,
    danceLevel: DanceLevel.beginner,
    price: Price.paid,
    priceAmount: "30",
    dancePosition: DancePosition.outdoor,
    attendeesIds: ["AADXBNieMtPgoLLH4rtsYlNh31e2"],
    reviewsIds: ["r4", "r5", "r6"],
  ),
];
