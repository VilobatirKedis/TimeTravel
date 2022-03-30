import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:time_travel/screens/camera/main.dart';

Future<CameraDescription> openCameras() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  return firstCamera;
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final _widgetOptions = [
      const Text(
        'Discover',
        //style: optionStyle,
      ),
      const Text(
        'Discover',
        //style: optionStyle,
      ),
      FutureBuilder(
        future: openCameras(),
        builder: (context, AsyncSnapshot<CameraDescription> snapshot) {
          if(snapshot.hasData) {  
            return TakePictureScreen(camera: snapshot.data!);
          }

          else return const CircularProgressIndicator();
        },
      ),
      const Text(
        'Discover',
        //style: optionStyle,
      ),
      ElevatedButton(
        child: Text("Log Out"),
        onPressed: () {} /*{
          final provider = Provider.of<GoogleSignUpProvider>(context, listen: false);
          provider.googleLogout();
        }*/,
      )
    ];

    return SafeArea(
        child: Scaffold(
          body:_widgetOptions.elementAt(_selectedIndex),

          bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0), 
            topRight: Radius.circular(4.0), 
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.black45,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: size.height * 0.032,
                  ),
                  label: '',
                  //backgroundColor: kButtonColor
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search_rounded,
                    size: size.height * 0.032,
                  ),
                  label: '',
                  
                  //backgroundColor: kButtonColor
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    size: size.height * 0.032,
                  ),
                  label: '',
                  //backgroundColor: kButtonColor
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.thumb_up_rounded,
                    size: size.height * 0.029,
                  ),
                  label: '',
                  //backgroundColor: kButtonColor
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_rounded,
                    size: size.height * 0.032,
                  ),
                  label: '',
                  //backgroundColor: kButtonColor
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              backgroundColor: Colors.deepPurpleAccent,
              onTap: _onItemTapped,
            ),
          ),
        )
      )
    );
  }
}