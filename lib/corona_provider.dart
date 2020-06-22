import 'package:covid19/providers/indonesia_model.dart';
import 'package:covid19/providers/world_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoronaProvider with ChangeNotifier{
  IndonesiaModel summary; //state menampung data di indonesia
  WorldModel world; //state menampung data dunia
  String updated; //state menampung waktu pembaharuan

  //fungsi menjalankan api call untuk mengambil data
Future<void> getData() async{
  final url='https://kawalcovid19.harippe.id/api/summary';
  final response = await http.get(url); //hit ke api
  //dan convert data yang diterima
  final result = json.decode(response.body) as Map<String, dynamic>;
  //masukkan data ke dalam state summary dengan format berdasarkan indonesia model

  summary = IndonesiaModel(
    confirmed: result['confirmed']['value'],
    recovered: result['recovered']['value'],
    deaths: result['deaths']['value'],
    activeCare: result['activeCare']['value'],
  );
  //simpan data pembaharuan ke dalam state updated
  updated = result['metadata']['lastUpdatedAt'];

  //data dunia memiliki 3 api, masing-masing menghasilkan data sendiri
  final worldPositive = 'https://api.kawalcorona.com/positif/';
  final responsePositive = await http.get(worldPositive);
  final resultPositive = json.decode(responsePositive.body);

  final worldRecovered = 'https://api.kawalcorona.com/sembuh/';
  final responseRecovered = await http.get(worldRecovered);
  final resultRecovered = json.decode(responseRecovered.body);

  final worldDeaths = 'https://api.kawalcorona.com/meninggal/';
  final responseDeaths = await http.get(worldDeaths);
  final resultDeaths = json.decode(responseDeaths.body);

  world = WorldModel(
    confirmed: resultPositive['value'],
    deaths: resultDeaths['value'],
    recovered: resultRecovered['value'],
  );
  //informasikan bahwa terjadi perubahan
  notifyListeners();


}

}
