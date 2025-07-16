import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/data/repositories/event.dart';
import 'package:dance_up/features/events/screens/events.dart';
import 'package:dance_up/features/events/screens/events_details.dart';
import 'package:get/get.dart';

class EventPresenter extends GetxController {
  final EventRepository repository;
  EventPresenter(this.repository);

  var events = <EventModel>[].obs;
  var filteredEvents = <EventModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isSortedBy = EventSortBy.recent.obs;
  var selectedTag = EventTag.chill.obs;
  var selectedEventType = EventType.all.obs;
  var selectedDanceStyle = <DanceStyle>[...DanceStyle.values].obs;
  var selectedDanceLevel = <DanceLevel>[...DanceLevel.values].obs;
  var selectedPrice = <Price>[...Price.values].obs;
  var selectedDancePosition = <DancePosition>[...DancePosition.values].obs;

  @override
  void onInit() {
    getEvents();
    applyAllFilters();
    // events.listen(
    //   (eventList) {
    //     filteredEvents.value = eventList.where((event) {
    //       return event.tags.contains(selectedTag.value);
    //     }).toList();
    //   },
    // );
    // filterByTag(selectedTag.value);
    // filterByEventType(selectedEventType.value);
    // filterByDanceStyle(selectedDanceStyle);
    // filterByDanceLevel(selectedDanceLevel);
    // filterByPrice(selectedPrice);
    // filterByDancePosition(selectedDancePosition);

    selectedTag.listen((tag) {
      filterByTag(tag);
    });
    selectedEventType.listen((type) {
      filterByEventType(type);
    });
    selectedDanceStyle.listen((styles) {
      filterByDanceStyle(styles);
    });
    selectedDanceLevel.listen((level) {
      filterByDanceLevel(level);
    });
    selectedPrice.listen((price) {
      filterByPrice(price);
    });
    selectedDancePosition.listen((position) {
      filterByDancePosition(position);
    });

    super.onInit();
  }

  getEvents({
    String? tag,
    String? location,
    DateTime? date,
  }) async {
    isLoading.value = true;
    events.value = sampleEvents;
    filteredEvents.value = sampleEvents;
    // final res =
    //     await repository.getEvents(tag: tag, location: location, date: date);
    // res.fold(
    //   (failure) {
    //     isLoading.value = false;
    //     errorMessage.value = failure.message;
    //   },
    //   (eventList) {
    //     events.value = eventList;
    //     isLoading.value = false;
    //     errorMessage.value = '';
    //   },
    // );
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

  void filterByTag(EventTag tag) {
    print("Selected tag changed to: ${tag.description()}");
    filteredEvents.value = events.where((event) {
      return event.tags.contains(tag);
    }).toList();
  }

  void filterByEventType(EventType type) {
    print("Selected event type changed to: ${type.description()}");
    filteredEvents.value = type == EventType.all
        ? filteredEvents
        : type == EventType.past
            ? filteredEvents.where((event) {
                return event.startDate.isBefore(DateTime.now());
              }).toList()
            : filteredEvents.where((event) {
                return event.startDate.isAfter(DateTime.now());
              }).toList();
  }

  void filterByDanceStyle(List<DanceStyle> styles) {
    print(
        "Selected dance styles changed to: ${styles.map((e) => e.description()).join(', ')}");
    filteredEvents.value = events.where((event) {
      return styles.contains(event.danceStyle);
    }).toList();
  }

  void filterByDanceLevel(List<DanceLevel> level) {
    print(
        "Selected dance levels changed to: ${level.map((e) => e.description()).join(', ')}");
    filteredEvents.value = events.where((event) {
      return level.contains(event.danceLevel);
    }).toList();
  }

  void filterByPrice(List<Price> price) {
    print(
        "Selected prices changed to: ${price.map((e) => e.description()).join(', ')}");
    filteredEvents.value = events.where((event) {
      return price.contains(event.price);
    }).toList();
  }

  void filterByDancePosition(List<DancePosition> position) {
    print(
        "Selected dance positions changed to: ${position.map((e) => e.description()).join(', ')}");
    filteredEvents.value = events.where((event) {
      return position.contains(event.dancePosition);
    }).toList();
  }

  void applyAllFilters() {
    print("Applying all filters...");

    var result = filteredEvents.value;

    result = result.where((event) {
      return event.tags.contains(selectedTag.value);
    }).toList();

    if (selectedEventType.value != EventType.all) {
      result = result.where((event) {
        return selectedEventType.value == EventType.past
            ? event.startDate.isBefore(DateTime.now())
            : event.startDate.isAfter(DateTime.now());
      }).toList();
    }

    result = result.where((event) {
      return selectedDanceStyle.contains(event.danceStyle);
    }).toList();

    result = result.where((event) {
      return selectedDanceLevel.contains(event.danceLevel);
    }).toList();

    result = result.where((event) {
      return selectedPrice.contains(event.price);
    }).toList();

    result = result.where((event) {
      return selectedDancePosition.contains(event.dancePosition);
    }).toList();

    filteredEvents.value = result;
  }
}
