import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tugas_api/model.dart';
import 'package:http/http.dart' as http;

class Repository{
  final _baseUrl = 'https://62b537b2da3017eabb16b741.mockapi.io';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl+'/user'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<User> user = it.map((e) => User.fromJson(e)).toList();
        return user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String nama, String telpon) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl+'/user'),
          body: {"nama": nama, "telpon": telpon});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String nama, String telpon) async{
    try {
      final response = await http.put(Uri.parse(_baseUrl + '/user/' + id.toString()),
          body: {
            'nama': nama,
            'telpon': telpon
          });
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + '/user/' + id));
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}