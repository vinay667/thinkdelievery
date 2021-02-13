import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thinkdelievery/model/user_model.dart';
import 'package:toast/toast.dart';
import 'app_exceptions.dart';
import 'constants.dart';

class ApiBaseHelper {
  final String _baseUrl = AppConstant.appBaseURL;
  Future<dynamic> get(String url, BuildContext context) async {
    var responseJson;
    print(_baseUrl+url+'  API CALLED');
    String accessToken = UserModel.accessToken;
    print('url ${_baseUrl + url}');
    try {
      final response = await http.get(_baseUrl + url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Accept':'application/json',
        'X-Requested-With':'XMLHttpRequest'
      });
      responseJson = _returnResponse(response, context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> postAPIWithHeader(
      String url, Map<String, dynamic> apiParams, BuildContext context) async {
    print(_baseUrl+url+' API CALLED');
    print(apiParams.toString());
    var responseJson;
    String accessToken = UserModel.accessToken;
    print('url ${_baseUrl + url}');
    try {
      final response = await http.post(_baseUrl + url,
          body: json.encode(apiParams),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + accessToken,
            'Accept':'application/json',
            'X-Requested-With':'XMLHttpRequest'
          });
      responseJson = _returnResponse(response, context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPI(
      String url, var apiParams, BuildContext context) async {
    print(_baseUrl+url+'  API CALLED');
    print(apiParams.toString());
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          body: json.encode(apiParams),
          headers: {
            'Content-Type': 'application/json',
            'Accept':'application/json',
            'X-Requested-With':'XMLHttpRequest'
          }
          );
      print(response.toString()+'key 1');
      responseJson = _returnResponse(response, context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  dynamic _returnResponse(http.Response response, BuildContext context) {
    var responseJson = jsonDecode(response.body.toString());
    print(response.statusCode.toString() +'Status Code******* ');

    log('api helper response $responseJson');
    switch (response.statusCode) {
      case 200:
        print(responseJson);
        return responseJson;
      case 201:
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        Navigator.pop(context);
        Toast.show(responseJson['error'].toString(), context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
        throw BadRequestException(response.body.toString());
        break;
      case 403:
        Navigator.pop(context);
        throw UnauthorisedException(response.body.toString());
      case 500:
        Navigator.pop(context);
        Toast.show('Something went wrong !!', context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
        break;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
