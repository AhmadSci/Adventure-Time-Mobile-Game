// ignore_for_file: file_names

import 'package:flame/components.dart';

final cinamonSprites = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(
  (i) => Sprite.load('CinnamonBun/C-($i).png'),
);

final pbSprites = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(
  (i) => Sprite.load('PB/PB$i.png'),
);

final bananaSprites = [1, 2, 3, 4, 5, 6, 7, 8].map(
  (i) => Sprite.load('BananaGuard/$i.png'),
);

final gunterSprites = [1, 2, 3, 4, 5, 6, 7, 8].map(
  (i) => Sprite.load('ICE/penguin/G$i.png'),
);

final iceWormSprites = [1, 2, 3, 4, 5, 6, 7, 8].map(
  (i) => Sprite.load('ICE/iceWorm/iceWorm$i.png'),
);

final iceKingSprites = [1, 2, 3, 4].map(
  (i) => Sprite.load('ICE/iceKing/I$i.png'),
);
