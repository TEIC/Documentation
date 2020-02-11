var slogans = {
  "en": [
    ["Increase the TEI-C Membership +1: Join Now!","plus"],
    ["Join the constellation of TEI Superstars: Become a Member Now!","star"],
    ["Keep the TEI working: Participate Today!","wrench"],
    ["Where in the World is TEI Happening? Mark Your Spot!","pindrop"],
    ["Open source, open access is not free: Support the TEI-C!","unlock"]
  ],
  "fr": [
    ["Ajoutez votre voix au concert de la TEI: devenez-en membre !","plus"],
    ["Rejoignez la constellation des étoiles de la TEI: souscrivez maintenant !","star"],
    ["Contribuez au travail de la TEI en devenant membre !","wrench"],
    ["Montrez que la TEI est présente chez vous aussi. Participez !","pindrop"],
    ["Aidez la TEI à rester libre et ouverte. Participez !","unlock"],
    ["Un membre de plus du consortium TEI : vous !","plus"],
    ["Pour que la TEI continue : participez maintenant !","wrench"]
  ],
  "ja": [
    ["TEI協会のメンバーが1人増えることがデジタル時代の人文学の将来につながります。ぜひご参加を！","plus"],
    ["TEIのスーパースター達の集まりに参加しましょう。ぜひメンバーに！","star"],
    ["デジタル時代の人文学のためにTEIに参加しましょう！","wrench"],
    ["TEIは世界のどこで活動しているでしょうか？あなたが参加すれば、そこもTEIの拠点になります！","pindrop"],
    ["オープンソース、オープンアクセス、オープンデータは無料では成り立ちません。TEI協会を支援しましょう！","unlock"]
  ],
  "es-US": [
    ["Aumenta los miembros del TEI-C +1: Únete ahora","plus"],
    ["Únete a la constelación de superestrellas: ¡Hazte miembro ahora!","star"],
    ["Mantengamos al TEI funcionando: ¡Participa hoy!","wrench"],
    ["¿Dónde en el mundo está TEI ocurriendo? ¡Marca tu lugar!","pindrop"],
    ["Código abierto y acceso abierto nunca son gratis. ¡Apoye al TEI-C!","unlock"]
  ],
  "es": [
    ["Haz crecer la comunidad TEI-C +1: apúntate ya","plus"],
    ["Únete a la constelación de superestrellas TEI: hazte miembro","star"],
    ["Mantén en marcha a TEI: participa hoy mismo","wrench"],
    ["¿En qué sitios del mundo está ocurriendo TEI? ¡Marca en dónde estás tú!","pindrop"],
    ["El código libre y el acceso abierto no son gratis. ¡Apoya al TEI-C!","unlock"]
  ],
  "pl": [
    ["Podbij statystyki TEI-C: dołącz już dziś!","plus"],
    ["Zostań nową gwiazdą w konstelacji TEI: dołącz już dziś!","star"],
    ["Niech TEI nie przestaje działać: dołącz i Ty.","wrench"],
    ["Gdzie na świecie używa się TEI? Zaznacz swoje miejsce!","pindrop"],
    ["Open source i open access nie są za darmo: wesprzyj TEI-C!","unlock"]
  ],
  "de": [
    ["Legen wir eins drauf: TEI-C Mitgliedschaft +1","plus"],
    ["Werde Teil der TEI Superstars: Jetzt Mitgliedschaft beantragen!","star"],
    ["Unterstütze die Arbeit der TEI: als Mitglied!","wrench"],
    ["Mache die TEI noch weltumspannender: Jetzt Mitgliedschaft beantragen!","pindrop"],
    ["Erhalten wir die freie Zugänglichkeit der TEI: Jetzt Mitgliedschaft beantragen!","unlock"]
    ["Wo in aller Welt wird die TEI angewendet? Zeige Deine Beteiligung!","pindrop"],
    ["Open Source und Open Access sind nicht umsonst: werde Mitglied der TEI!","unlock"]
  ],
  "ro": [
    ["Deveniți membri ai grupului TEI: aplicați acum!","plus"],
    ["Vrei să fii o stea TEI? Poți deveni membru astăzi!","star"],
    ["Contribuie şi tu la activitățile TEI: participă astăzi!","wrench"],
    ["Unde se desfăşoară activități TEI în lume? Inscrie-te pe hartă!","pindrop"],
    ["Sursele libere pe internet, open access, nu apar prin minune: contribuie la TEI-C!","unlock"]
  ],
  "ca": [
    ["Feu crèixer la comunitat TEI-C +1: apunteu-vos-hi ja","plus"],
    ["Uniu-vos a la constel·lacó de superestrelles TEI: feu-vos-en membre!","star"],
    ["Manteniu en marxa el TEI: participeu avui mateix!","wrench"],
    ["En quins llocs del món ocorre TEI? Marca on ets tu!","pindrop"],
    ["La font lliure, l'accés lliure, no són gratis. Doneu suport a TEI-C!","unlock"]
  ],
  "pt": [
    ["Faz crescer a comunicade TEI-C +1: Inscreve-te já!","plus"],
    ["Junta-te à constelação TEI Superstars: Torna-te membro agora!","star"],
    ["Mantém o TEI em marcha: Participa hoje!","wrench"],
    ["Onde está a funcionar o TEI no mundo? Marca o teu local!","pindrop"],
    ["O código livre e o acesso aberto não são gratuitos: Apoia o TEI-C!","unlock"]
  ]
};
var images = {
  "plus":"images/ic_person_add_black_24dp_2x.png",
  "pindrop":"images/ic_place_black_24dp_2x.png",
  "star":"images/ic_stars_black_24dp_2x.png",
  "unlock":"images/ic_lock_open_black_24dp_2x.png",
  "wrench":"images/ic_build_black_24dp_2x.png"
}

