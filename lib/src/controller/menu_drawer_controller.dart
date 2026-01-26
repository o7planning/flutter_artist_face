part of '../face_screen.dart';

class MenuDrawerController {
  bool _isMenuDrawerExpanded = true;

  bool get isExpanded => _isMenuDrawerExpanded;

  final List<State> _stateListeners = [];

  void _addStateListener(State state) {
    _stateListeners.add(state);
  }

  void setExpanded({required bool expanded}) {
    _isMenuDrawerExpanded = expanded;
    update();
  }

  void toggle() {
    setExpanded(expanded: !_isMenuDrawerExpanded);
  }

  void update() {
    for (State state in [..._stateListeners]) {
      if (state.mounted) {
        state.setState(() {});
      } else {
        _stateListeners.remove(state);
      }
    }
  }
}
