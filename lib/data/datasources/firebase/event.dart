import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/data/repositories/event.dart';
import 'package:dartz/dartz.dart';

class Event extends EventRepository {
  @override
  Future<Either<ServerFailure, List<EventModel>>> getEvents({
    String? tag,
    String? location,
    DateTime? date,
  }) {
    // TODO: implement getEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, EventModel>> getEventById(String eventId) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, EventModel>> createEvent(EventModel event) {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> updateEvent(EventModel event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> deleteEvent(String eventId) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }
}
