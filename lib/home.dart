import 'package:flutter/material.dart';
import 'components/indonesia.dart';
import 'components/world.dart';
import 'corona_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //ambil ukuran layar
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Lawan Covid19'),
      ),
      //refresh indicator agar ketika layar ditarik akan load data baru
      body: RefreshIndicator(
        //atribut onrefresh
        //memanggil fungsi getData yang sudah dibuat
        onRefresh: () =>
        Provider.of<CoronaProvider>(context,listen: false).getData(),
        child: Container(
          margin: const EdgeInsets.all(10),
          //ketika app dibuka maka fungsi future builder akan dijalankan
          child: FutureBuilder(
            //meload data dari api menggunakan fungsi yang sama
            future:
            Provider.of<CoronaProvider>(context,listen: false).getData(),
            builder: (context,snapshot){
              //jika masih loading
              if(snapshot.connectionState == ConnectionState.waiting){
                //tampilkan loading indikator
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //selain itu maka tampilkan widget untuk data
              //gunakan consumer untuk mengambil data dari corona provider
              return Consumer<CoronaProvider>(
                builder: (context,data, _){
                  //dua column
                  return Column(
                    children: <Widget>[
                      //pertama data di indonesia yang widget kita pisahkan sendiri
                      Flexible(
                        flex: 1,
                          child: Indonesia(height: height, data: data),
                      ),
                      //kedua menampilkan data dunia dengan cara yang sama
                      Flexible(
                        flex: 1,
                        child: World(height: height, data: data),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}