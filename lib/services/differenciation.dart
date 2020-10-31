class Differenciation {
  static String derivative(String func) {
    if (func.contains('sin') ||
        func.contains('cos') ||
        func.contains('tan') ||
        func.contains('cot') ||
        func.contains('sec') ||
        func.contains('csc'))
      func = diffTrig(func);
    else if (func.contains('^x'))
      func = diffVarPow(func);
    else
      func = diffPow(func);

    return func;
  }

  static String diffPow(String func) {
    if (double.tryParse(func) != null) {
      func = '0';
    } else {
      if (!func.contains('^')) func += '^1';

      String base = func.split('^')[0];
      int pow = int.parse(func.split('^')[1] ?? 0);

      if (pow - 1 == 1)
        func = '$pow*$base';
      else if (pow - 1 == 0 && func.contains('*'))
        func = '${base.substring(0, base.length - 2)}';
      else if (pow - 1 == 0)
        func = pow.toString();
      else
        func = '$pow*$base^${pow - 1}';

      List<String> prodList = func.split('*');
      int prod = 1;

      for (int i = 0; i < prodList.length - 1; i++) prod *= int.parse(prodList[i]);

      func = prod == 1 ? prodList[prodList.length - 1] : '$prod*${prodList[prodList.length - 1]}';
    }

    return func;
  }

  static String diffTrig(String func) {
    String angle = func.substring(func.indexOf('(') + 1, func.lastIndexOf(')'));

    if (double.tryParse(angle) != null) {
      func = '0';
    } else {
      if (angle == 'x') angle += '^1';

      int power = (int.parse(angle.split('^')[1] ?? 1)) * 2;
      String base = angle.split('^')[0];

      if (func.contains('sin^-1'))
        func = derivative(angle) + '/sqrt(1-$base^$power)';
      else if (func.contains('cos^-1'))
        func = '-' + derivative(angle) + '/sqrt(1-$base^$power)';
      else if (func.contains('tan^-1'))
        func = derivative(angle) + '/($base^$power+1)';
      else if (func.contains('cot^-1'))
        func = '-' + derivative(angle) + '/($base^$power+1)';
      else if (func.contains('sec^-1'))
        func = derivative(angle) + '/|x|*sqrt(1-$base^$power)';
      else if (func.contains('csc^-1'))
        func = '-' + derivative(angle) + '/|x|*sqrt(1-$base^$power)';
      else if (func.contains('sin'))
        func = derivative(angle) + '*cos($angle)';
      else if (func.contains('cos'))
        func = '-' + derivative(angle) + '*sin($angle)';
      else if (func.contains('tan'))
        func = '(' + derivative(angle) + '*sec($angle))^2';
      else if (func.contains('cot'))
        func = '-(' + derivative(angle) + '*csc($angle))^2';
      else if (func.contains('sec'))
        func = derivative(angle) + '*' + 'sec($angle)*tan($angle)';
      else
        func = '-' + derivative(angle) + '*' + 'csc($angle)*cot($angle)';
    }

    if (func.substring(0, 4) == '-(1*') {
      func = func.replaceRange(2, 4, '');
    } else if (func.substring(0, 3) == '-1*' || func.substring(0, 3) == '-(*') {
      func = func.replaceRange(1, 3, '');
    } else if (func.substring(0, 2) == '1*') {
      func = func.replaceRange(0, 2, '');
    }

    return func;
  }

  static String diffVarPow(String func) {
    String base = func.split('^')[0];
    String pow = func.split('^')[1] ?? 1;

    if (base != 'e') {
      func = 'ln($base)*$base^$pow';
    }

    return func;
  }
}
