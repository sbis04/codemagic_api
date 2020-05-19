import 'package:codemagic_api/api_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio _dio;
  String _buildId;
  String _appName;
  bool _isBuilding;
  bool _isFinished;

  Map _map;
  String _status;
  var entryList;

  @override
  void initState() {
    super.initState();
    _status = 'Initializing';
    _isBuilding = false;
    _appName = '';

    _map = {
      "token": null,
      "appId": null,
      "workflowId": null,
      "branch": null,
      "flutter": null,
      "xcode": null,
      "cocoapods": null,
    };

    entryList = _map.entries.toList();

    int i = 0;

    for (String initValue in APIDetails.initialValue) {
      _map[entryList[i].key] = initValue;
      i++;
    }
  }

  void _postData() async {
    BaseOptions options = new BaseOptions(
        baseUrl: 'https://api.codemagic.io',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": _map['token'],
        });

    _dio = new Dio(options);

    try {
      Response response = await _dio.post(
        "/builds",
        data: {
          "appId": _map['appId'],
          "workflowId": _map['workflowId'],
          "branch": _map['branch'],
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _isBuilding = true;
        });

        Map buildMap = response.data['build'];
        String id = buildMap['_id'].toString();

        Map appMap = response.data['application'];
        String name = appMap['appName'].toString();

        setState(() {
          _buildId = id;
          _appName = name;
        });
        print('BUILD ID: $_buildId');
      }
    } catch (e) {
      print(e);
    }
  }

  void _cancelBuild() async {
    try {
      Response response = await _dio.post(
        "/builds/$_buildId/cancel",
      );
      if (response.statusCode == 200) {
        setState(() {
          _isBuilding = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _getResponse() async {
    try {
      Response response = await _dio.get(
        "/builds/$_buildId",
      );
      if (response.statusCode == 200) {
        Map buildMap = response.data['build'];
        String status = buildMap['status'].toString();

        setState(() {
          _status = status;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<int> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<int> stream = Stream<int>.periodic(interval, response);

    if (_status == 'finished') {
      setState(() {
        _isFinished = true;
        _isBuilding = false;
      });
    } else if (_status == 'canceled') {
      setState(() {
        _isBuilding = false;
        _isFinished = false;
      });
    }

    return stream;
  }

  int response(int value) {
    _getResponse();
    return value;
  }

  Widget _buildButton() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          _status = 'Initializing';
        });
        if (_map['token'] != null &&
            _map['appId'] != null &&
            _map['workflowId'] != null)
          _postData();
        else {
          print('Required parameters are not supplied');
        }
      },
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
        child: Text(
          'START BUILD',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }

  Widget _descriptionTitle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            _isBuilding
                ? Expanded(
                    child: StreamBuilder(
                      stream: _stream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _appName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    _status.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  )
                : Container(),
            RaisedButton(
              onPressed: _isBuilding ? _cancelBuild : null,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Codemagic API'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 40),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  _textTile(
                    text: APIDetails.text[i],
                    hint: APIDetails.hint[i],
                    initialValue: APIDetails.initialValue[i],
                    index: i,
                    obscure: i == 0 ? true : false,
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                  child: Text(
                    'ENVIRONMENT VARIBLES',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    '(optional)',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                for (int i = 4; i < 7; i++)
                  _textTile(
                    text: APIDetails.text[i],
                    hint: APIDetails.hint[i],
                    initialValue: APIDetails.initialValue[i],
                    index: i,
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    child: _isBuilding ? _descriptionTitle() : _buildButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textTile({
    @required String text,
    @required String hint,
    @required int index,
    @required String initialValue,
    bool obscure,
  }) {
    if (obscure == null) {
      obscure = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 15.0),
          child: TextFormField(
            initialValue: initialValue,
            cursorColor: Colors.black,
            obscureText: obscure,
            onChanged: (value) {
              setState(() {
                _map[entryList[index].key] = value;
              });
            },
            decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: hint,
            ),
          ),
        )
      ],
    );
  }
}
