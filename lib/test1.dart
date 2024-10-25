class PrivateConstructor {
  OneMorePrivateClass o = OneMorePrivateClass._();
  void printOne() {
    print(o.hashCode);
  }
}

class OneMorePrivateClass {
  OneMorePrivateClass._();
}
