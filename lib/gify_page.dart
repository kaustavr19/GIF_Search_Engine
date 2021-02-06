import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class GifyPage extends StatefulWidget {
  @override
  _GifyPageState createState() => _GifyPageState();
}

class _GifyPageState extends State<GifyPage> {
  final TextEditingController controller = TextEditingController();
  final String imgUrl =
      "https://api.giphy.com/v1/gifs/search?api_key=pe3ZWyViWslU9f87eJGnEdq3vg4gYkJ0&limit=25&offset=0&rating=G&lang=en&q=";

  var data;
  bool showloading = false;

  getData(String searchText) async {
    showloading = true;
    setState(() {});
    final res = await http.get(imgUrl + searchText);
    data = jsonDecode(res.body)["data"];
    setState(() {
      showloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Vx.green800,
        appBar: AppBar(title: Text('GIFY App'), backgroundColor: Vx.green500),
        body: Theme(
          data: ThemeData.dark(),
          child: Column(children: [
            "The Best GIF Engine".text.white.xl3.make().objectCenter(),
            [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search here',
                  ),
                ),
              ),
              30.widthBox,
              RaisedButton(
                onPressed: () {
                  getData(controller.text);
                },
                shape: Vx.roundedSm,
                child: Text("Go!"),
              ).h8(context),
            ]
                .hStack(
                    axisSize: MainAxisSize.max,
                    crossAlignment: CrossAxisAlignment.center)
                .p24(),
            if (showloading)
              CircularProgressIndicator().centered()
            else
              VxConditional(
                condition: data != null,
                builder: (context) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.isMobileTypeHandset ? 2 : 3,
                  ),
                  itemBuilder: (context, index) {
                    final imgUrl = data[index]["images"]["fixed_height"]
                            ["imgUrl"]
                        .toString();
                    return ZStack(
                      [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                            color: Colors.black.withOpacity(0.8),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                        Image.network(
                          imgUrl,
                          fit: BoxFit.contain,
                        )
                      ],
                      fit: StackFit.expand,
                    ).card.roundedSM.make().p4();
                  },
                  itemCount: data.length,
                ),
                fallback: (context) =>
                    "Nothing found".text.gray500.xl3.makeCentered(),
              ).h(context.percentHeight * 70)
          ]).p16().scrollVertical(physics: NeverScrollableScrollPhysics()),
        ));
  }
}
