import '../models/menu_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const menuItems = [
  MenuItem(
    name: 'PARTY SET A (81 PCS)',
    price: 'RM 109.90',
    ratings: 5.0,
    reviews: [
      Review(
        reviewerName: 'Michael See',
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
        "Nigiri (35 pcs)\n• Inari x 5\n• Tamago x 5\n• Ika x 5\n• Ebi x 5\n• White Tuna x 5\n• Unagi x 5\n• Kani x 5\n\nGunkan (16 pcs)\n• Ebiko x 8\n• Salmon Mayo x 8\n\nMaki (30 pcs)\n• Kappa Maki x 10\n• Sake Maki x 10\n• Tamago Maki x 10",
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
        "Nigiri (30 pcs)\n• Inari x 4\n• Tamago x 4\n• Ika x 4\n• Ebi x 4\n• White Tuna x 4\n• Unagi x 5\n• Kani x 5\n\nGunkan (14 pcs)\n• Ebiko x 7\n• Salmon Mayo x 7\n\nMaki (30 pcs)\n• Kappa Maki x 10\n• Sake Maki x 10\n• Tamago Maki x 10",
    imagePath: 'assets/images/foods/party_set/party_set_b.png',
  ),
  MenuItem(
    name: 'PARTY SET C (65 PCS)',
    price: 'RM 89.90',
    ratings: 4.7,
    reviews: [
      Review(
        reviewerName: 'Sarah Tan',
        reviewerAvatar: 'assets/images/avatars/sarah.png',
        comment: 'Perfect for small gatherings!',
      ),
    ],
    description:
        "Nigiri (25 pcs)\n• Inari x 3\n• Tamago x 3\n• Ika x 3\n• Ebi x 3\n• White Tuna x 3\n• Unagi x 5\n• Kani x 5\n\nGunkan (10 pcs)\n• Ebiko x 5\n• Salmon Mayo x 5\n\nMaki (30 pcs)\n• Kappa Maki x 10\n• Sake Maki x 10\n• Tamago Maki x 10",
    imagePath: 'assets/images/foods/party_set/party_set_c.png',
  ),
  MenuItem(
    name: 'MAKI SET (30 PCS)',
    price: 'RM 49.90',
    ratings: 4.6,
    reviews: [
      Review(
        reviewerName: 'David Wong',
        reviewerAvatar: 'assets/images/avatars/david.png',
        comment: 'Great variety of maki rolls!',
      ),
    ],
    description:
        "Maki (30 pcs)\n• Kappa Maki x 10\n• Sake Maki x 10\n• Tamago Maki x 10",
    imagePath: 'assets/images/foods/party_set/maki_set.png',
  ),
  MenuItem(
    name: 'NIGIRI SET (25 PCS)',
    price: 'RM 59.90',
    ratings: 4.8,
    reviews: [
      Review(
        reviewerName: 'Lisa Chen',
        reviewerAvatar: 'assets/images/avatars/lisa.png',
        comment: 'Fresh and delicious nigiri selection!',
      ),
    ],
    description:
        "Nigiri (25 pcs)\n• Inari x 3\n• Tamago x 3\n• Ika x 3\n• Ebi x 3\n• White Tuna x 3\n• Unagi x 5\n• Kani x 5",
    imagePath: 'assets/images/foods/party_set/nigiri_set.png',
  ),
  MenuItem(
    name: 'GUNKAN SET (20 PCS)',
    price: 'RM 45.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Kevin Lim',
        reviewerAvatar: 'assets/images/avatars/kevin.png',
        comment: 'Love the variety of gunkan!',
      ),
    ],
    description: "Gunkan (20 pcs)\n• Ebiko x 10\n• Salmon Mayo x 10",
    imagePath: 'assets/images/foods/party_set/gunkan_set.png',
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
    name: 'CHUKA WAKAME',
    price: 'RM 6.90',
    ratings: 4.6,
    reviews: [
      Review(
        reviewerName: 'Noraini Hashim',
        reviewerAvatar: 'assets/images/avatars/aina.png',
        comment: 'Seaweed is fresh and tasty, perfect appetizer!',
      ),
    ],
    description:
        'Seasoned seaweed salad with sesame seeds and a hint of chili.',
    imagePath: 'assets/images/foods/appetizers/chuka_wakame.png',
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
  MenuItem(
    name: 'CHICKEN KATSU CURRY DON',
    price: 'RM 18.90',
    ratings: 4.7,
    reviews: [
      Review(
        reviewerName: 'Tommy Lee',
        reviewerAvatar: 'assets/images/avatars/tommy.png',
        comment: 'Crispy chicken with rich curry!',
      ),
    ],
    description:
        'Crispy chicken katsu served with Japanese curry sauce over rice.',
    imagePath: 'assets/images/foods/curry_sets/chicken_katsu_curry_don.png',
  ),
  MenuItem(
    name: 'EBI CURRY DON',
    price: 'RM 19.90',
    ratings: 4.6,
    reviews: [
      Review(
        reviewerName: 'Nina Tan',
        reviewerAvatar: 'assets/images/avatars/nina.png',
        comment: 'Prawns are perfectly cooked!',
      ),
    ],
    description: 'Fresh prawns served with Japanese curry sauce over rice.',
    imagePath: 'assets/images/foods/curry_sets/ebi_curry_don.png',
  ),
  MenuItem(
    name: 'CHICKEN KATSU CURRY UDON',
    price: 'RM 19.90',
    ratings: 4.8,
    reviews: [
      Review(
        reviewerName: 'Peter Chen',
        reviewerAvatar: 'assets/images/avatars/peter.png',
        comment: 'Perfect comfort food!',
      ),
    ],
    description:
        'Crispy chicken katsu served with Japanese curry sauce over udon noodles.',
    imagePath: 'assets/images/foods/curry_sets/chicken_katsu_curry_udon.png',
  ),
  MenuItem(
    name: 'EBI CURRY UDON',
    price: 'RM 20.90',
    ratings: 4.7,
    reviews: [
      Review(
        reviewerName: 'Linda Wong',
        reviewerAvatar: 'assets/images/avatars/linda.png',
        comment: 'Rich curry with fresh prawns!',
      ),
    ],
    description:
        'Fresh prawns served with Japanese curry sauce over udon noodles.',
    imagePath: 'assets/images/foods/curry_sets/ebi_curry_udon.png',
  ),

  MenuItem(
    name: 'KAPPA MAKI',
    price: 'RM 4.90',
    ratings: 4.3,
    reviews: [
      Review(
        reviewerName: 'Ahmad Zain',
        reviewerAvatar: 'assets/images/avatars/ahmad.png',
        comment: 'Fresh cucumber roll!',
      ),
    ],
    description: 'Classic cucumber maki roll with seasoned rice and nori.',
    imagePath: 'assets/images/foods/maki_rolls/kappa_maki.png',
  ),
  MenuItem(
    name: 'KANI MAKI',
    price: 'RM 5.90',
    ratings: 4.4,
    reviews: [
      Review(
        reviewerName: 'Mei Ling',
        reviewerAvatar: 'assets/images/avatars/mei.png',
        comment: 'Crab stick roll is my favorite!',
      ),
    ],
    description: 'Crab stick maki roll with seasoned rice and nori.',
    imagePath: 'assets/images/foods/maki_rolls/kani_maki.png',
  ),
  MenuItem(
    name: 'EBI NIGIRI',
    price: 'RM 6.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Raj Kumar',
        reviewerAvatar: 'assets/images/avatars/raj.png',
        comment: 'Fresh prawn nigiri!',
      ),
    ],
    description: 'Fresh prawn nigiri with seasoned rice.',
    imagePath: 'assets/images/foods/nigiri/ebi_nigiri.png',
  ),
  MenuItem(
    name: 'IKA NIGIRI',
    price: 'RM 6.90',
    ratings: 4.4,
    reviews: [
      Review(
        reviewerName: 'Yuki Tanaka',
        reviewerAvatar: 'assets/images/avatars/yuki.png',
        comment: 'Squid nigiri is delicious!',
      ),
    ],
    description: 'Fresh squid nigiri with seasoned rice.',
    imagePath: 'assets/images/foods/nigiri/ika_nigiri.png',
  ),
  MenuItem(
    name: 'SAKE NIGIRI',
    price: 'RM 7.90',
    ratings: 4.7,
    reviews: [
      Review(
        reviewerName: 'Hana Kim',
        reviewerAvatar: 'assets/images/avatars/hana.png',
        comment: 'Fresh salmon nigiri!',
      ),
    ],
    description: 'Fresh salmon nigiri with seasoned rice.',
    imagePath: 'assets/images/foods/nigiri/sake_nigiri.png',
  ),
  MenuItem(
    name: 'TAKO NIGIRI',
    price: 'RM 6.90',
    ratings: 4.3,
    reviews: [
      Review(
        reviewerName: 'Kenji Sato',
        reviewerAvatar: 'assets/images/avatars/kenji.png',
        comment: 'Octopus nigiri is great!',
      ),
    ],
    description: 'Fresh octopus nigiri with seasoned rice.',
    imagePath: 'assets/images/foods/nigiri/tako_nigiri.png',
  ),
  MenuItem(
    name: 'UNAGI NIGIRI',
    price: 'RM 7.90',
    ratings: 4.8,
    reviews: [
      Review(
        reviewerName: 'Ming Wei',
        reviewerAvatar: 'assets/images/avatars/ming.png',
        comment: 'Grilled eel nigiri is amazing!',
      ),
    ],
    description: 'Grilled eel nigiri with seasoned rice.',
    imagePath: 'assets/images/foods/nigiri/unagi_nigiri.png',
  ),
  MenuItem(
    name: 'LOBSTER SALAD GUNKAN',
    price: 'RM 8.90',
    ratings: 4.6,
    reviews: [
      Review(
        reviewerName: 'Sophie Lee',
        reviewerAvatar: 'assets/images/avatars/sophie.png',
        comment: 'Luxurious lobster gunkan!',
      ),
    ],
    description: 'Gunkan sushi with lobster salad and tobiko.',
    imagePath: 'assets/images/foods/gunkan/lobster_salad_gunkan.png',
  ),
  MenuItem(
    name: 'SOY SAUCE',
    price: 'RM 0.20',
    ratings: 5.0,
    reviews: [],
    description: 'Traditional Japanese soy sauce.',
    imagePath: 'assets/images/foods/condiments/soy_sauce.png',
  ),
  MenuItem(
    name: 'WASABI',
    price: 'RM 0.40',
    ratings: 5.0,
    reviews: [],
    description: 'Japanese horseradish paste.',
    imagePath: 'assets/images/foods/condiments/wasabi.png',
  ),
  MenuItem(
    name: 'GINGER',
    price: 'RM 1.00',
    ratings: 5.0,
    reviews: [],
    description: 'Pickled ginger (gari).',
    imagePath: 'assets/images/foods/condiments/ginger.png',
  ),
  MenuItem(
    name: 'COKE',
    price: 'RM 3.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Alex Tan',
        reviewerAvatar: 'assets/images/avatars/alex.png',
        comment: 'Refreshing!',
      ),
    ],
    description: 'Coca-Cola soft drink.',
    imagePath: 'assets/images/foods/drinks/coke.png',
  ),
  MenuItem(
    name: 'SPRITE',
    price: 'RM 3.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Jenny Wong',
        reviewerAvatar: 'assets/images/avatars/jenny.png',
        comment: 'Perfect with sushi!',
      ),
    ],
    description: 'Sprite soft drink.',
    imagePath: 'assets/images/foods/drinks/sprite.png',
  ),
  MenuItem(
    name: '100PLUS',
    price: 'RM 3.90',
    ratings: 4.5,
    reviews: [
      Review(
        reviewerName: 'Mike Chan',
        reviewerAvatar: 'assets/images/avatars/mike.png',
        comment: 'Great isotonic drink!',
      ),
    ],
    description: '100PLUS isotonic drink.',
    imagePath: 'assets/images/foods/drinks/100plus.png',
  ),
  MenuItem(
    name: 'OYOSHI GREEN TEA',
    price: 'RM 4.90',
    ratings: 4.6,
    reviews: [
      Review(
        reviewerName: 'Aisyah Lee',
        reviewerAvatar: 'assets/images/avatars/aisyah.png',
        comment: 'Sangat sedap dan segar!',
      ),
    ],
    description: 'Premium Japanese green tea.',
    imagePath: 'assets/images/foods/drinks/oyoshi_green_tea.png',
  ),
];

Future<void> migrateMenuToFirestore() async {
  final menuCollection = FirebaseFirestore.instance.collection('menuItems');
  for (final item in menuItems) {
    await menuCollection.add(item.toJson());
  }
  print('Migration complete!');
}
