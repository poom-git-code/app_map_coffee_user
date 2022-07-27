import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_search.dart';
import '../services/geolocator_sevice.dart';
import '../services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  // final markerService = MarkerService();

  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;

  // StreamController<Place> selectedLocation = StreamController<Place>();
  // StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  // Place? selectedLocationStatic;
  // String? placeType;
  // List<Place>? placeResults;
  // List<Marker> markers = List<Marker>();


  ApplicationBloc() {
    setCurrentLocation();
  }


  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}