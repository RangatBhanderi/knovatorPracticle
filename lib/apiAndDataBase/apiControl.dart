import "package:http/http.dart" as http;

getPostData() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  var response = await http.get(
    Uri.parse(apiUrl),
  );
  return response;
}
