class Integration {
  static String integrate(String func) {
    if (func.contains('+'))
      func = sumRule(func);
    else if (func.contains('sin') ||
        func.contains('cos') ||
        func.contains('tan') ||
        func.contains('cot') ||
        func.contains('sec') ||
        func.contains('csc'))
      func = intTrig(func);
    else if (func.contains('^x'))
      func = intVarPow(func);
    else
      func = intPow(func);

    return func;
  }

  static String sumRule(String func) {
    List<String> terms = func.split('+');
    List<String> finalTerms = List();
    List<String> diffTerms = List();

    for (int i = 0; i < terms.length; i++) finalTerms.addAll(terms[i].split('-'));

    diffTerms = finalTerms.map(Integration.integrate).toList();

    for (int i = finalTerms.length - 1; i >= 0; i--) {
      func = func.replaceFirst(finalTerms[i], diffTerms[i]);
    }

    func = func.replaceAll('-0', '');
    func = func.replaceAll('+0', '');

    print(func.replaceAll('.0', ''));

    return func;
  }

  static int hcf(int a, int b) {
    if (a == 0) return b;
    if (b == 0) return a;
    if (a == b) return a;
    if (a > b) return hcf(a - b, b);

    return hcf(a, b - a);
  }

  static String intPow(String func) {
    int power;
    int a = 1;
    int b;
    int c;
    String base;
    String coefficent;
    List<int> prodList;

    if (double.tryParse(func) != null) {
      func = 'x';
    } else {
      if (!func.contains('^') && !func.contains('/')) func = func.substring(0, func.indexOf('x') + 1) + '^1/1';
      if (!func.contains('^'))
        func = func.substring(0, func.indexOf('x') + 1) + '^1' + func.substring(func.indexOf('x') + 1);
      if (!func.contains('/')) func += '/1';
      if (!func.contains('*')) func = '1*' + func;

      power = int.parse(func.split('/')[0].split('^')[1]);
      base = func.split('^')[0];
      coefficent = base.split('x')[0];

      prodList = coefficent.substring(0, coefficent.length - 1).split('*').map(int.parse).toList();

      for (int i = 0; i < prodList.length; i++) a *= prodList[i];

      b = int.parse(func.split('/')[1]) * (power + 1);
      c = hcf(a, b);

      a = a ~/ c;
      b = b ~/ c;

      if (b == 1 && a == 1)
        func = 'x^${power + 1}';
      else if (b == 1)
        func = '$a*x^${power + 1}';
      else if (a == 1)
        func = 'x^${power + 1}/$b';
      else
        func = '$a*x^${power + 1}/$b';
    }

    return func;
  }

  static String intTrig(String func) {
    if (func.contains('sec^2(x)') || func.contains('sec(x)*sec(x)'))
      func = func.replaceAll(func.contains('sec^2(x)') ? 'sec^2(x)' : 'sec(x)*sec(x)', 'tan(x)');
    else if (func.contains('sec(x)*tan(x)') || func.contains('tan(x)*sec(x)'))
      func = func.replaceAll(func.contains('sec(x)*tan(x)') ? 'sec(x)*' : '*sec(x)', '');
    else if (func.contains('csc(x)*cot(x)') || func.contains('cot(x)*csc(x)'))
      func = func.contains('cot(x)*csc(x)')
          ? func.replaceAll('cot(x)*', '-')
          : func.replaceAll('csc(x)*cot(x)', '-csc(x)');
    else if (func.contains('sin'))
      func = func.replaceAll('sin', '-cos');
    else if (func.contains('cos'))
      func = func.replaceAll('cos', 'sin');
    else if (func.contains('tan'))
      func = func.replaceAll('tan(x)', '-ln|cos(x)|');
    else if (func.contains('cot'))
      func = func.replaceAll('cot(x)', 'ln|sin(x)|');
    else if (func.contains('sec'))
      func = func.replaceAll('sec(x)', 'ln|csc(x)+cot(x)|');
    else if (func.contains('cos')) func = func.replaceAll('cos', 'sin');

    return func;
  }

  static String intVarPow(String func) {
    if (!func.contains('e')) func = func + '/' + func.split('^')[0];

    return func;
  }
}
