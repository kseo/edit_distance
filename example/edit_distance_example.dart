// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:edit_distance/edit_distance.dart';

main() {
  Levenshtein d = new Levenshtein();
  print(d.distance('witch', 'kitsch')); // 2
  print(d.normalizedDistance('witch', 'kitsch')); // 0.3333333333333333
}

