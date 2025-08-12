import 'dart:developer';

import 'package:cozy/models/space.dart';
import 'package:cozy/services/api_service.dart';
import 'package:flutter/material.dart';

class RecommendedSpaceProvider extends ChangeNotifier {
  // Service to fetch data from the API.
  final ApiService _apiService = ApiService();

  // List of currently loaded recommended spaces.
  List<Space> _recommendedSpaces = [];

  // Indicates if data is currently being fetched.
  bool _isLoading = false;

  // New fields to handle errors
  // True if an error occurred during the last fetch attempt.
  bool _hasError = false;

  // Stores the error message if an error occurred.
  String _errorMessage = '';

  // Getter for the list of recommended spaces.
  List<Space> get recommendedSpaces => _recommendedSpaces;

  // Getter for the loading state.
  bool get isLoading => _isLoading;

  // Expose error state
  // Getter for the error flag.
  bool get hasError => _hasError;

  // Getter for the error message.
  String get errorMessage => _errorMessage;

  Future<void> fetchRecommendedSpaces() async {
    _isLoading = true;
    _hasError = false; // Reset error state before fetching
    _errorMessage = '';
    notifyListeners();

    // Attempt to retrieve recommended spaces.
    try {
      _recommendedSpaces = await _apiService.getRecommendedSpaces();
    } catch (e, stackTrace) {
      // Log error details for debugging.
      log('Error fetching recommended spaces: $e');
      log('Stack trace: $stackTrace');

      _hasError = true;
      _errorMessage = 'Failed to load recommended spaces. Please try again.';
      _recommendedSpaces = []; // Clear old data on error, optional
      // TODO: Implement more specific error handling (e.g., network error vs. server error).
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Optional retry method
  // Allows retrying the fetch operation if it previously failed.
  Future<void> retry() async {
    await fetchRecommendedSpaces();
  }
}
