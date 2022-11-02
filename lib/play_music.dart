import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  late AudioPlayer player;
  late AudioCache cache;
  bool isPlaying = false;
  // لمعرفة الملف الصوتي وهو باي فترة
  Duration currentPostion = Duration();
  // لمعرفة طول الاغنية
  Duration musicLength = Duration();
  int index = 0;
  List<String> mylist = ['a.mp3', 'b.mp3', 'c.mp3', 'd.mp3', 'e.mp3'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // هذه المكتبة لتشغيل الاناشيد داخل الهاتف او على الانترنت
    player = AudioPlayer();
    // هذه المكتبة لتشغيل الاناشيد التي داخل التطبيق
    cache = AudioCache(fixedPlayer: player);
    index = 0;
    // cache.loadAll(['1.mp3','2.mp3','3.mp3', '4.mp3', '5.mp3']);
    setUp();
  }

  setUp() {
    // هذه تقول لنا ان الملف الصوتي موجود بالثانية رقم كذا
    player.onAudioPositionChanged.listen((d) {
      // Give us the current position of the Audio file
      setState(() {
        // ونحن نقول له خذ القيمة
        currentPostion = d;
      });
      // هذه تعطينا طول الملف كاملا
      player.onDurationChanged.listen((d) {
        //Returns the duration of the audio file
        setState(() {
          musicLength = d;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: const Text(
              'Play Music',
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            alignment: Alignment.center,
            color: Colors.indigo,
          ),
          // السلايدر و التوقيت
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // التوقيت الحالي وهو الذي على اليسار
              Text('${currentPostion.inSeconds}'),
              Container(
                  width: 300,
                  child: Slider(
                      value: currentPostion.inSeconds.toDouble(),
                      max: musicLength.inSeconds.toDouble(),
                      // كلما تغير نقطة السلايدر تتغير القيمة وتحديثها
                      onChanged: (val) {
                        seekTo(val.toInt());
                      })),
              // التوقيت الكلي وهو على اليمين
              Text('${musicLength.inSeconds}'),
            ],
          ),

          Row(
            /* قبل هذا الراو كان فيه ازرار تقديم وتاخير الاغنية بمقدار 10 ثواني هكذا
             children: [
              IconButton(
                icon: const Icon(Icons.first_page), iconSize: 35,
                onPressed: (){

                  if ( currentPostion.inSeconds == 0 || <  currentPostion.inSeconds < 10) ){
                  اقفز الى الوضع 0
                  seekTo( 0 );
                  و الا
                }else ( currentPostion.inSeconds > 10 )
                  seekTo( currentPostion.inSeconds - 10 );

                }, 
                ),
              
              IconButton(
                icon: const Icon(Icons.play_arrow), iconSize: 35,
                onPressed: (){
                        ///////////////
                        اذا كانت الاغنية شغالة
                        if(isPlaying) {
                      الحالة    
                    setState(() {
                     
                     isPlaying = false
                    
                    });
                  هذه دالة نعرفها في الخارج
                   stopMusic();

                  //هكذا تعرف 
                    playMusic () {
                        player.pause('اسم الاغنية');
                       
                        void initState() { لكن قبل ذلك يجب ان نقوم ب هذه الكتابة ف الاعلى داخل  
                          هي مكتوبة في الاعلى
                        player AudioPlayer ();
                        
                        بعدها نربطهما هكذا لان الكاش ليس فيه ستوب او بوس  
                        cache AudioCache (fixedPlayer : player );


 


                  }
                  else{
                    setState(() {
                      isPlaying= true;

                    });
                    هذه دالة نعرفها في الخارج
                   playMusic ();

                    //هكذا تعرف 
                    playMusic () {
                        cache.play('اسم الاغنية');
                    };

                  }
    
                        /////////////////
                }, 
              
               اذا كانت الاغنية تشتغل اعطيها شكل البوس و الا فاعطيها شكل التشغيل 
               icon: isPlaying?Icon(Icons.pause): Icon(Icons.play_arrow) ),
             
              IconButton(
              icon: const Icon(Icons.last_page), iconSize: 35,
              onPressed: (){
                اذا كان الوضع الحالي اقل من المدة الكلية ناقص 10 ثواني 
                if ( currentPostion < musicLength - Duration(seconds: 10) ){
                  اقفز الى الوضع الحالي زائد 10
                  seekTo( currentPostion.inSecond + 10 );
                  و الا
                }else {
                  اقفز الى طول الملف الاغنية اي الى الاخير 
                  seekTo( musicLength.inSecond );
                  وغير الحالة الى 
                     setState(() {
                      isPlaying = false;
                    });
                      استدعي دالة 
                    player.stop();
                }
              }, 
              ), ],
             */
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                // للرجوع للاغنية السابقة
                icon: const Icon(Icons.first_page),
                iconSize: 35,
                onPressed: () {
                  // 
                  if (index > 0) {
                    //
                    setState(() {
                      index--;
                      isPlaying = true;
                      print('$index');
                    });
                    // شغل الاغنية ذات الاندكس 
                    cache.play(mylist[index]);
                  } else {
                    setState(() {
                      isPlaying = true;
                    });
                    print('$index');
                    cache.play(mylist[index]);
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  if (isPlaying) {
                    setState(() {
                      isPlaying = false;
                    });
                    stopMusic();
                  } else {
                    setState(() {
                      isPlaying = true;
                    });
                    playMusic(mylist[index]);
                  }
                },
                icon: isPlaying
                    ? Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
                iconSize: 35,
              ),
               // الاغنية التالية
              IconButton(
                icon: Icon(Icons.last_page),
                iconSize: 35,
                onPressed: () {
                  if (index < mylist.length - 1) {
                    print('$index');
                    setState(() {
                      index = index + 1;
                      isPlaying = true;
                    });
                    print('$index');
                    cache.play(mylist[index]);
                  } else {
                    // معناه تحديث للحالة
                    setState(() {
                      index = 0;
                      isPlaying = true;
                    });
                    // يطبع لنا الاندكس التي نحن فيها
                    print("$index");
                    cache.play(mylist[index]);
                  }
                },
              )
            ],
          ),
          Text('${mylist[index]}')
        ],
      ),
    );
  }

  playMusic(String song) {
    // to play the Audio
    cache.play(song);
  }

  stopMusic() {
    // to pause the Audio
    player.pause();
  }

// هذه الدالة للقفز على السيك بار عندما يحرك بالاصبع  او   وتستقبل ايضا قيمة الموضع الذي فيه النقطة
  seekTo(int sec) {
    // To seek the audio to a new position
    player.seek(Duration(seconds: sec));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }
}
