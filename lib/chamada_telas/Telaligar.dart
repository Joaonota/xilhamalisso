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
  bool visibelN = false;

  String displayTime = "00:00:00";
  var watchPhome = Stopwatch();
//
  final MetodoChmada metodoChmada = MetodoChmada();
  UsuarioProvider usuarioProvider;
  StreamSubscription callStreamSubscription;
//
  startTimer() {
    Timer(Duration(seconds: 1), iniciaCont);
    watchPhome.start();
  }

  iniciaCont() {
    if (watchPhome.isRunning) {
      startTimer();
    }
    setState(() {
      displayTime = watchPhome.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (watchPhome.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (watchPhome.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void autoFalante() {
    setState(() {
      autoF = !autoF;
    });
    _engine.setEnableSpeakerphone(autoF);
  }

  void ficarmudo() {
    setState(() {
      mudo = !mudo;
    });

    _engine.muteLocalAudioStream(mudo);
  }

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
                child: visibelN == false
                    ? Text(
                        "A Ligar...",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        "Em Conversa..",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
                  child: Column(
                    children: [
                      visibelN == false
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.record_voice_over,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  displayTime,
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 170,
            ),
            Container(
              child: Column(
                children: [
                  visibelN == false
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100)),
                                child: TextButton(
                                  onPressed: ficarmudo,
                                  child: Icon(
                                    mudo ? Icons.mic_off : Icons.mic,
                                    color: mudo ? Colors.blue : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: TextButton(
                                    onPressed: autoFalante,
                                    child: Icon(
                                      autoF
                                          ? Icons.speaker
                                          : Icons.speaker_notes_off,
                                      color: autoF ? Colors.blue : Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100)),
                            child: TextButton(
                              onPressed: () async => await metodoChmada.endCall(
                                  chamada: widget.chamada),
                              child: Icon(
                                Icons.call_end,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
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
  bool mudo = false;
  bool autoF = false;
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
    visibelN = false;
    watchPhome.stop();
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
          visibelN = true;
          startTimer();
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          visibelN = false;
        });
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
