import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/data/repositories/event.dart';
import 'package:dance_up/features/events/screens/events.dart';
import 'package:dance_up/features/events/screens/events_details.dart';
import 'package:get/get.dart';

class EventPresenter extends GetxController {
  final EventRepository repository;
  EventPresenter(this.repository);

  var events = <EventModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedTag = ''.obs;
  var isSortedBy = EventSortBy.recent.obs;

  getEvents({
    String? tag,
    String? location,
    DateTime? date,
  }) async {
    isLoading.value = true;
    final res =
        await repository.getEvents(tag: tag, location: location, date: date);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
      },
      (eventList) {
        events.value = eventList;
        isLoading.value = false;
        errorMessage.value = '';
      },
    );
  }

  getEventById(String eventId) async {
    isLoading.value = true;
    final res = await repository.getEventById(eventId);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
      },
      (event) {
        isLoading.value = false;
        errorMessage.value = '';
        Get.to(() => EventDetailsScreen());
      },
    );
  }

  createEvent(EventModel event) async {
    isLoading.value = true;
    final res = await repository.createEvent(event);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
      },
      (createdEvent) {
        isLoading.value = false;
        errorMessage.value = '';
        events.add(createdEvent);
        Get.back();
      },
    );
  }

  updateEvent(EventModel event) async {
    isLoading.value = true;
    final res = await repository.updateEvent(event);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
      },
      (success) {
        isLoading.value = false;
        errorMessage.value = '';
        int index = events.indexWhere((e) => e.id == event.id);
        if (index != -1) {
          events[index] = event;
        }
      },
    );
  }

  deleteEvent(String eventId) async {
    isLoading.value = true;
    final res = await repository.deleteEvent(eventId);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
      },
      (success) {
        isLoading.value = false;
        errorMessage.value = '';
        events.removeWhere((e) => e.id == eventId);
      },
    );
  }
}
