import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/src/legacy_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts _tts = FlutterTts();

  void _search(String query) async {
    if (query.isNotEmpty) {
      String url = Uri.https('www.googleapis.com', '/customsearch/v1', {
        'key': 'AIzaSyDP3zw7crFn2FuwTratLcCzxyWhTz6TB1k',
        'cx': '03c228b31f7e34346',
        'q': query,
        'num': '10',
      }).toString();

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> items = data['items'];
        setState(() {
          _results = items.map<Map<String, dynamic>>((item) {
            return {
              'title': item['title'],
              'link': item['link'],
              'snippet': item['snippet'],
            };
          }).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error searching')),
        );
      }
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      // changed canLaunchUrl to canLaunch, removed 'as Uri'
      await launch(url,
          forceSafariVC: false,
          forceWebView:
              false); // changed launchUrl to launch, added options for opening URL
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (error) => print('onError: $error'),
    );

    if (available) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
      );
    }
  }

  Future<void> _stopListening() async {
    _speech.stop();
  }

  Future<void> _speak(String text) async {
    await _tts.setLanguage('en-US');
    await _tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (query) => _search(query),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => _search(_controller.text),
                    ),
                    IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: _startListening,
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: _stopListening,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final result = _results[index];
                return ListTile(
                  title: Text(result['title']),
                  subtitle: Text(result['snippet']),
                  onTap: () => _launchURL(result['link']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
