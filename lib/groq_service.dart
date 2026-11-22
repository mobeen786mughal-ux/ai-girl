import 'dart:convert';
import 'package:http/http.dart' as http;
class GroqService {
  static const String apiKey = 'YOUR_GROQ_API_KEY';
  static Future<String> ask(String q, List<Map<String,String>> hist) async {
    try {
      final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
      List<Map<String,String>> msgs = [];
      msgs.add({'role': 'system', 'content': 'You are 3D Girl, cute anime girl. Answer in Roman Urdu, short, cute, friendly.'});
      if (hist.length > 6) hist = hist.sublist(hist.length - 6);
      msgs.addAll(hist);
      msgs.add({'role': 'user', 'content': q});
      final res = await http.post(url, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $apiKey'}, body: jsonEncode({'model': 'llama-3.3-70b-versatile','messages': msgs,'max_tokens': 300,'temperature': 0.8})).timeout(Duration(seconds: 25));
      if (res.statusCode == 200) {
        final d = jsonDecode(res.body);
        return d['choices'][0]['message']['content'].toString().trim();
      }
      return "Uff! Dobara bolo na! 🥺";
    } catch (e) { return "Net ka masla hai!"; }
  }
}
