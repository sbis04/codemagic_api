import 'package:codemagic_api/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildConfigScreen extends StatefulWidget {
  final Application application;
  BuildConfigScreen(this.application);

  @override
  _BuildConfigScreenState createState() => _BuildConfigScreenState();
}

class _BuildConfigScreenState extends State<BuildConfigScreen> {
  String _selectedBranch;
  List<String> _branches;

  List<String> _workflowIds = [];
  List<String> _workflowNames = [];
  String _selectedWorkflowName;

  @override
  void initState() {
    super.initState();
    _branches = widget.application.branches.reversed.toList();
    _workflowIds = widget.application.workflowIds.reversed.toList();

    Map<String, dynamic> allWorkflowInfo = widget.application.workflows;

    for (String workflowId in _workflowIds) {
      Map info = allWorkflowInfo['$workflowId'];
      _workflowNames.add(info['name']);
    }
    _workflowNames = _workflowNames.reversed.toList();
    _selectedBranch = _branches[0];
    _selectedWorkflowName = _workflowNames[0];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            bottom: 30.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Container(
            child: Text(
              'START',
              style: GoogleFonts.rubik(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.orange[800],
            ),
            Container(
              color: Colors.orange[800],
              height: height * 0.22,
              width: double.maxFinite,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.02, bottom: 20.0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          )),
                      Center(
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
                              'Build Config'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.84,
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(),
                                  Text(
                                    widget.application.appName,
                                    style: GoogleFonts.varelaRound(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  // TODO: URL Launcher for GitHub Link
                                  Text(
                                    widget.application.repository.htmlUrl.substring(8),
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 16,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  _dropDownTile(
                                    'Select Branch',
                                    _branches,
                                    _selectedBranch,
                                    width,
                                    (String value) {
                                      setState(() {
                                        _selectedBranch = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              _dropDownTile(
                                'Select Workflow',
                                _workflowNames,
                                _selectedWorkflowName,
                                width,
                                (String value) {
                                  setState(() {
                                    _selectedWorkflowName = value;
                                  });
                                },
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
                                  child: Text(
                                    'ENVIRONMENT VARIBLES',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    '(optional)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  _inputTile(
                                    text: 'Flutter',
                                    hint: 'Enter the Flutter verison',
                                  ),
                                  _inputTile(
                                    text: 'Xcode',
                                    hint: 'Enter the Xcode verison',
                                  ),
                                  _inputTile(
                                    text: 'CocoaPods',
                                    hint: 'Enter the CocoaPods verison',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.04,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            // colors: <Color>[Colors.white, Colors.transparent],
                          ).createShader(bounds);
                        },
                        child: Container(
                          height: height * 0.08,
                          width: width,
                          color: Colors.white,
                        ),
                        blendMode: BlendMode.dstATop,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputTile({String text, String hint}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
            child: TextFormField(
              initialValue: '',
              cursorColor: Colors.black,
              onChanged: (value) {
                // setState(() {
                //   _map[entryList[index].key] = value;
                // });
              },
              decoration: new InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 3),
                ),
                contentPadding: EdgeInsets.only(left: 15, bottom: 25, top: 25, right: 15),
                hintText: hint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDownTile(
    String tileHeading,
    List<String> list,
    String selectedListItem,
    double width,
    Function(String) callback,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
            child: Text(
              tileHeading,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: Container(
              width: width * 0.9,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.orange, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    icon: Icon(Icons.arrow_drop_down),
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: selectedListItem,
                    onChanged: (value) {
                      callback(value);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
