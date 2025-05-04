import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> analyzeCode(String code) async {
  final url = Uri.parse("https://code-analyzer-xxxxx-uc.a.run.app/analyze");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['analysis'] ?? "No analysis found.";
    } else {
      print("Error from server: ${response.statusCode}");
      print("Body: ${response.body}");
      return "Analysis failed.";
    }
  } catch (e) {
    print("Error calling backend: $e");
    return "Error occurred.";
  }
}
