import 'package:flutter/material.dart';
import './drawer.dart';
import 'package:wsu_go/constants.dart';
import './building_data.dart';
import 'package:google_fonts/google_fonts.dart';

class MapPage extends StatefulWidget {
  static const String id = 'map_page';

  @override
  _MapPageState createState() => _MapPageState();
}

List<String> image_list = [
  'images/campus_map.png',
  'images/parking.png'
];

class _MapPageState extends State<MapPage> {
  String _currentImage = image_list[0];
  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wichita State University Maps'),
          backgroundColor: shockerYellow,
        ),
        drawer: CustomDrawer(),
        floatingActionButton: NewButton(),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                    children: [
                      Expanded(
                          child: InteractiveViewer(
                              transformationController: _controller,
                              maxScale: 6.0,
                              child: Image.asset(_currentImage)
                          )
                      ),
                      Container(
                          height: 80,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: image_list.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _currentImage = image_list[index];
                                      _controller.value = Matrix4.identity();
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(2),
                                    color: shockerBlack,
                                    child: Image.asset(image_list[index]),
                                  ),
                                );
                              })
                      )
                    ]
                )
            )
        )
    );
  }
}

class NewButton extends StatefulWidget {
  @override
  _NewButtonState createState() => _NewButtonState();
}

class _NewButtonState extends State<NewButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, BuildingData.id);
      },
      icon: Icon(Icons.info),
      label: Text("Building Key"),
      color: shockerYellow,
    );
  }
}
