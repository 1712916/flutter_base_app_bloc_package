enum Env {
  dev, prod
}

extension Name on Env {
  String getName() {
    switch (this) {
      case Env.dev:
        return 'DEV';
      case Env.prod:
        return 'PROD';
    }
  }
}
