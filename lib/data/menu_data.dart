import '../models/menu_item.dart';

const menuItems = [
  MenuItem(
    name: 'PARTY SET A (81 PCS)',
    price: 'RM 109.90',
    ratings: 5.0,
    reviews: [
      Review(
        reviewerName: 'Michaerl See',
        reviewerAvatar: 'assets/images/avatars/caleb.png',
        comment: 'Sangat sedap dan segar!',
      ),
      Review(
        reviewerName: 'Caleb Martin',
        reviewerAvatar: 'assets/images/avatars/caleb.png',
        comment: 'Rasanya padu sgt,akn beli lagi',
      ),
    ],
    description:
        "What's Included\n\nNigiri (35 pcs)\n• Inari x 5\n• Tamago x 5\n• Ika x 5\n• Ebi x 5\n• White Tuna x 5\n• Unagi x 5\n• Kani x 5\n\nGunkan (16 pcs)\n• Ebiko x 8\n• Salmon Mayo x 8\n\nMaki (30 pcs)\n• Kappa Maki x 10\n• Sake Maki x 10\n• Tamago Maki x 10",
    imagePath: 'assets/images/foods/party_set/party_set_a.png',
  ),
  MenuItem(
    name: 'PARTY SET B (74 PCS)',
    price: 'RM 99.90',
    ratings: 4.8,
    reviews: [
      Review(
        reviewerName: 'Aina Rahman',
        reviewerAvatar: 'assets/images/avatars/aina.png',
        comment: 'Banyak pilihan, sesuai untuk keluarga!',
      ),
      Review(
        reviewerName: 'Jason Lim',
        reviewerAvatar: 'assets/images/avatars/jason.png',
        comment: 'Fresh and delicious, will order again.',
      ),
    ],
    description:
        "What's Included\n\nNigiri (30 pcs)\n• Inari x 4\n• Tamago x 4\n• Ika x 4\n• Ebi x 4\n• White Tuna x 4\n• Unagi x 5\n• Kani x 5\n\nGunkan (14 pcs)\n• Ebiko x 7\n• Salmon Mayo x 7\n\nMaki (30 pcs)\n• Kappa Maki x 10\n• Sake Maki x 10\n• Tamago Maki x 10",
    imagePath: 'assets/images/foods/party_set/party_set_b.png',
  ),
  MenuItem(
    name: 'CHUKA IDAKO',
    price: 'RM 7.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Aisyah Lee',
        reviewerAvatar: 'assets/images/avatars/aisyah.png',
        comment: 'Sangat sedap dan segar!',
      ),
    ],
    description: 'Baby octopus marinated in a sweet and savory sauce.',
    imagePath: 'assets/images/foods/appetizers/chuka_idako.png',
  ),
  MenuItem(
    name: 'CHUKA KURAGE',
    price: 'RM 8.90',
    ratings: 4.2,
    reviews: [
      Review(
        reviewerName: 'Farid Aziz',
        reviewerAvatar: 'assets/images/avatars/farid.png',
        comment: 'Tekstur rangup, rasa unik!',
      ),
      Review(
        reviewerName: 'Siti Aminah',
        reviewerAvatar: 'assets/images/avatars/siti.png',
        comment: 'Suka sangat jellyfish ni!',
      ),
    ],
    description:
        'Seasoned jellyfish with a crunchy texture and a hint of sesame oil.',
    imagePath: 'assets/images/foods/appetizers/chuka_kurage.png',
  ),
  MenuItem(
    name: 'MOCHI (4PCS)',
    price: 'RM 6.90',
    ratings: 4.7,
    reviews: [
      Review(
        reviewerName: 'Lim Wei',
        reviewerAvatar: 'assets/images/avatars/lim.png',
        comment: 'Lembut dan manis, pencuci mulut terbaik!',
      ),
      Review(
        reviewerName: 'Vaanishri Rama',
        reviewerAvatar: 'assets/images/avatars/nurul.png',
        comment: 'Anak-anak suka sangat mochi ni.',
      ),
    ],
    description:
        'Soft and chewy rice cakes filled with sweet red bean paste. 4 pieces per serving.',
    imagePath: 'assets/images/foods/appetizers/mochi.png',
  ),
  MenuItem(
    name: 'SAKE MAKI',
    price: 'RM 5.90',
    ratings: 4.6,
    reviews: [
      Review(
        reviewerName: 'Hiro Tanaka',
        reviewerAvatar: 'assets/images/avatars/hiro.png',
        comment: 'Salmon roll yang sangat segar!',
      ),
      Review(
        reviewerName: 'Emily Wong',
        reviewerAvatar: 'assets/images/avatars/emily.png',
        comment: 'Simple but delicious, my favourite maki.',
      ),
    ],
    description:
        'Classic salmon maki roll with fresh salmon and seasoned rice, wrapped in seaweed.',
    imagePath: 'assets/images/foods/maki_rolls/sake_maki.png',
  ),
  MenuItem(
    name: 'TAMAGO MAKI',
    price: 'RM 4.90',
    ratings: 4.4,
    reviews: [
      Review(
        reviewerName: 'Ayu Rahim',
        reviewerAvatar: 'assets/images/avatars/ayu.png',
        comment: 'Telur gulung yang lembut dan sedap!',
      ),
      Review(
        reviewerName: 'John Lee',
        reviewerAvatar: 'assets/images/avatars/john.png',
        comment: 'Perfect for kids and adults alike.',
      ),
    ],
    description:
        'Sweet Japanese omelette rolled with sushi rice and nori. A favourite for all ages.',
    imagePath: 'assets/images/foods/maki_rolls/tamago_maki.png',
  ),
  MenuItem(
    name: 'KANI MENTAI',
    price: 'RM 6.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Sakura Ito',
        reviewerAvatar: 'assets/images/avatars/sakura.png',
        comment: 'Mentai sauce dia memang terbaik!',
      ),
      Review(
        reviewerName: 'Adam Tan',
        reviewerAvatar: 'assets/images/avatars/adam.png',
        comment: 'Kani mentai ni juicy dan creamy.',
      ),
    ],
    description:
        'Crab stick nigiri topped with creamy mentai sauce, lightly torched for extra flavor.',
    imagePath: 'assets/images/foods/nigiri/kani_mentai.png',
  ),
  MenuItem(
    name: 'TAMAGO MENTAI',
    price: 'RM 6.50',
    ratings: 4.3,
    reviews: [
      Review(
        reviewerName: 'Mira Zainal',
        reviewerAvatar: 'assets/images/avatars/mira.png',
        comment: 'Tamago lembut, mentai padu!',
      ),
      Review(
        reviewerName: 'Ben Chong',
        reviewerAvatar: 'assets/images/avatars/ben.png',
        comment: 'Sesuai untuk yang suka telur dan mentai.',
      ),
    ],
    description:
        'Sweet Japanese omelette nigiri with a generous topping of mentai sauce, lightly torched.',
    imagePath: 'assets/images/foods/nigiri/tamago_mentai.png',
  ),
  MenuItem(
    name: 'EBIKO',
    price: 'RM 7.90',
    ratings: 4.7,
    reviews: [
      Review(
        reviewerName: 'Fatin Noor',
        reviewerAvatar: 'assets/images/avatars/fatin.png',
        comment: 'Ebiko fresh, popping in your mouth!',
      ),
      Review(
        reviewerName: 'Ravi Kumar',
        reviewerAvatar: 'assets/images/avatars/ravi.png',
        comment: 'Suka tekstur dan rasa masin ebiko.',
      ),
    ],
    description:
        'Gunkan sushi topped with fresh, crunchy flying fish roe (ebiko).',
    imagePath: 'assets/images/foods/gunkan/ebiko.png',
  ),
  MenuItem(
    name: 'KANI MAYO',
    price: 'RM 6.90',
    ratings: 4.4,
    reviews: [
      Review(
        reviewerName: 'Syafiqah Lim',
        reviewerAvatar: 'assets/images/avatars/syafiqah.png',
        comment: 'Kani mayo creamy dan sedap!',
      ),
      Review(
        reviewerName: 'Zul Hadi',
        reviewerAvatar: 'assets/images/avatars/zul.png',
        comment: 'Portion banyak, puas hati.',
      ),
    ],
    description: 'Gunkan sushi with crab stick and creamy Japanese mayonnaise.',
    imagePath: 'assets/images/foods/gunkan/kani_mayo.png',
  ),
];
