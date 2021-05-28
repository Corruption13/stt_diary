import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:webview_flutter/webview_flutter.dart';

class TestEditor extends StatefulWidget {


  @override
  _TestEditor createState() => _TestEditor();
}

class _TestEditor extends State<TestEditor> {

  String _counter = "Test";
  String _speechText = "";
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  bool isListening = false;

  void _debugPrint() async{
    final txt = await keyEditor.currentState.getText();

    setState(() {
      if(txt.length>100)
        _counter = txt.substring(0, 100);
      else
        _counter = txt;
    });
  }

  void _debugSTT() async{
    final txt = await keyEditor.currentState.getText();
    stt.SpeechToText speech = stt.SpeechToText();
    void status(String s){
      print(s);

    }
    void result(SpeechRecognitionResult x){
      print(x);
      setState(() {
        _speechText = x.recognizedWords.toString();
      });
    }
    void error(SpeechRecognitionError e){
      print(e);
    }
    isListening = !isListening;

    bool available = await speech.initialize( onStatus: status, onError: error);
    if ( available || isListening) {
      speech.listen( onResult: result );
      String data = _speechText;
      WebViewController _controller;

      String txt = data
          .replaceAll("'", '\\"')
          .replaceAll('"', '\\"')
          .replaceAll("[", "\\[")
          .replaceAll("]", "\\]")
          .replaceAll("\n", "<br/>")
          .replaceAll("\n\n", "<br/>")
          .replaceAll("\r", " ")
          .replaceAll('\r\n', " ");


    }
    else{
      setState(() {
        _counter = "Not Listening";
      });
    }

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(

        body: Center(

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_counter),
                HtmlEditor(
                  hint: "",
                  //value: "text content initial, if any",
                  key: keyEditor,
                  height: 700,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              SizedBox(height: 32,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),

                      ),
                      onPressed: _debugPrint,

                      child: Icon(Icons.save),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: _debugSTT,

                      child: Icon(Icons.mic),
                    ),
                  ),

                  SizedBox(
                    width: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),

                      ),
                      onPressed: (){},

                      child: Icon(Icons.save),
                    ),
                  ),
                ],
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}