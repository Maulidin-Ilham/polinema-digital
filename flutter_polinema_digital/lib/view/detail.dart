import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/controller/responden.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.nation, required this.genre});

  final String? nation;
  final String genre;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 22, right: 22, bottom: 22, top: 40),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.genre}",
                  style: GoogleFonts.urbanist(
                      color: Color.fromRGBO(30, 35, 44, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5,
                ),
                widget.nation != null
                    ? Text(
                        "Detail Survei Negara ${widget.nation}",
                        style: GoogleFonts.urbanist(
                            color: Color.fromRGBO(106, 112, 124, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )
                    : Text(
                        "Detail Survei Dari Seluruh Negara",
                        style: GoogleFonts.urbanist(
                            color: Color.fromRGBO(106, 112, 124, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future:
                        Responden.getDetailData(widget.nation, widget.genre),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(249, 249, 255, 1),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 234, 238, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('${index+1}. "${snapshot.data![index]['reports']}"'),
                            );
                          },
                        );
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailResponden extends StatefulWidget {
  const DetailResponden({super.key, this.nation, required this.genre});
  final String? nation;
  final String genre;

  @override
  State<DetailResponden> createState() => _DetailRespondenState();
}

class _DetailRespondenState extends State<DetailResponden> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Data1"),
        Text("Data1"),
        Text("Data1"),
      ],
    );
  }
}


// FutureBuilder(
//         future: Responden.getDetailData(widget.nation, widget.genre),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//                       itemCount: snapshot.data['genreList'].length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 16),
//                           child: Card(
//                             color: const Color.fromRGBO(61, 67, 79, 1),
//                             child: ListTile(
//                               onTap: (){
//                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(nation: "Indonesia", genre: snapshot.data['genreList'][index].toString())));
//                               },
//                               horizontalTitleGap: 30,
//                               leading: Text(
//                                 snapshot.data['genreCount']
//                                         [snapshot.data['genreList'][index]]
//                                     .toString(),
//                                 style: GoogleFonts.urbanist(
//                                     color: Colors.white,
//                                     fontSize: 32,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                               title: Text(
//                                 snapshot.data['genreList'][index].toString(),
//                                 style: GoogleFonts.urbanist(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         });