import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/AgoraSDK/Settings.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodoChamada.dart';
import 'package:xilhamalisso/models/chamada.dart';
import 'package:xilhamalisso/provider/UserProvider.dart';

class TelaChamada extends StatefulWidget {
  final Chamada chamada;

  TelaChamada({@required this.chamada});

  @override
  _TelaChamadaState createState() => _TelaChamadaState();
}

class _TelaChamadaState extends State<TelaChamada> {
  final MetodoChmada metodoChmada = MetodoChmada();
  UsuarioProvider usuarioProvider;
  StreamSubscription callStreamSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.brown,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "A Ligar",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            /* Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey,
              ),
              child: SizedBox(
                width: 180,
                height: 180,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/imagem_Splash/capa.png",
                  ),
                ),
              ),
            ),*/
            CircleAvatar(
              maxRadius: 90,
              minRadius: 90,
              backgroundImage: NetworkImage(widget.chamada.receiverPic),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                widget.chamada.receiverName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () async =>
                        await metodoChmada.endCall(chamada: widget.chamada),
                    child: Icon(Icons.call_end),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                    onPressed: () {},
                    child: Icon(Icons.call),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static final _users = <int>[];

  bool muted = false;
  RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback();
    initializeAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _users.clear();
    // Destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    callStreamSubscription.cancel();
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.joinChannel(null, widget.chamada.chamadaID, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableAudio();
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          print('onError: $code');
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        print('onJoinChannel: $channel, uid: $uid');
      },
      leaveChannel: (stats) {
        setState(() {
          print('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        print('userJoined: $uid');
        setState(() {
          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        metodoChmada.endCall(chamada: widget.chamada);
        print('userJoined: $uid');
        setState(() {
          final info =
              'onUserOffline: a: ${uid.toString()}, b: ${widget.chamada.toString()}';
          _infoStrings.add(info);
        });
      },
    ));
  }

  final _infoStrings = <String>[];
  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

      callStreamSubscription = metodoChmada
          .callStream(uid: usuarioProvider.getUSer.uid)
          .listen((DocumentSnapshot ds) {
        // defining the logic
        switch (ds.data()) {
          case null:
            // snapshot is null which means that call is hanged and documents are deleted
            Navigator.pop(context);
            break;

          default:
            break;
        }
      });
    });
  }
}
