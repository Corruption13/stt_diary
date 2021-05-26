import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TestEditor extends StatefulWidget {


  @override
  _TestEditor createState() => _TestEditor();
}

class _TestEditor extends State<TestEditor> {
  stt.SpeechToText speech = stt.SpeechToText();

  String _counter = "Test";
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  void _debugPrint() async{
    final txt = await keyEditor.currentState.getText();

    setState(() {
      _counter = txt;
    });
  }

  void _debugSTT() async{
    final txt = await keyEditor.currentState.getText();

    setState(() {
      _counter = txt;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Editor"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_counter),
            HtmlEditor(
              hint: "Your text here...",
              //value: "text content initial, if any",
              key: keyEditor,
              height: 400,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _debugPrint,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}