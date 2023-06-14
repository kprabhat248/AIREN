import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:android_intent/android_intent.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isLoading = true;
  bool _isInAppView = true;

  Future<void> _launchURL(BuildContext context) async {
    final url = 'https://www.google.com/maps/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        enableJavaScript: true,
        headers: {
          'user-agent': Platform.isIOS
              ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1'
              : ''
        },
        universalLinksOnly: true,
        webOnlyWindowName: '_self',
        enableDomStorage: true,
      );
    } else {
      final snackBar = SnackBar(
        content: Text('Could not launch Google Maps.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _launchGoogleEarth(BuildContext context) async {
    if (Platform.isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: 'googleearth://',
      );
      await intent.launch();
    } else if (await canLaunch('googleearth://')) {
      await launch('googleearth://', forceSafariVC: false, forceWebView: false);
    } else if (await canLaunch('market://details?id=com.google.earth')) {
      await launch('market://details?id=com.google.earth');
    } else if (await canLaunch(
        'https://play.google.com/store/apps/details?id=com.google.earth')) {
      await launch(
          'https://play.google.com/store/apps/details?id=com.google.earth');
    } else {
      final snackBar = SnackBar(
        content: Text('Could not launch Google Earth.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _isInAppView
                ? _launchURL(context)
                : _launchGoogleEarth(context),
            icon: Icon(_isInAppView ? Icons.open_in_browser : Icons.terrain),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.network(
            'https://source.unsplash.com/random/800x800/?img=1',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.white.withOpacity(0.1),
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Map Screen!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        },
                        child: Text('Load Map'),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
