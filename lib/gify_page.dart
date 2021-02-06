import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class GifyPage extends StatefulWidget {
  @override
  _GifyPageState createState() => _GifyPageState();
}

class _GifyPageState extends State<GifyPage> {
  final TextEditingController controller = TextEditingController();

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.green800,
      appBar: AppBar(title: Text('GIFY App'), backgroundColor: Vx.green500),
      body: Theme(
        data: ThemeData.dark(),
        child: Column(
          children: [
            "The Best GIF Engine".text.white.xl3.make().objectCenter(),
            Row(
              children: [
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
                  onPressed: () {},
                  shape: Vx.roundedSm,
                  child: Text("Go!"),
                ).h8(context),
              ],
            ).p8(),
            VxConditional(
              condition: data != null,
              builder: (context) => Text('Data available'),
              fallback: (context) => "Nothing found".text.make(),
            ),
          ],
        ).p16(),
      ),
    );
  }
}
