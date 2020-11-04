class Differentiation {
  static String derivative(String func) {
    if (func.contains('+'))
      func = sumRule(func);
    else if (func.contains(')*(')) {
      List<String> splitEqn = func.split(')*(');

      String a = splitEqn[0].replaceRange(0, 1, '');
      String b = splitEqn[1].replaceRange(splitEqn[1].length - 1, splitEqn[1].length, '');

      func = product(a, sumRule(b)) + '+' + product(sumRule(a), b).replaceAll('.0', '');
    } else if (func.contains(')/(')) {
      List<String> splitEqn = func.split(')*(');

      String a = splitEqn[0].replaceRange(0, 1, '');
      String b = splitEqn[1].replaceRange(splitEqn[1].length - 1, splitEqn[1].length, '');

      func = '(' + product(a, sumRule(b)) + '-' + product(sumRule(a), b) + ')/' + product(a, a).replaceAll('.0', '');
    } else if (func.contains('sin') ||
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

  static int findDegree(String poly) {
    List<int> powers = List();
    int index = poly.indexOf('^');
    int degree;

    poly += ' ';

    if (!poly.contains('^') && poly.contains('x')) powers.add(1);

    while (poly.contains('^')) {
      int power;

      while ((int.tryParse(poly[index + 1]) != null) || poly[index + 1] == '.') index++;

      power = int.parse(poly.substring(poly.indexOf('^') + 1, index + 1));
      try {
        poly = poly.replaceAll('^${power.toInt()}', '');
      } catch (e) {
        poly = poly.replaceAll('^$power', '');
      }

      index = poly.indexOf('^');
      powers.add(power);
    }

    degree = powers[0];
    for (int i = 0; i < powers.length; i++) if (powers[i] > degree) degree = powers[i];

    return degree;
  }

  static List<double> coefficents(String poly) {
    int degree = findDegree(poly);
    List<double> coefficents = List();

    for (int i = 0; i <= degree; i++) {
      if (i == 0) {
        List<String> terms = poly.split('+');
        List<String> finalTerms = List();
        int constIndex;
        bool hasConstTerm = false;

        for (int i = 0; i < terms.length; i++) finalTerms.addAll(terms[i].split('-'));

        finalTerms.forEach((element) {
          if (!element.contains('x')) hasConstTerm = true;

          if (hasConstTerm) constIndex = finalTerms.indexOf(element);
        });

        if (hasConstTerm) {
          poly.lastIndexOf('-' + finalTerms[constIndex]) != -1
              ? coefficents.add(double.parse('-' + finalTerms[constIndex]))
              : coefficents.add(double.parse(finalTerms[constIndex]));
        } else {
          coefficents.add(0);
        }
      } else if (i == 1) {
        if (poly.contains('x-') || poly.contains('x+')) {
          int index = poly.lastIndexOf('x');

          if (poly[index - 1] != '*') {
            coefficents.add(1);
          } else {
            index = poly.lastIndexOf('*x');

            while ((double.tryParse(poly[index - 1]) != null) || poly[index - 1] == '.') {
              if (index == 1) {
                index = 0;

                break;
              } else {
                index--;
              }
            }

            coefficents.add(double.parse(poly.substring(index, poly.lastIndexOf('*x'))));
          }
        } else
          coefficents.add(0);
      } else {
        if (poly.contains('x^$i')) {
          int index = poly.lastIndexOf('x^$i');

          if (index == 0) {
            coefficents.add(1);
          } else if (poly[index - 1] != '*') {
            coefficents.add(1);
          } else {
            index = poly.lastIndexOf('*x^$i');

            while ((double.tryParse(poly[index - 1]) != null) || poly[index - 1] == '.') {
              if (index == 1) {
                break;
              } else {
                index--;
              }
            }

            coefficents.add(double.parse(poly.substring(index - 1, poly.lastIndexOf('*x^$i'))));
          }
        } else
          coefficents.add(0);
      }
    }

    return List.from(coefficents.reversed);
  }

  static String product(String poly1Str, String poly2Str) {
    List<double> poly1 = coefficents(poly1Str);
    List<double> poly2 = coefficents(poly2Str);

    List<double> prod = List(poly1.length + poly2.length - 1);

    prod.fillRange(0, prod.length, 0);

    for (int i = 0; i < poly1.length; i++) {
      for (int j = 0; j < poly2.length; j++) {
        prod[i + j] += poly1[i] * poly2[j];
      }
    }

    String product = '';

    for (int i = prod.length - 1; i >= 0; i--) {
      product += prod[prod.length - i - 1].toString();
      if (i != 0) product += i == 1 ? '*x' : '*x^$i';

      if (i != 0) product += (prod[prod.length - i] < 0 ? '' : "+");
    }

    return product;
  }

  static String sumRule(String func) {
    List<String> terms = func.split('+');
    List<String> finalTerms = List();
    List<String> diffTerms = List();

    for (int i = 0; i < terms.length; i++) finalTerms.addAll(terms[i].split('-'));

    diffTerms = finalTerms.map(Differentiation.derivative).toList();

    for (int i = finalTerms.length - 1; i >= 0; i--) {
      func = func.replaceFirst(finalTerms[i], diffTerms[i]);
    }

    func = func.replaceAll('-0', '');
    func = func.replaceAll('+0', '');

    print(func.replaceAll('.0', ''));

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