var language = window.navigator.language?window.navigator.language:"en-US";
language = language.substring(0,5);
if (!slogans[language]) {
  language = language.substring(0,2);
}
if (!slogans[language]) {
  language = "en";
}
var choice = Math.floor(Math.random() * slogans[language].length);
var slogan = slogans[language][choice];
var expires = 604800000;  // 1 week in milliseconds
var base = "http://www.tei-c.org/Vault/membership-campaign/js/";

var canShow = function() {
  var stopped = window.localStorage.getItem("Stop-TEICampaign"); //Stop-TEICampaign is set if they click the link.
  if (stopped) {
    return false;
  }
  var time = window.localStorage.getItem("Hide-TEICampaign");
  if (time) {
    time = Number.parseInt(time);
    if (expires > Date.now() - time) {
      return false;
    }
  }
  return true;
}

var showCampaign = function () {
  if (!canShow()) {
    return;
  }
  var banner = document.createElement("div");
  banner.setAttribute("id", "TEICampaign");
  banner.setAttribute("style", "font-size:1.8em; background:#CDEEFE; border-bottom:thin solid black; margin:0px; padding: 10px; text-align:center; width:100%");
  banner.innerHTML = "<style type=\"text/css\">\
    a#campaignlink {text-decoration:none; color: black;} \
    a#campaignlink:hover {text-decoration:underline;}\
    button.campaignclose {background-color:#CDEEFE; border: none; display:inline-block; \
      font-size:1.2em; float:right; margin-right:22px; margin-top: -6px}\
  img.campaignicon {width:22px}\
  </style>" +
    "<img class=\"campaignicon\" src=\"" + base + images[slogan[1]] 
    + "\"> <a id=\"campaignlink\" href=\"http://members.tei-c.org/Join\" onclick=\"return stopCampaign();\">" 
    + slogan[0] + "</a><button class=\"campaignclose\" type=\"button\" onclick=\"hideCampaign()\">×</button>";
  var parent = document.querySelector("#container");
  if (!parent) {
    parent = document.querySelector("body");
  }
  parent.insertAdjacentElement('afterBegin', banner);
};

var hideCampaign = function() {
  window.localStorage.setItem("Hide-TEICampaign", Date.now().toString());
  var banner = document.querySelector("#TEICampaign");
  banner.parentElement.removeChild(banner);
};

var stopCampaign = function() {
  window.localStorage.setItem("Stop-TEICampaign", true);
  return true;
};

(function(){
  document.addEventListener('DOMContentLoaded', showCampaign);
})();
