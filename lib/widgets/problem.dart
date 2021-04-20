import 'package:flutter/material.dart';

// class ProblemWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Reportar um problema'),),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProblemWidget extends StatefulWidget {
  @override
  _ProblemWidgetState createState() => _ProblemWidgetState();
}

class _ProblemWidgetState extends State<ProblemWidget> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Relatar um problema'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text('Foto do problema',
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: MediaQuery.of(context).size.width * 0.05264214),
                textScaleFactor: 1.0,
                overflow: TextOverflow.ellipsis),
            Container(
                child: GestureDetector(
              onTap: getImage,
              child: Card(
                  //margin: const EdgeInsets.all(20),
                  borderOnForeground: true,
                  color: Colors.grey[200],
                  child: _image == null
                      ? Container(
                          height: 250,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(Icons.add_a_photo),
                                ),
                                Center(
                                    child: Text(
                                        'Aperte para adicionar uma imagem'))
                              ]),
                        )
                      : Image.file(_image)),
            )),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Text('Descrição do problema',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.05264214),
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis),*/
                    TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Descrição do problema',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor entre com uma descrição do problema';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: FloatingActionButton.extended(
                          onPressed: () {
                            _image = null;
                            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SentPage(),
                                ));
                          },
                          icon: Icon(Icons.send),
                          label: Text('Enviar')),
                    )
                  ]),
            )
          ],
        )
        /*Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),*/
        /*floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),*/
        );
  }
}

class SentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Informação enviada!'),
    ));
  }
}
