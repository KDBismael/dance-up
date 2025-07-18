import 'package:dance_up/data/models/event_model.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final String locationName;
  final String? locationAddress;
  final DateTime startDate;
  final DateTime endDate;
  final String? imageUrl;
  final String? organizerId;
  final List<EventTag> tags;
  final DanceStyle danceStyle;
  final DanceLevel danceLevel;
  final Price price;
  final String? priceAmount;
  final DancePosition dancePosition;
  final List<String>? attendeesIds;
  final List<String>? reviewsIds;
  final List<String>? photos;
  final double? rate;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.locationName,
    this.locationAddress,
    this.photos,
    this.rate,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    this.organizerId,
    required this.tags,
    required this.danceStyle,
    required this.danceLevel,
    this.priceAmount,
    required this.price,
    required this.dancePosition,
    this.attendeesIds,
    this.reviewsIds,
  });
}
