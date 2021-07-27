import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xilhamalisso/Autenticacao/AuteticacaoUser/AutenticaUser.dart';

class Introducao extends StatefulWidget {
  @override
  _IntroducaoState createState() => _IntroducaoState();
}

class _IntroducaoState extends State<Introducao> {
  Future verficaPrimeiravez() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _ver = (preferences.getBool("ver") ?? false);
    if (_ver) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new AutenticaUser(),
      ));
    } else {
      await preferences.setBool("ver", true);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new Introducao(),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    verficaPrimeiravez();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        doneColor: Colors.blue,
        animationDuration: 350,
        done: Text("DONE"),
        skip: Text("SKIP"),
        next: Icon(Icons.arrow_forward_rounded),
        showNextButton: true,
        showDoneButton: true,
        showSkipButton: true,
        dotsFlex: 4,
        curve: Curves.fastLinearToSlowEaseIn,
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (builder) => AutenticaUser(),
            ),
          );
        },
        pages: [
          PageViewModel(
            title: "Primeira Pagina",
            image: Center(
              child: Image.asset("assets/foto_intro/Lawyer_Flatline.png"),
            ),
            body:
                "Um campo de chat que so será accionado mediante o pagamento de uma taxa de 50mt. Tera que ter opções de pagamento Mpsa ou mesmo por conta bancária. Para alem do chat devera ter a opcao de chamada para que o interessado poça se comunicar com os nossos profissionais.",
          ),
          PageViewModel(
            title: "Segunda Pagina",
            decoration: PageDecoration(
                imagePadding: EdgeInsets.zero,
                bodyTextStyle: TextStyle(fontSize: 19.0),
                descriptionPadding: EdgeInsets.all(9)),
            body:
                "legislações videos etc.De igual forma tera que constar do website um canto para sugerir ao visitante que baixe o aplicativo.	O aplicativo ou App deve conter:",
            image: Center(
              child: Image.asset("assets/foto_intro/Chat_Flatline.png"),
            ),
          ),
          PageViewModel(
            title: "Primeira Pagina",
            body:
                "legislações videos etc.De igual forma tera que constar do website",
            image: Center(
              child:
                  Image.asset("assets/foto_intro/Online payment_Flatline.png"),
            ),
          ),
        ],
      ),
    );
  }
}
