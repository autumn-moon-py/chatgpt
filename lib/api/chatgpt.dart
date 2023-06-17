import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPT {
  String apiUrl = 'https://gpt-api.01r.cc';
  String key;

  ChatGPT(this.key);

  ///temperature 随机性 0-2 推荐0.6 0.8
  ///n 输出多少条结果
  Future<String> chat(String content,
      {double temperature = 1, int n = 1}) async {
    if (temperature < 0 || temperature > 2) {
      temperature = 0.8;
    }
    if (n < 0) {
      n = 1;
    }
    if (key.isEmpty) {
      return 'Key为空,请去设置页面填写';
    }
    Uri url = Uri.parse('$apiUrl/v1/chat/completions');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key'
    };
    Object body = jsonEncode({
      'model': 'gpt-3.5-turbo-0301',
      'messages': [
        {'role': 'user', 'content': content}
      ],
      'temperature': temperature,
      'n': n,
    });
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map result = jsonDecode(utf8.decode(response.bodyBytes));
      return result['choices'][0]['message']['content'];
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }
}
