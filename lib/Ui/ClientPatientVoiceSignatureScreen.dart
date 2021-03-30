import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:evv_plus/Ui/VerificationMenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
enum visitVerification { patient, voice }
class ClientPatientVoiceSignatureScreen extends StatefulWidget {
  CompletedNoteResponse completedNoteResponse;
  var finalValue;
  ClientPatientVoiceSignatureScreen(this.completedNoteResponse,this.finalValue);

  @override
  _ClientPatientVoiceSignatureScreenState createState() =>
      _ClientPatientVoiceSignatureScreenState();
}

class _ClientPatientVoiceSignatureScreenState
    extends State<ClientPatientVoiceSignatureScreen>
    with TickerProviderStateMixin {
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  Recording _recording;
  Timer _t;
  Widget _buttonIcon =
      SvgPicture.asset(MyImage.mic_icon, height: 120, width: 120);
  Widget _playIcon = SvgPicture.asset(MyImage.play_icon, height: 68, width: 68);
  AudioPlayer audioPlayer;
  String localFilePath;
  AnimationController _animationIconController1;
  bool issongplaying = false;
  AudioCache audioCache;
  Duration _duration = new Duration();
  AuthViewModel _nurseViewModel = AuthViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      _prepare();
    });
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.durationHandler = (d) => setState(() {
          print("duration" + _duration.inSeconds.toString());
          _duration = d;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            centerTitle: true,
            title: Container(
              child: Text(
                LabelStr.lblclientSignature,
                style: AppTheme.boldSFTextStyle().copyWith(fontSize: 24),
              ),
            ),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: Text(LabelStr.lblDone,
                      style: AppTheme.boldSFTextStyle().copyWith(
                        fontSize: 20,
                        color: HexColor("#1a87e9"),
                      )),
                ),
              )
            ],
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: HexColor("#efefef"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            _opt();
                          },
                          child: _buttonIcon) /**/,
                      SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset(MyImage.equalizer_icon,
                          height: 120, width: 120),
                      SizedBox(
                        height: 30,
                      ),
                      Text(LabelStr.lblRecording,
                          style: AppTheme.regularSFTextStyle().copyWith(
                            fontSize: 20,
                            color: HexColor("#000000"),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${_recording?.duration?.inSeconds}",
                          style: AppTheme.boldSFTextStyle().copyWith(
                            fontSize: 26,
                            color: HexColor("#3d3d3d"),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "This will take 30 second voice recording and will be\n saved once click on done",
                        textAlign: TextAlign.center,
                        style: AppTheme.regularSFTextStyle().copyWith(
                          fontSize: 16,
                          color: HexColor("#000000"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!issongplaying) {
                              audioPlayer.play(_recording.path);
                            } else {
                              audioPlayer.pause();
                            }
                            issongplaying
                                ? _animationIconController1.reverse()
                                : _animationIconController1.forward();
                            issongplaying = !issongplaying;
                          });
                        },
                        child: ClipOval(
                          child: Container(
                            color: HexColor("#83cff2"),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                size: 55,
                                progress: _animationIconController1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*InkWell(
                          onTap: () {
                            _playType();
                          },
                          child: _playIcon),*/
                      /*SvgPicture.asset(MyImage.play_icon,
                              height: 68, width: 68)),*/
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    HexColor("#1785e9"),
                                    HexColor("#83cff2")
                                  ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: TextButton(
                                child: Text(LabelStr.lblSubmit,
                                    style: AppTheme.boldSFTextStyle().copyWith(
                                        fontSize: 18, color: Colors.white)),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  checkConnection().then((isConnected) {

                                    submitCall();

                                  });
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var current = await _recorder.current();
      setState(() {
        _recording = current;
      });
      _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
        var current = await _recorder.current();
        setState(() {
          if (_recording?.duration?.inSeconds == 30) {
            _stopRecording();
          }
          _recording = current;
          _t = t;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    _t.cancel();
    print("path-->>" + _recording?.path.toString());


    setState(() {
      _recording = result;
    });
  }

  Future _prepare() async {
    await _init();
    var result = await _recorder.current();
    setState(() {
      _recording = result;
      _buttonIcon = _playerIcon(_recording.status);
    });
  }

  Widget _playerIcon(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.Initialized:
        {
          return SvgPicture.asset(MyImage.mic_icon, height: 120, width: 120);
        }
      case RecordingStatus.Recording:
        {
          return Container(height: 120, width: 120, child: Icon(Icons.stop));
        }
      default:
        return SvgPicture.asset(MyImage.mic_icon, height: 120, width: 120);
    }
  }

  void _opt() async {
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _start();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }

      default:
        break;
    }

    setState(() {
      _buttonIcon = _playerIcon(_recording.status);
    });
  }

  void submitCall()
  {
    File file = File(_recording?.path);
    Uint8List bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    print(base64Image);
    validationForCollectClientSignature(base64Image);
  }

  void validationForCollectClientSignature(String img64) {
    Utils.showLoader(true, context);
    _nurseViewModel.getPatientSignature(
        "1",
        null,
        img64,
        widget.completedNoteResponse.nurseId.toString(),
        widget.completedNoteResponse.patientId.toString(),
        widget.completedNoteResponse.id.toString(), (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          widget.finalValue=visitVerification.voice;
          Utils.isPatientVoiceCompleted=true;
          Utils.navigateToScreen(
              context, VerificationMenuScreen(widget.completedNoteResponse));

        });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
