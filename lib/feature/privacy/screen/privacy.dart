import 'package:flutter/material.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomAppbar(
                  title: "Privacy Policy",
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: 20),
                Text(
                  text1,
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  text2,
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final String text1 =
      "Odio eu feugiat pretium nibh ipsum consequat nisl. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Elit eget gravida cum sociis natoque penatibus. Sed elementum tempus egestas sed sed risus. Id interdum velit laoreet id donec ultrices. Fermentum leo vel orci porta non pulvinar neque laoreet. In mollis nunc sed id semper risus in hendrerit gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Erat nam at lectus urna duis convallis convallis. Interdum velit laoreet id donec ultrices tincidunt arcu. Sit amet venenatis urna cursus eget nunc scelerisque viverra. Purus in massa tempor nec feugiat. Hendrerit gravida rutrum quisque non tellus orci ac auctor augue. Aenean vel elit scelerisque mauris pellentesque.";
  final String text2 =
      "Odio eu feugiat pretium nibh ipsum consequat nisl. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Elit eget gravida cum sociis natoque penatibus. Sed elementum tempus egestas sed sed risus. Id interdum velit laoreet id donec ultrices. Fermentum leo vel orci porta non pulvinar neque laoreet. In mollis nunc sed id semper risus in hendrerit gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Erat nam at lectus urna duis convallis convallis. Interdum velit laoreet id donec ultrices tincidunt arcu.";
}
