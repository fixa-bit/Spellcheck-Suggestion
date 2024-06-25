// import 'package:http/http.dart';

// Future getData(url) async {
// Response response = await get(url);
// return response.body;
// }

import 'package:http/http.dart';

Future getData(url) async {
  //Response response = await get(url);
  var response = await get(Uri.parse(url));
  return response.body;






  
}
