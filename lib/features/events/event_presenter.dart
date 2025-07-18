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
    final eventFilter = EventFilter(
      fiilteredEvents: filteredEvents,
      events: events,
      tag: selectedTag,
      eventType: selectedEventType,
      danceStyles: selectedDanceStyle,
      danceLevels: selectedDanceLevel,
      prices: selectedPrice,
      dancePositions: selectedDancePosition,
    );
    eventFilter.applyAllFilters();

    selectedTag.listen((tag) {
      eventFilter.applyAllFilters();
    });
    selectedEventType.listen((type) {
      eventFilter.applyAllFilters();
    });
    selectedDanceStyle.listen((styles) {
      eventFilter.applyAllFilters();
    });
    selectedDanceLevel.listen((level) {
      eventFilter.applyAllFilters();
    });
    selectedPrice.listen((price) {
      eventFilter.applyAllFilters();
    });
    selectedDancePosition.listen((position) {
      eventFilter.applyAllFilters();
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

class EventFilter {
  final Rx<EventTag>? tag;
  final Rx<EventType>? eventType;
  final RxList<DanceStyle>? danceStyles;
  final RxList<DanceLevel>? danceLevels;
  final RxList<Price>? prices;
  final RxList<DancePosition>? dancePositions;
  final RxList<EventModel> events;
  final RxList<EventModel> fiilteredEvents;

  EventFilter({
    required this.fiilteredEvents,
    required this.events,
    this.tag,
    this.eventType,
    this.danceStyles,
    this.danceLevels,
    this.prices,
    this.dancePositions,
  });

  void applyAllFilters() {
    print("Applying all filters...");

    var result = events.value;

    result = _filterByTag(result);
    result = _filterByEventType(result);
    result = _filterByDanceStyle(result);
    result = _filterByDanceLevel(result);
    result = _filterByPrice(result);
    result = _filterByDancePosition(result);

    print("Filtered events count: ${result.length}");
    fiilteredEvents.value = result;
  }

  List<EventModel> _filterByTag(List<EventModel> events) {
    print("Selected tag changed to: ${tag?.value.description()}");
    return events.where((event) {
      return event.tags.contains(tag?.value);
    }).toList();
  }

  List<EventModel> _filterByEventType(List<EventModel> events) {
    print("Selected event type changed to: ${eventType?.value.description()}");
    return eventType?.value == EventType.all
        ? events
        : eventType?.value == EventType.past
            ? events.where((event) {
                return event.startDate.isBefore(DateTime.now());
              }).toList()
            : events.where((event) {
                return event.startDate.isAfter(DateTime.now());
              }).toList();
  }

  List<EventModel> _filterByDanceStyle(List<EventModel> events) {
    print(
        "Selected dance styles changed to: ${danceStyles?.map((e) => e.description()).join(', ')}");
    return events.where((event) {
      return danceStyles?.contains(event.danceStyle) ?? false;
    }).toList();
  }

  List<EventModel> _filterByDanceLevel(List<EventModel> events) {
    print(
        "Selected dance levels changed to: ${danceLevels?.map((e) => e.description()).join(', ')}");
    return events.where((event) {
      return danceLevels?.contains(event.danceLevel) ?? false;
    }).toList();
  }

  List<EventModel> _filterByPrice(List<EventModel> events) {
    print(
        "Selected prices changed to: ${prices?.map((e) => e.description()).join(', ')}");
    return events.where((event) {
      return prices?.contains(event.price) ?? false;
    }).toList();
  }

  List<EventModel> _filterByDancePosition(List<EventModel> events) {
    print(
        "Selected dance positions changed to: ${dancePositions?.map((e) => e.description()).join(', ')}");
    return events.where((event) {
      return dancePositions?.contains(event.dancePosition) ?? false;
    }).toList();
  }
}
