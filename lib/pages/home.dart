import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    //set background
    String bgimage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    var bgColor = data['isDayTime'] ? Colors.lightBlueAccent[200] : Colors.indigo[700];
    var color = data['isDayTime'] ? Colors.black : Colors.white;




    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgimage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDayTime': result['isDayTime'],
                      'flag': result['flag']
                    };
                  });
                },
                  icon: Icon(
                      Icons.edit_location,
                    color: color,

                  ),
                  label: Text(
                      'Select Your location',
                    style: TextStyle(
                      color: color
                    ),
                  ),
              ),
                SizedBox(height: 20.0),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: color

                    ),
                   ),
                  ],
                 ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                  fontSize: 66.0,
                  color: color
                ),
              ),
                ],
               ),
            ),
          ),
      ),
    );
  }
}


