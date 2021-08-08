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

class TelaLigar extends StatefulWidget {
  final Chamada chamada;

  TelaLigar({Key key, this.chamada}) : super(key: key);

  @override
  _TelaLigarState createState() => _TelaLigarState();
}

class _TelaLigarState extends State<TelaLigar> {
  final MetodoChmada metodoChmada = MetodoChmada();
  UsuarioProvider usuarioProvider;
  StreamSubscription callStreamSubscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff0f1921),
                Color(0xff2f0015),
              ]),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  "A Ligar...",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Container(
                  child: CircleAvatar(
                      maxRadius: 79,
                      minRadius: 79,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage(widget.chamada.receiverPic)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                child: Center(
                  child: Text(
                    widget.chamada.receiverName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Text(
                    "+258845982017",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            )),
                        onPressed: () async =>
                            await metodoChmada.endCall(chamada: widget.chamada),
                        child: Icon(
                          Icons.call_end,
                        ),
                      ),
                    ),
                  )
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
