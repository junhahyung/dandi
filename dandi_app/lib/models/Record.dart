import 'package:flutter/material.dart';


class Record {
  String name;
  String address;
  String contact;
  String photo;
  String url;
  String country;
  List<String> career;//var career;//
  List<String> careersub;//var careersub;//

  Record({
    this.name,
    this.address,
    this.contact,
    this.photo,
    this.url,
    this.country,
    this.career,
    this.careersub
  });

  factory Record.fromJson(Map<String, dynamic> json){
    var careerFromJson = json['career'];
    List<String> careerList = careerFromJson.cast<String>();

    var careersubFromJson = json['careersub'];
    List<String> careersubList = careersubFromJson.cast<String>();
    return new Record(
        name: json['name'],
        address: json['address'],
        contact: json ['contact'],
        photo: json['photo'],
        url: json['url'],
        country: json['country'],
        career: careerList,
        careersub: careersubList,
    );
  }
}