import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'profile.dart';
import 'from_add_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getProfiles(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Ada yang salah dengan pesan: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Profile> profiles = snapshot.data;
            return _buildListView(profiles);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Profile> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Profile profile = profiles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(3)),
                    DecoratedBox(decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        ),
                        color: Colors.orange),
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 10.1,left:10.0 )),
                          Padding(padding: const EdgeInsets.all(3)),
                          Text('  Nama  : ${profile.name}',style: TextStyle(fontSize: 15, ),),
                          Padding(padding: const EdgeInsets.all(3)),
                        ],
                      ),
                    ),
                    ),


                    Padding(padding: const EdgeInsets.all(3)),
                    DecoratedBox(decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        ),
                        color: Colors.orange),
                      child: Container(
                        width: 500,
                        margin: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 10.1,left:10.0 )),
                            Padding(padding: const EdgeInsets.all(3)),
                            Text('  Email   : ${profile.email}',style: TextStyle(fontSize: 15,)),
                            Padding(padding: const EdgeInsets.all(3)),
                          ],
                        ),

                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(3)),
                    DecoratedBox(decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                          right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        ),
                        color: Colors.orange),
                      child: Container(
                        width: 500,
                        margin: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 10.1,left:10.0 )),
                          Padding(padding: const EdgeInsets.all(3)),
                          Text('  Usia     : ${profile.age.toString()} Tahun',style: TextStyle(fontSize: 15,)),
                          Padding(padding: const EdgeInsets.all(3)),
                        ],
                      ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.orange,
                                    title: Text("Peringatan !",style: TextStyle(color: Colors.red) ),
                                    content: Text(
                                        "Anda yakin ingin menghapus profil data ${profile.name}?",style: TextStyle(color: Colors.white) ),
                                    actions: <Widget>[
                                      OutlineButton(
                                        child: Text("Iya", style: TextStyle(color: Colors.blue),),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService
                                              .deleteProfile(profile.id)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Penghapusan data sukses")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Penghapusan data gagal", )));
                                            }
                                          });
                                        },
                                      ),
                                      OutlineButton(
                                        child: Text("Tidak",style: TextStyle(color: Colors.blue),),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10) ),
                        OutlineButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return FormAddScreen(profile: profile);
                                }));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),),
                        Padding(padding: EdgeInsets.all(10) ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }
}
