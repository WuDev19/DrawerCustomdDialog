import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LayerLink layerLink = LayerLink();
  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Scaffold.of(context).openDrawer(); //mở drawer
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            child: Text("Click me", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 20),
          CompositedTransformTarget(
            link: layerLink,
            child: ElevatedButton(
              onLongPress: () => hideOverlay(),
              onPressed: () {
                showOverlay();
              },
              child: Text("Overlay"),
            ),
          ),
        ],
      ),
    );
  }

  void showOverlay() {
    entry = OverlayEntry(
      //mặc định full màn hình
      builder: (context) {
        return Stack(
          //tách 2 lớp, 1 lớp phủ full màn hình để bấm ra ngoài có thể hide overlay
          children: [
            GestureDetector(//ko có con sẽ chiếm full màn hình
              //lớp để hide
              onTap: () => hideOverlay(),
              behavior: HitTestBehavior
                  .translucent, //xử lý cho cùng 1 sự kiện nếu các widget trùng nhau đều có
              //tất cả đều cần phải có size, chỉ ảnh hưởng trong size đó
              //deferToChild thì phụ thuộc vào child, chỉ khi child có size, click vào nó thì mới bắt được sự kiện
              //opaque thì widget nằm trên sẽ nuốt sự kiện widget nằm dưới, nghĩa là widget dưới ko nhân được sự kiện
              //translucent thì cho xuyên qua và cùng phản hồi
              //ví dụ cho dễ hiểu là 2 tấm kính chồng lên nhau, thằng trên đục (opaque) thì thằng đằng sau chả biết gì cả
              //thằng trên trong suốt (translucent) thì thằng dưới sẽ biết :))
              // deferToChild	"Tôi chỉ nhận nếu bạn bấm trúng con của tôi. Nếu bấm vào vùng trống của tôi, tôi coi như không thấy."
              // opaque	"Tôi chiếm toàn bộ vùng này. Dù tôi có trống rỗng, tôi vẫn nhận sự kiện và chặn đứng không cho ai bên dưới nhận."
              // translucent	"Tôi nhận sự kiện ngay cả ở vùng trống, nhưng tôi không chặn. Tôi cho phép bạn bấm xuyên qua tôi để trúng thằng dưới."
            ),
            CompositedTransformFollower(
              //lớp để show overlay
              link: layerLink, //dùng chung 1 link với target
              offset: Offset(0, 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.green,
                ),
                child: Text("Overlay"),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }
}
