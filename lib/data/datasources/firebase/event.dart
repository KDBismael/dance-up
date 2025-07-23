import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/data/repositories/event.dart';
import 'package:dartz/dartz.dart';

class Event extends EventRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const reviewsCollection = 'EventReviews';
  static const eventsCollection = 'Events';

  @override
  Future<Either<ServerFailure, List<EventModel>>> getEvents({
    String? tag,
    String? location,
    DateTime? date,
  }) async {
    try {
      final query = firestore.collection(eventsCollection);

      if (tag != null) {
        query.where('tags', arrayContains: tag);
      }
      if (location != null) {
        query.where('locationName', isEqualTo: location);
      }
      if (date != null) {
        query.where('startDate', isLessThanOrEqualTo: date);
      }

      final snapshot = await query.get();
      final events =
          snapshot.docs.map((doc) => EventModel.fromJson(doc.data())).toList();

      return Right(events);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      } else if (e.code == 'not-found') {
        return Left(ServerFailure('Event not found'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, EventModel>> getEventById(String eventId) async {
    try {
      final doc =
          await firestore.collection(eventsCollection).doc(eventId).get();
      if (doc.exists) {
        final event = EventModel.fromJson(doc.data()!);
        return Right(event);
      } else {
        return Left(ServerFailure('Event not found'));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      } else if (e.code == 'not-found') {
        return Left(ServerFailure('Event not found'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, EventModel>> createEvent(
      EventModel event) async {
    try {
      final newEventRef = firestore.collection(eventsCollection).doc();
      await newEventRef.set(event.toJson());

      return Right(event.copyWith(id: newEventRef.id));
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateEvent(EventModel event) async {
    try {
      final eventRef = firestore.collection(eventsCollection).doc(event.id);
      await eventRef.update(event.toJson());

      return const Right(null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      } else if (e.code == 'not-found') {
        return Left(ServerFailure('Event not found'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteEvent(String eventId) async {
    try {
      await firestore.collection(eventsCollection).doc(eventId).delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      } else if (e.code == 'not-found') {
        return Left(ServerFailure('Event not found'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, EventReviewModel>> addEventReview(
      EventReviewModel review) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final newReviewRef = firestore.collection(reviewsCollection).doc();

      await firestore.runTransaction((tx) async {
        tx.set(newReviewRef, review.toJson());

        final eventRef =
            firestore.collection(eventsCollection).doc(review.eventId);
        final eventSnap = await tx.get(eventRef);
        final data = eventSnap.data()!;
        final rate = (data['rate'] as num?)?.toDouble() ?? 0;

        final average =
            num.parse(((rate + review.rating) / 2).toStringAsFixed(1));

        tx.update(eventRef, {
          'rate': average,
          'reviewsIds': FieldValue.arrayUnion([newReviewRef.id]),
        });
      });

      return Right(review.copyWith(id: newReviewRef.id));
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      } else if (e.code == 'not-found') {
        return Left(ServerFailure('Event not found'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<EventReviewModel>>> getEventReviews(
      String eventId) async {
    try {
      final reviewsSnap = await firestore
          .collection(reviewsCollection)
          .where('eventId', isEqualTo: eventId)
          .get();

      final reviews = reviewsSnap.docs
          .map((d) => EventReviewModel.fromJson(d.data()))
          .toList();

      return Right(reviews);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Left(ServerFailure('Permission denied'));
      } else if (e.code == 'not-found') {
        return Left(ServerFailure('Event not found'));
      }
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
