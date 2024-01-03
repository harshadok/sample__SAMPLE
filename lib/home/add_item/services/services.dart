// import 'package:http/http.dart' as http;

// class StateServices {
//    getStateList() async {
//     var headers = {'X-CSCAPI-KEY': 'API_KEY'};

//     var request = http.Request('GET',
//         Uri.parse('https://api.countrystatecity.in/v1/countries/IN/states'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }
