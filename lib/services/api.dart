import 'dart:convert';

import 'package:gmao_app/models/intervention.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  final String _url = 'http://10.0.2.2:8000/api/afriqIndusApp';

  String? token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token') ;
  }

  authData(data, apiUrl) async {
    var fullUrl = Uri.https(_url,apiUrl) ;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = Uri.https(_url,apiUrl) ;
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };



  Future getdata() async {
    final responce =
    await http.get(Uri.parse(_url + '/interventions'));
    if (responce.statusCode == 200) {
      return Intervention.fromJson(jsonDecode(responce.body));
    }
  }
  Future datacreated(data) async {
    final responce =
    await http.post(Uri.parse(_url+'/addIntervention'),
        body: jsonEncode({
          data
        }),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        });
    print(responce.statusCode);
    if (responce.statusCode == 201) {

      print('Data Created Successfully');
    } else {
      print('erro');
    }
  }

  Future deletedata(id) async {
    final responce = await http
        .delete(Uri.parse(_url+'/interventions/$id'));
    print(responce.statusCode);

    if (responce.statusCode == 200) {
      print('DELETE COMPLETE');
    } else {
      print('nOT dELET');
    }
  }

  Future updatedata(data) async {
    final responce = await http
        .put(Uri.parse(_url+'/interventions/1'),
        body: jsonEncode({
          data
        }),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        });
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      print('Data Update Sucassfully');

    } else {
      print('error');
    }
  }

}