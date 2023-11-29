import 'package:audioplayers/audioplayers.dart';
import 'package:planets/helpers/assets_path.dart';

class SoundsManager {
  static final SoundsManager _singleton = SoundsManager._internal();

  factory SoundsManager() {
    return _singleton;
  }

  SoundsManager._internal();
  //
  late AudioPlayer backgroundPlayer;
  late AudioPlayer rockerPlayer;
  late AudioPlayer spacePlayer;
  late AudioPlayer effectPlayer;
  late String currentSound;

  //
  init() {
    rockerPlayer = AudioPlayer();
    spacePlayer = AudioPlayer();
    effectPlayer = AudioPlayer();
    backgroundPlayer = AudioPlayer()..setVolume(0.3);
    backgroundPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        playBackground();
      }
    });
    rockerPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        playRocket1();
      }
    });

    currentSound = "";
    playBackground();
  }

  stopBackGround() {
    currentSound = "";
    if (backgroundPlayer.state == PlayerState.playing) {
      backgroundPlayer.stop();
    }
  }

  stopRocket() {
    currentSound = "";
    if (rockerPlayer.state == PlayerState.playing) {
      rockerPlayer.stop();
    }
  }

  stopSpace() {
    currentSound = "";
    if (spacePlayer.state == PlayerState.playing) {
      spacePlayer.stop();
    }
  }

  stopEffect() {
    currentSound = "";
    if (effectPlayer.state == PlayerState.playing) {
      effectPlayer.stop();
    }
  }

  playBackground() {
    var name = "playBackground";
    if (currentSound == name) return;
    currentSound = name;
    backgroundPlayer.stop();
    backgroundPlayer.play(
      AssetSource(SoundsAssetsPath.background),
    );
    currentSound = "";
  }

  //
  playSpace1() {
    var name = "playSpace1";
    if (currentSound == name) return;
    currentSound = name;
    spacePlayer.stop();
    spacePlayer.play(
      AssetSource(SoundsAssetsPath.space1),
    );
    currentSound = "";
  }

  playSpace2() {
    var name = "playSpace2";
    if (currentSound == name) return;
    currentSound = name;
    spacePlayer.stop();
    spacePlayer.play(
      AssetSource(SoundsAssetsPath.space2),
    );
    currentSound = "";
  }

  //
  playRocket1() {
    var name = "playRocket1";
    if (currentSound == name) return;
    currentSound = name;

    rockerPlayer.play(
      AssetSource(
        SoundsAssetsPath.rocket1,
      ),
      volume: rockerPlayer.volume,
    );

    currentSound = "";
  }

  setRocketVolume(double volume) {
    print(volume);
    rockerPlayer.setVolume(volume);
  }

  hit() {
    var name = "hit";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer.stop();
    effectPlayer.play(
      AssetSource(SoundsAssetsPath.hit),
    );
    currentSound = "";
  }

  orchestra() {
    var name = "orchestra";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer.stop();
    effectPlayer.play(AssetSource(SoundsAssetsPath.orchestra), volume: 0.3);
    currentSound = "";
  }

  pageChange() {
    var name = "pageChange";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer = AudioPlayer();
    effectPlayer.play(
      AssetSource(SoundsAssetsPath.pageChange),
      volume: 0.2,
    );
    currentSound = "";
  }
}
