import 'package:meta/meta.dart';

class SceneList {
  int currentScene;
  final List<SceneData> scenes;

  SceneList({
    this.currentScene = 0,
    @required this.scenes,
  });
}

class SceneData {
  final String title;
  final String imageUrl;
  final String translation;

  SceneData({
    this.title,
    this.imageUrl,
    this.translation,
  });
}

final russianSceneList = SceneList(
  currentScene: 0,
  scenes: <SceneData>[
    SceneData(
      title: 'Архангельск',
      translation: 'Arkhangelsk',
      imageUrl: 'assets/arkhangelsk_1.png',
    ),
    SceneData(
      title: 'Большой театр, Москва',
      translation: 'Bolshoi theatre, Moscow',
      imageUrl: 'assets/bolshoi_theatre_moscow.png',
    ),
    SceneData(
      title: 'Чесменская церковь, Санкт-Петербург',
      translation: 'Chesme church, St Petersburg',
      imageUrl: 'assets/chesme_church_st_petersburg.png',
    ),
    SceneData(
      title: 'церковь в Угличе',
      translation: 'Church in Uglich',
      imageUrl: 'assets/church_in_uglich.png',
    ),
    SceneData(
      title: 'церковь Спаса на крови',
      translation: 'Church of Saviour on Split Blood',
      imageUrl: 'assets/church_of_saviour_on_spilt_blood_1.png',
    ),
    SceneData(
      title: 'церковь Спаса на крови',
      translation: 'Church of Saviour on Split Blood',
      imageUrl: 'assets/church_of_saviour_on_spilt_blood_2.png',
    ),
    SceneData(
      title: 'памятник Гагарину, Москва',
      translation: 'Gagarin monument, Moscow',
      imageUrl: 'assets/gagarin_monument_moscow.png',
    ),
    SceneData(
      title: 'Комсомольская метро, Москва',
      translation: 'Komsomolskaya metro, Moscow',
      imageUrl: 'assets/komsomolskaya_moscow_metro.png',
    ),
    SceneData(
      title: 'Ладожское озеро',
      translation: 'Lake Ladoga',
      imageUrl: 'assets/lake_ladoga.png',
    ),
    SceneData(
      title: 'метро Маяковская, Москва',
      translation: 'Mayakovskaya metro, Moscow',
      imageUrl: 'assets/mayakovskaya_metro_moscow.png',
    ),
    SceneData(
      title: 'продуктовый магазин, Москва',
      translation: 'Moscow grocery store',
      imageUrl: 'assets/moscow_grocery_store.png',
    ),
    SceneData(
      title: 'Непорочное зачатие, Москва',
      translation: 'Church of Immaculate Conception, Moscow',
      imageUrl: 'assets/moscow_immaculate_conception.png',
    ),
    SceneData(
      title: 'Родина-мать зовет',
      translation: 'The Motherland Calls',
      imageUrl: 'assets/motherland_calls.png',
    ),
    SceneData(
      title: 'Родина-мать зовет, Мамаев курган',
      translation: 'The Motherland Calls, Mamayev Kurgan',
      imageUrl: 'assets/motherland_calls_mamayev_kurgan.png',
    ),
    SceneData(
      title: 'Останкинская башня, Москва',
      translation: 'Ostankino tower, Moscow',
      imageUrl: 'assets/ostankino_tower_moscow.png',
    ),
    SceneData(
      title: 'Петропавловская крепость, Санкт-Петербург',
      translation: 'Peter and Paul Fortress, St Petersburg',
      imageUrl: 'assets/peter_paul_fortress_spire.png',
    ),
    SceneData(
      title: 'Петропавловская крепость, Санкт-Петербург',
      translation: 'Peterhof palace, St Petersburg',
      imageUrl: 'assets/peterhof_palace.png',
    ),
    SceneData(
      title: 'Мечеть Кул Шариф, Казань Татарстан',
      translation: 'Qolsharif mosque, Kazan Tatarstan',
      imageUrl: 'assets/qolsharif_mosque_kazan_tatarstan.png',
    ),
    SceneData(
      title: 'Воскресенская церковь Кремль, Ростов Великий',
      translation: 'Resurrection church Kremlin, Rostov Veliky',
      imageUrl: 'assets/resurrection_church_kremlin_rostov_veliky.png',
    ),
    SceneData(
      title: 'Ростовский цитадель',
      translation: 'Rostov citadel',
      imageUrl: 'assets/rostov_citadel.jpg',
    ),
    SceneData(
      title: 'Алые паруса, Санкт-Петербург',
      translation: 'Scarlet sails, St Petersburg',
      imageUrl: 'assets/scarlet_sails_st_petersburg.png',
    ),
    SceneData(
      title: 'Памятник затонувшим кораблям, Севастополь',
      translation: 'Monument to sunken ships, Sevastopol',
      imageUrl: 'assets/sevastopol_memorial_1.jpg',
    ),
    SceneData(
      title: 'Памятник затонувшим кораблям, Севастополь',
      translation: 'Monument to sunken ships, Sevastopol',
      imageUrl: 'assets/sevastopol_memorial_2.jpg',
    ),
    SceneData(
      title: 'Зингер Билдинг, Санкт-Петербург',
      translation: 'Singer building, St Petersburg',
      imageUrl: 'assets/singer_building_home_of_books_spb_1.png',
    ),
    SceneData(
      title: 'Зингер Билдинг, Санкт-Петербург',
      translation: 'Singer building, St Petersburg',
      imageUrl: 'assets/singer_building_home_of_books_spb_2.png',
    ),
    SceneData(
      title: 'Смольный монастырь, Санкт-Петербург',
      translation: 'Smolny convent, St Petersburg',
      imageUrl: 'assets/smolny_convent_st_petersburg.png',
    ),
    SceneData(
      title: 'Храм Василия Блаженного, Москва',
      translation: "St. Basil's cathedral, Moscow",
      imageUrl: 'assets/st_basils_cathedral_1.jpg',
    ),
    SceneData(
      title: 'Храм Василия Блаженного, Москва',
      translation: "St. Basil's cathedral, Moscow",
      imageUrl: 'assets/st_basils_cathedral_2.jpg',
    ),
    SceneData(
      title: 'Памятник Георгию Победоносцу, Владикавказ, Северная Осетия',
      translation:
          'Monument to St. George (Nykhas Uastyrdzhi), Vladikavkaz North Ossetia',
      imageUrl: 'assets/st_george_nykhas_uastyrdzhi_ossetia.png',
    ),
    SceneData(
      title: 'Ангелы на крыше, Санкт-Петербург',
      translation: 'Rooftop Angels, St Petersburg',
      imageUrl: 'assets/st_petersburg_rooftop_angels.png',
    ),
    SceneData(
      title: 'Суздальская церковь',
      translation: 'Suzdal Church',
      imageUrl: 'assets/suzdal_church.png',
    ),
    SceneData(
      title: 'Высокое дерево',
      translation: 'Tall trees',
      imageUrl: 'assets/tall_trees.png',
    ),
    SceneData(
      title: 'Преображенская церковь, остров Кижи, Карелия',
      translation: 'Transfiguration church, Kizhi Island, Karelia',
      imageUrl: 'assets/transfiguration_church_kizhi_island_karelia.png',
    ),
    SceneData(
      title: 'Церковь Троицы, Беллинсгаузен, Антарктика',
      translation: 'Trinity church, Bellingshausen, Antartica',
      imageUrl: 'assets/trinity_church_bellingshausen_antarctica.png',
    ),
    SceneData(
      title: 'Валаамская Часовня',
      translation: 'Valaam Chapel',
      imageUrl: 'assets/valaam_chapel.png',
    ),
    SceneData(
      title: 'Значок Валаам',
      translation: 'Valaam Icon',
      imageUrl: 'assets/valaam_icon.png',
    ),
    SceneData(
      title: 'Валаамский монастырь',
      translation: 'Valaam Monastery',
      imageUrl: 'assets/valaam_monastery_1.png',
    ),
    SceneData(
      title: 'Валаамский монастырь',
      translation: 'Valaam Monastery',
      imageUrl: 'assets/valaam_monastery_2.png',
    ),
    SceneData(
      title: 'вокзал Владивостока',
      translation: 'Vladivostok Station',
      imageUrl: 'assets/vladivostok_trans_siberian_station.png',
    ),
  ],
);
