import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:developer' as developer;

Color lGreen = Color(0x009C92);

class ProfileApp extends StatefulWidget {
  bool onProfile = false;
  int measures = 16;
  //ProfileApp(this.index);
  void onProfilePage() {
    //measures += 16;
    //developer.log('on', name: 'my.app.category');
    //developer.log(measures.toString(), name: 'my.app.category');
  }
  void offProfilePage() {
    //measures += 0;
    //developer.log('off', name: 'my.app.category');
  }
  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: ListView(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueAccent, lGreen])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/V0HROXuGQsWKqNBi7sm1QREroH-sAZZrsV5BiYJ9okZTS6NeHk0-RXt2fGa5Accl-GQmDg=s85",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Renato Freire",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Medidas Realizadas",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "16",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Faturas Entregues",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "15",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Crédito",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "R\$ 82",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Column(
            children: [
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.history),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text('Histórico',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.05264214),
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.error),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text('Sinalizar um problema',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.05264214),
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.settings),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text('Configurações',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.05264214),
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int count;

  AnimatedCount(
      {Key key,
      @required this.count,
      @required Duration duration,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _count;

  @override
  Widget build(BuildContext context) {
    return new Text(_count.evaluate(animation).toString());
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count = visitor(
        _count, widget.count, (dynamic value) => new IntTween(begin: value));
  }
}
