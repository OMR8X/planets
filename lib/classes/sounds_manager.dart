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
    backgroundPlayer = AudioPlayer()..setVolume(0.3);
    backgroundPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        playBackground();
      }
    });
    rockerPlayer = AudioPlayer();
    spacePlayer = AudioPlayer();
    effectPlayer = AudioPlayer();
    currentSound = "";
    playBackground();
  }

  stopBackGround() {
    currentSound = "";
    backgroundPlayer.stop();
  }

  stopRocket() {
    currentSound = "";
    rockerPlayer.stop();
  }

  stopSpace() {
    currentSound = "";
    spacePlayer.stop();
  }

  stopEffect() {
    currentSound = "";
    effectPlayer.stop();
  }

  playBackground() {
    var name = "playBackground";
    if (currentSound == name) return;
    currentSound = name;
    backgroundPlayer.stop();
    backgroundPlayer.play(
      AssetSource(SoundsAssetsPath.background),
    );
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
  }

  playSpace2() {
    var name = "playSpace2";
    if (currentSound == name) return;
    currentSound = name;
    spacePlayer.stop();
    spacePlayer.play(
      AssetSource(SoundsAssetsPath.space2),
    );
  }

  //
  playRocket1() {
    var name = "playRocket1";
    if (currentSound == name) return;
    currentSound = name;
    rockerPlayer.stop();
    rockerPlayer.play(
      AssetSource(SoundsAssetsPath.rocket1),
    );
  }

  playRocket2() {
    var name = "playRocket2";
    if (currentSound == name) return;
    currentSound = name;
    rockerPlayer.stop();
    rockerPlayer.play(
      AssetSource(SoundsAssetsPath.rocket2),
    );
  }

  playRocket3() {
    var name = "playRocket3";
    if (currentSound == name) return;
    currentSound = name;
    rockerPlayer.stop();
    rockerPlayer.play(
      AssetSource(SoundsAssetsPath.rocket3),
    );
  }

  //
  deepBass() {
    var name = "deepBass";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer.stop();
    effectPlayer.play(
      AssetSource(SoundsAssetsPath.deepBass),
    );
  }

  hit() {
    var name = "hit";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer.stop();
    effectPlayer.play(
      AssetSource(SoundsAssetsPath.hit),
    );
  }

  orchestra() {
    var name = "orchestra";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer.stop();
    effectPlayer.play(
      AssetSource(SoundsAssetsPath.orchestra),
    );
  }

  pageChange() {
    var name = "pageChange";
    if (currentSound == name) return;
    currentSound = name;
    effectPlayer.stop();
    effectPlayer.play(
      AssetSource(SoundsAssetsPath.pageChange),
      volume: 0.2,
    );
  }
}
