import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

int _playerOneScore = 0;
int _playerTwoScore = 0;
int _leftDiceNumber = 1;
int _righttDiceNumber = 1;
int _totalPlayed = 0;
bool _playerOneTurns = true;
bool _playerTwoTurns = false;
bool _isGameStart = true;
bool _isGameRestart = false;
String _result = "";

class _DiceState extends State<Dice> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (_totalPlayed == 15) {
        if (_playerOneScore > _playerTwoScore) {
          _result = 'Player one is win!';
        } else if (_playerTwoScore > _playerOneScore) {
          _result = 'Player two is win!';
        } else {
          _result = 'Match is Drawn!';
        }
        _isGameRestart = true;
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Dice Game')),
      body: SafeArea(
        child: _isGameStart
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isGameStart = false;
                          _playerOneScore = 0;
                          _playerTwoScore = 0;
                          _totalPlayed = 0;
                          _result = "";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Start',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _isGameRestart
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Player One Scores: $_playerOneScore',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade800),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Player Two Scores: $_playerTwoScore',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green.shade800),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$_result',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isGameRestart = false;
                              _playerOneScore = 0;
                              _playerTwoScore = 0;
                              _totalPlayed = 0;
                              _result = "";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Restart',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/dice_$_leftDiceNumber.png',
                            height: 150,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Image.asset(
                            'assets/images/dice_$_righttDiceNumber.png',
                            height: 150,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Player One Scores: $_playerOneScore',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue.shade800),
                          ),
                          Text(
                            'Player Two Scores: $_playerTwoScore',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.green.shade800),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: _playerOneTurns
                            ? ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _leftDiceNumber = Random().nextInt(6) + 1;
                                    _playerOneTurns = false;
                                    _playerTwoTurns = true;
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.blue.shade800)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    'Player One',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _righttDiceNumber = Random().nextInt(6) + 1;
                                    _playerTwoTurns = false;
                                    _playerOneTurns = true;
                                    if (_leftDiceNumber > _righttDiceNumber) {
                                      _playerOneScore = _playerOneScore + 1;
                                    } else if (_righttDiceNumber >
                                        _leftDiceNumber) {
                                      _playerTwoScore = _playerTwoScore + 1;
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Oops! Turns is Drawn!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    _totalPlayed = _totalPlayed + 1;
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.green.shade800)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    'Player Two',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: Text(
                          'Total Played: $_totalPlayed',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
