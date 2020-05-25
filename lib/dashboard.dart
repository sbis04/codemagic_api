import 'package:codemagic_api/build_config_screen.dart';
import 'package:codemagic_api/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  final CodemagicInfo codemagicInfo;
  Dashboard(this.codemagicInfo);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Application> applications;

  @override
  void initState() {
    super.initState();
    applications = widget.codemagicInfo.applications;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.orange[800],
            height: height * 0.20,
            width: double.maxFinite,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Codemagic Connect'.toUpperCase(),
                        style: GoogleFonts.rubik(
                          fontSize: 15,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Applications'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.85,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      10.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: ListView.builder(
                  itemCount: applications.length,
                  itemBuilder: (context, index) {
                    return applications[index].iconUrl != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 15.0,
                            ),
                            child: Material(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: Colors.orangeAccent,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BuildConfigScreen(widget.codemagicInfo),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.orange, width: 3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 44,
                                          backgroundColor: Colors.blue,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 40,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Image.network(
                                                applications[index].iconUrl,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            // backgroundImage: NetworkImage(
                                            //   applications[index].iconUrl,
                                            // ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                applications[index].appName,
                                                style: GoogleFonts.varelaRound(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                applications[index]
                                                    .repository
                                                    .htmlUrl
                                                    .substring(8),
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 16,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
