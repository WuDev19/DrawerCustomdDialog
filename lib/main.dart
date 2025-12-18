import 'package:drawer_customdialog/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final OverlayEntry? _overlay;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo Drawer"),
          backgroundColor: Colors.greenAccent,
        ),
        body: const HomePage(),
        drawer: Builder(
          builder: (context) {
            return Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Item 1"),
                    subtitle: Text("Content 1"),
                    onTap: () {
                      showGeneralDialog(
                        //tự custom dialog
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          //trả về view của dialog
                          return Align(
                            // phải dùng Align hoặc Center hoặc Positioned bọc bên ngoài thì chỉnh kích thước mới có hiệu lực
                            alignment: Alignment.center,
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.cyan,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                child: Text("Demo"),
                              ),
                            ),
                          );
                        },
                        transitionBuilder: //định nghĩa cách dialog xuất hiện
                        (context, animation, secondaryAnimation, child) {
                          return ScaleTransition(
                            //có nhiều các transaction, chỉ cần gõ transaction ra là ok
                            // position: Tween(
                            //   begin: Offset(1, 0),
                            //   end: Offset.zero,
                            // ).animate(animation),
                            scale: Tween( //custom khoảng giá trị cho Animation<double>
                              begin: 0.8,
                              end: 1.0,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    subtitle: Text("Content 2"),
                    onTap: () {
                      showOverlay(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    _overlay = OverlayEntry(
      builder: (context) {
        return Text("HIHIHI");
      },
    );
    Overlay.of(context).insert(_overlay!);
  }

}
