// message_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_chat_app/message_model.dart';

class MessageService {
  static const String apiUrl = 'https://doctorai.pythonanywhere.com/myapp/api/';

  static Future<Message> sendMessage(String content) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'content': content}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Message.fromJson(data);
    } else {
      throw Exception('Failed to send message');
    }
  }
}
