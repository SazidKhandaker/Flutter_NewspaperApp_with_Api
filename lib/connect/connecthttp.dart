import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:newspapaer_app/important/importantpage.dart';
import 'package:newspapaer_app/modeclass/modelclass.dart';

class CustomeHttp {
  Future<List<Articles>> fetchAllNewsData(
      {required int pageNo, required String sortBy}) async {
    List<Articles> allNewsData = [];
    Articles articles;

    var responce = await http.get(Uri.parse(
        "${baseUrl}&q=bitcoin&page=$pageNo&pageSize=10&sortBy=$sortBy&apiKey=$token"));
    print("responce is ${responce.body}");

    var data = jsonDecode(responce.body)["articles"];
    for (var i in data) {
      articles = Articles.fromJson(i);
      allNewsData.add(articles);
    }

    return allNewsData;
  }
}
