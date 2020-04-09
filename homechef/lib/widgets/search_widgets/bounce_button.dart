import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homechef/models/diet_model.dart';

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;
  final Function onTap;
  final bool chosenDiet;
  final AnimationController parentController;
  final List<AnimationController> parentControllers;

  AnimatedButton(
      {this.initialText,
      this.finalText,
      this.iconData,
      this.iconSize,
      this.animationDuration,
      this.buttonStyle, this.onTap, 
      this.chosenDiet,
      this.parentControllers,
      this.parentController});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {
  
  AnimationController _controller;
  ButtonState _currentState;
  Duration _smallDuration;
  Animation<double> _scaleFinalTextAnimation;

  @override
  void initState() {
    super.initState();

    _currentState = widget.chosenDiet ? ButtonState.SHOW_TEXT_ICON : ButtonState.SHOW_ONLY_TEXT;
    _smallDuration = Duration(milliseconds: (widget.animationDuration.inMilliseconds * 0.2).round());
    _controller = widget.parentController;

    _controller.addListener(() {
      double _controllerValue = _controller.value;

      if (!widget.chosenDiet) { 
        if (_controllerValue < 0.2) {
          setState(() {
            _currentState = ButtonState.SHOW_ONLY_TEXT;
          });
        } else if (_controllerValue > 0.8) {
          setState(() {
            _currentState = ButtonState.SHOW_TEXT_ICON;
          });
        }
      } else {
        if (_controllerValue < 0.2) {
        setState(() {
          _currentState = ButtonState.SHOW_TEXT_ICON;
        });
      } else if (_controllerValue > 0.8) {
        setState(() {
          _currentState = ButtonState.SHOW_ONLY_TEXT;
        });
      }
      }


    });

    _controller.addStatusListener((currentStatus) {
      if (currentStatus == AnimationStatus.completed || currentStatus == AnimationStatus.dismissed) {
        return widget.onTap();
      }
    });

    _scaleFinalTextAnimation = widget.chosenDiet ? Tween<double>(begin: 1.0, end: 0.0).animate(_controller) : Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      borderRadius:
          BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
      child: InkWell(
        onTap: () {

          // This onTap handles the animation and not the actual logic for diet buttons
          // Whenever one button is tapped, check if the tapped button is the one chosen, then undo it to not chosen (reverse)
          // If not the current chosen one, the tapped button is changed to chosen, while all others will be back to false
          // The actual logic will happen in widget.onTap when the animation is completed/dismissed 

          if (!widget.chosenDiet) {
            if (!dietOptions[encodeDietName(widget.initialText)]) {
              
              widget.parentControllers.forEach((AnimationController parentController) {
                if (parentController != _controller) parentController.reverse();
              });
              _controller.forward();
            
            } else {
              _controller.reverse();
            }

          // Handling the case searchScreen init with already chosen diet, meaning everything is in reversed, begining from tweening from 1.0 to 0.0
          // Need to fix this for convenience later  
          } else {
            if (!dietOptions[encodeDietName(widget.initialText)]) {
              
              widget.parentControllers.forEach((AnimationController parentController) {
                if (parentController != _controller) parentController.forward();
              });
              _controller.reverse();
            
            } else {
              _controller.forward();
            }
          }
        },

        child: AnimatedContainer(
          duration: _smallDuration,
          height: widget.iconSize + 16,

          decoration: BoxDecoration(
            color: (_currentState == ButtonState.SHOW_TEXT_ICON)
                ? widget.buttonStyle.secondaryColor
                : widget.buttonStyle.primaryColor,
            border: Border.all(
                color: Colors.transparent),
            borderRadius: BorderRadius.all(
                Radius.circular(widget.buttonStyle.borderRadius)),
          ),

          padding: EdgeInsets.symmetric(
            // horizontal:
            //     (_currentState == ButtonState.SHOW_ONLY_ICON) ? 16.0 : 48.0,
            horizontal: 5.0,
            vertical: 8.0,
          ),
          
          child: AnimatedSize(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: _smallDuration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                (_currentState == ButtonState.SHOW_TEXT_ICON)
                    ? Flexible(
                      child: Icon(
                          widget.iconData,
                          size: widget.iconSize,
                          color: Colors.black87,
                        ),
                    )
                    : Container(),
                SizedBox(
                  width: _currentState == ButtonState.SHOW_TEXT_ICON ? 5.0 : 0.0,
                ),
                Flexible(child: getTextWidget())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (_currentState == ButtonState.SHOW_ONLY_TEXT) {
      return AutoSizeText(
        widget.initialText,
        maxLines: 1,
        maxFontSize: 15.0,
        style: widget.buttonStyle.initialTextStyle,
      );
    } else {
      return ScaleTransition(
        scale: _scaleFinalTextAnimation,
        child: AutoSizeText(
          widget.initialText,
          maxLines: 1,
          maxFontSize: 15.0,
          style: widget.buttonStyle.finalTextStyle,
        ),
      );
    }
  }
}

class ButtonStyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyle(
      {this.primaryColor,
      this.secondaryColor,
      this.initialTextStyle,
      this.finalTextStyle,
      this.elevation,
      this.borderRadius});
}

enum ButtonState { SHOW_ONLY_TEXT, SHOW_ONLY_ICON, SHOW_TEXT_ICON }