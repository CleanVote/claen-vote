import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Google Sheets backend service via Apps Script Web App
class GoogleSheetsService {
  static const String _webAppUrl = 'https://script.google.com/macros/s/AKfycbyCT1QdoEgPp0-svh9GFkj_icJ6LEnP2bCxNRWELY8-WtUfdbIydyp2-0A106JCVCkn/exec';

  static bool get isConfigured => _webAppUrl != 'YOUR_APPS_SCRIPT_WEB_APP_URL';

  static Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String pinfl,
    required String phone,
    required String region,
    required String district,
    required String mahalla,
    required String address,
  }) async {
    return _get('register_user', params: {
      'full_name': fullName,
      'pinfl': pinfl,
      'phone': phone,
      'region': region,
      'district': district,
      'mahalla': mahalla,
      'address': address,
      'season': '2026-Q2',
    });
  }

  static Future<Map<String, dynamic>> recordVote({
    required String userId,
    required String projectId,
    required String mahalla,
  }) async {
    return _get('vote', params: {
      'user_id': userId,
      'project_id': projectId,
      'mahalla': mahalla,
      'season': '2026-Q2',
    });
  }

  static Future<Map<String, dynamic>> submitReport({
    required String topic,
    required String description,
    bool hasAttachment = false,
  }) async {
    return _get('report', params: {
      'topic': topic,
      'description': description,
      'has_attachment': hasAttachment.toString(),
    });
  }

  /// Get projects from sheet
  static Future<Map<String, dynamic>> getProjects() async {
    return _get('get_projects');
  }

  /// Check if user exists by PINFL
  static Future<Map<String, dynamic>> checkUser(String pinfl) async {
    return _get('check_user', params: {'pinfl': pinfl});
  }

  // ─── HTTP Helpers ──────────────────────────────

  // Removed _post since we use _get for everything now

  static Future<Map<String, dynamic>> _get(String action, {Map<String, String>? params}) async {
    if (!isConfigured) {
      debugPrint('[GoogleSheets] Not configured — skipping $action');
      return {'success': false, 'error': 'Not configured'};
    }

    try {
      final uri = Uri.parse(_webAppUrl).replace(queryParameters: {
        'action': action,
        ...?params,
      });

      final response = await http.get(uri);
      debugPrint('[GoogleSheets] GET $action → ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }

      return {'success': false, 'error': 'HTTP ${response.statusCode}'};
    } catch (e) {
      debugPrint('[GoogleSheets] Error in $action: $e');
      return {'success': false, 'error': e.toString()};
    }
  }
}

// 

// good luck everyone
