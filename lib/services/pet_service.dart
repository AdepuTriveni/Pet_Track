import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config.dart';
import '../models/pet.dart';

class PetService extends ChangeNotifier {
  // use Config.backendUrl from your config.dart
  String baseUrl = Config.backendUrl;

  List<Pet> _pets = [];
  bool _isLoading = false;
  String _error = '';

  List<Pet> get pets => _pets;
  bool get isLoading => _isLoading;
  String get error => _error;

  void setBaseUrl(String url) {
    baseUrl = url;
    notifyListeners();
  }

  // 🔹 Fetch all pets
  Future<void> fetchPets({String? type}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final uri = Uri.parse('$baseUrl/pets${type != null ? '?type=$type' : ''}');
      final resp = await http.get(uri);
      if (resp.statusCode == 200) {
        final List<dynamic> data = json.decode(resp.body);
        _pets = data.map((e) => Pet.fromJson(e)).toList();
        _error = '';
      } else {
        _error = 'Failed to load pets: ${resp.statusCode}';
      }
    } catch (e) {
      _error = 'Failed to load pets: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 🔹 Add a pet
  Future<Map<String, dynamic>> addPet({
    required String name,
    required String type, // 'lost' or 'found'
    String? breed,
    String? description,
    String? ownerPhone,
    String? reporterPhone, // <-- added parameter
    String? address,
    DateTime? lastSeenDate,
    List<XFile>? images,
  }) async {
    final url = Uri.parse('$baseUrl/${type == 'lost' ? 'pets/lost' : 'pets/found'}');

    final user = FirebaseAuth.instance.currentUser;
    final token = user != null ? await user.getIdToken() : null;
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final body = {
      'name': name,
      if (breed != null) 'breed': breed,
      if (description != null) 'description': description,
      if (ownerPhone != null) 'ownerPhone': ownerPhone,
      if (reporterPhone != null) 'reporterPhone': reporterPhone,
      if (address != null) 'address': address,
      if (lastSeenDate != null) 'lastSeenDate': lastSeenDate.toIso8601String(),
      // images handled separately (multipart) if needed
    };

    final res = await http.post(url, headers: headers, body: jsonEncode(body));
    return {
      'success': res.statusCode == 200 || res.statusCode == 201,
      'message': res.body,
      'statusCode': res.statusCode
    };
  }

  // 🔹 Find pet by ID
  Pet? getPetById(String id) {
    try {
      return _pets.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // 🔹 Clear errors
  void clearError() {
    _error = '';
    notifyListeners();
  }
}
