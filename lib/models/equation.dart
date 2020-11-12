class Equation {
  static String equation = '';

  static String toLatex(String equation) => equation.contains(')/(')
      ? equation
          .replaceAll('.0', '')
          .replaceAll('^1.0', '')
          .replaceAll('^1', '')
          .replaceAll('*1.0', '')
          .replaceAll('*1', '')
          .replaceAll('1.0*', '')
          .replaceAll('1*', '')
          .replaceAll('+0', '')
          .replaceAll('0+', '')
          .replaceAll('*', '')
          .replaceAll(')/(', '}{')
          .replaceAll('(', '\\frac{')
          .replaceAll(')', '}')
      : equation
          .replaceAll('.0', '')
          .replaceAll('^1.0', '')
          .replaceAll('^1', '')
          .replaceAll('*1.0', '')
          .replaceAll('*1', '')
          .replaceAll('1.0*', '')
          .replaceAll('1*', '')
          .replaceAll('+0', '')
          .replaceAll('0+', '')
          .replaceAll('*', '');
}
