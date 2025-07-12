import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/event_model.dart';
import 'package:dartz/dartz.dart';

abstract class EventRepository {
  Future<Either<ServerFailure, List<EventModel>>> getEvents({
    String? tag,
    String? location,
    DateTime? date,
  });

  Future<Either<ServerFailure, EventModel>> getEventById(String eventId);

  Future<Either<ServerFailure, EventModel>> createEvent(EventModel event);

  Future<Either<ServerFailure, void>> updateEvent(EventModel event);

  Future<Either<ServerFailure, void>> deleteEvent(String eventId);
}
