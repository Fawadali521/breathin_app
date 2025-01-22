import 'package:breathin/core/constants/index.dart';
import 'package:breathin/core/constants/text_styles.dart';
import 'package:breathin/core/extensions/sizedbox_extension.dart';
import 'package:breathin/features/home/home_view_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationViewModel(),
      child: Consumer<BottomNavigationViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Home",
              style: kTextStyle3,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      model.auth.signout();
                    },
                    child: Text(
                      "Logout",
                      style: kTextStyle5,
                    ),
                  ),
                ),
                20.h.ph,
                // Sound List
                Expanded(
                  child: ListView.builder(
                    itemCount: model.soundFiles.length,
                    itemBuilder: (context, index) {
                      String sound = model.soundFiles[index];
                      return ListTile(
                        title: Text(
                          sound.split('/').last, // Show only file name
                          style: kTextStyle3,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            model.currentlyPlaying == sound
                                ? Icons.stop
                                : Icons.play_arrow,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            model.playAudio(sound);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
