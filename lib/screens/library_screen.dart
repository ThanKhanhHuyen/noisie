import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noisie/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            print(snapshot.data);
            return Center(child: Text("No song found!"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  child: ListTile(
                    leading: Icon(Icons.music_note_outlined),
                    title: Text(snapshot.data![index].displayNameWOExt ?? ''),
                    subtitle: Text("${snapshot.data![index].artist ?? ''}"),
                  ),
                );
              },
            );
          }
        });
  }
}
