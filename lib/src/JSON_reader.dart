import 'dart:convert';

class JSONReader {
  static return_json_data(String path_to_file) {
    Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
}
  }
}
