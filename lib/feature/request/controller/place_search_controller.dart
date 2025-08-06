import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PlaceSearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <Map<String, dynamic>>[].obs;
  var selectedPlace = Rxn<Map<String, dynamic>>();
  TextEditingController controller = TextEditingController();

  // Fetch places autocomplete results
  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    final String searchUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=AIzaSyCVJDP6zo30c6QBcYPdG7EZ1Dca1lGE2a0&location=23.685&radius=10000';
    try {
      final response = await http.get(Uri.parse(searchUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['predictions'] != null) {
          searchResults.value = List<Map<String, dynamic>>.from(
            data['predictions'],
          );
        } else {
          searchResults.clear();
        }
      } else {
        print('Error fetching search results: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching search results: $e');
    }
  }

  // Fetch details of a selected place
  Future<void> fetchPlaceDetails(String placeId) async {
    isLoading.value = true;

    final String detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCVJDP6zo30c6QBcYPdG7EZ1Dca1lGE2a0';
    try {
      final response = await http.get(Uri.parse(detailsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['result'] != null) {
          final placeDetails = data['result'];
          final placeData = {
            'description': placeDetails['name'],
            'lat': placeDetails['geometry']['location']['lat'],
            'lng': placeDetails['geometry']['location']['lng'],
          };
          updatePlaceDetails(placeId, placeData);
        }
      }
    } catch (e) {
      print('Error fetching place details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update the selected place
  void updatePlaceDetails(String placeId, [Map<String, dynamic>? placeData]) {
    selectedPlace.value =
        placeData ??
        {
          'description': 'No description available',
          'lat': 'No latitude',
          'lng': 'No longitude',
        };
  }
}
