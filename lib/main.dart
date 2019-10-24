import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'gamelogic.dart';

void main() {
  runApp(MaterialApp(
    home: TicTacToePage(),
  ));
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Widget createCell(int r, int c) {
    return Expanded(
      child: OneBox(
        buttonChild: updateIcon(r, c),
        colors:
            colorBoard[r][c] ? Colors.yellow.withOpacity(.5) : Colors.white24,
        onPressed: () {
          updateBox(r, c);
          setState(() {});
        },
      ),
    );
  }

  Widget createRow(int r) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          createCell(r, 0),
          createCell(r, 1),
          createCell(r, 2)
        ],
      ),
    );
  }

  @override
  void initState() {
    print("Init Called");
    controller = AnimationController(
        duration: Duration(milliseconds: 600), vsync: this, value: 0);
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.addListener(() {
      print(controller.value);
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Transform.scale(
                  scale: winnerCheck(board)
                      ? Tween(begin: 1.0, end: 1.2).transform(controller.value)
                      : 1.0,
                  child: Text(
                    currentStatus(),
                    style: TextStyle(
                        fontSize: 25,
                        color: winnerCheck(board)
                            ? ColorTween(
                                    begin: Colors.white, end: Colors.yellow)
                                .transform(controller.value)
                            : Colors.white.withOpacity(0.6),
                        fontFamily: 'Quicksand'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    createRow(0),
                    createRow(1),
                    createRow(2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: FlatButton(
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          setState(() {});
                        },
                        child: Text("Reset",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateBox(int r, int c) {
    if (legitMove(board[r][c])) {
      board[r][c] = currentPlayer;
      changePlayerIfGameIsNotOver();
    }
  }
}

class OneBox extends StatefulWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;

  OneBox(
      {this.buttonChild = const Text(''),
      this.onPressed,
      this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
}

class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    print("Init Called");
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation animation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceOut,
    );
    return GestureDetector(
      onTap: () {
        if (widget.buttonChild == null) {
          controller.forward(from: 0);
        }
        widget.onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: Tween(
            begin: .0,
            end: 1.0,
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween(
              begin: 2.0,
              end: 1.0,
            ).animate(animation),
            child: widget.buttonChild,
          ),
        ),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),
    );
  }
}
