/************************************ 
 * TEST LOLO IB Test *
 ************************************/

import { core, data, sound, util, visual } from './lib/psychojs-2022.1.3.js';
const { PsychoJS } = core;
const { TrialHandler, MultiStairHandler } = data;
const { Scheduler } = util;
//some handy aliases as in the psychopy scripts;
const { abs, sin, cos, PI: pi, sqrt } = Math;
const { round } = util;

// Start code blocks for 'Before Experiment'
// init psychoJS:
const psychoJS = new PsychoJS({
  debug: true
});


// open window:
psychoJS.openWindow({
  fullscr: true,
  color: new util.Color([0, 0, 0]),
  units: 'pix',
  waitBlanking: true
});

let expName = 'AI';  // from the Builder filename that created this script
let expInfo = {'participant': '','age':'','sexe':'', 'session': '001'};

// schedule the experiment:
psychoJS.schedule(psychoJS.gui.DlgFromDict({
  dictionary: expInfo,
  title: expName
}));

const flowScheduler = new Scheduler(psychoJS);
const dialogCancelScheduler = new Scheduler(psychoJS);
psychoJS.scheduleCondition(function() { return (psychoJS.gui.dialogComponent.button === 'OK'); }, flowScheduler, dialogCancelScheduler);

// flowScheduler gets run if the participants presses OK
flowScheduler.add(updateInfo); // add timeStamp
flowScheduler.add(experimentInit);
flowScheduler.add(ConsigneRoutineBegin());
flowScheduler.add(ConsigneRoutineEachFrame());
flowScheduler.add(ConsigneRoutineEnd());
const trialsloopRiskScheduler=  new Scheduler(psychoJS);
flowScheduler.add(trialsloopRiskBegin(trialsloopRiskScheduler));
flowScheduler.add(trialsloopRiskScheduler);
flowScheduler.add(trialsloopRiskEnd);
const trialsloopMainScheduler=  new Scheduler(psychoJS);
flowScheduler.add(trialsloopMainBegin(trialsloopMainScheduler));
flowScheduler.add(trialsloopMainScheduler);
flowScheduler.add(trialsloopMainEnd);
flowScheduler.add(fintrialTextBegin());
flowScheduler.add(fintrialTextEachFrame());
flowScheduler.add(fintrialTextEachEnd());
flowScheduler.add(quitPsychoJS, '', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, '', false);

psychoJS.start({
  expName: expName,
  expInfo: expInfo,
  resources: [{'name':'condition_files27_03_ok.xlsx','path':'condition_files27_03_ok.xlsx'},{'name': 'img/voiture.png', 'path': 'img/voiture.png'},{'name': 'img/warning_ok_nowarn.png', 'path': 'img/warning_ok_nowarn.png'},{'name': 'img/cross_ok.png', 'path': 'img/cross_ok.png'},{'name': 'img/correct_ok.png', 'path':'img/correct_ok.png'},{'name': 'img/dolard.png', 'path': 'img/dolard.png'},{'name': 'img/heart.png', 'path': 'img/heart.png'},{'name': 'img/arrow_left.png', 'path': 'img/arrow_left.png'},{'name': 'img/arrow_right.png', 'path': 'img/arrow_right.png'},{'name': 'img/arrow_up.png', 'path': 'img/arrow_up.png'},{'name': 'img/arrow_down.png', 'path': 'img/arrow_down.png'},{'name': 'Sound/neutre.wav', 'path': 'Sound/neutre.wav'},{'name': 'Sound/ding.wav', 'path': 'Sound/ding.wav'},{'name': 'Sound/buzz.wav', 'path': 'Sound/buzz.wav'}]});

psychoJS.experimentLogger.setLevel(core.Logger.ServerLevel.DEBUG);

var currentLoop;
var frameDur;
async function updateInfo() {
  currentLoop = psychoJS.experiment; 
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '2022.1.3';
  expInfo['OS'] = window.navigator.platform;
  
  psychoJS.experiment.dataFileName = (("." + "/") + `data/${expInfo["participant"]}_${expName}_${expInfo["date"]}`);


  // store frame rate of monitor if we can measure it successfully
  expInfo['frameRate'] = psychoJS.window.getActualFrameRate();
  //console.log('frameRate',expInfo['frameRate']);
  if (typeof expInfo['frameRate'] !== 'undefined')
    frameDur = 1.0 / Math.round(expInfo['frameRate']);
  else
    frameDur = 1.0 / 60.0; // couldn't get a reliable measure so guess

  // add info from the URL:
  util.addInfoFromUrl(expInfo);
  
  return Scheduler.Event.NEXT;
}



var globalClock_AI;
var routineTimer;
var winSize;
var Consigne_AI_Clock;
var text_AI_instruc1;
var text_AI_instruc2;
var text_AI_instruc3;
var text_AI_instruc4;
var text_AI_instruc5;
var text_AI_instruc6;
var text_AI_instruc7;
var text_AI_instruc8;
var text_AI_instruc9;
var key_resp1_AI;
var key_resp2_AI;
var key_resp3_AI;
var key_resp4_AI;
var key_resp5_AI;
var key_resp6_AI;
var key_resp7_AI;
var key_resp8_AI;
var key_resp9_AI;
var txt_fin_AI;
var clock_fin_AI;
var fin_kp_AI;
var clock_Error_EstimRisk;
var nRepEstimRisk;
var globalClock_AI;
var userchoiceClock_AI;
var nRepsUserchoice;
var routineTimer;
var LeftUpCorner;
var RightUpCorner;
var LeftDownCorner;
var RightDownCorner;
var mapConfigs;
var lEndpoint_AI;
var rEndPoint_AI;
var line_AI;
var estimRisk;
var txt_estimrisk;
var feedback_estim_risk;
var key_estimrisk;
var key_estimrisk_validation;
var key_feedback_estim_risk;
var key_estimrisk_erreurvalid;
var texte_erreur;
var clock_break;
var txt_break_1;
var txt_break_2;
var txt_timer_break;
var txt_timer_ENDbreak;
var key_timer_ENDbreak;
var text_1_pos_AI;
var text_2_pos_AI;
var text_3_pos_AI;
var text_4_pos_AI;
var CentrePos_AI;
var txt_1_AI;
var txt_2_AI;
var txt_3_AI;
var txt_4_AI;
var txt_choice_AI;
var txt_optionstrategie_AI;
var txt_GO;
var text_go_pos;
var no_userchoicetxt_AI;
var no_userchoicekp_AI;
var k_presdis_AI;
var userChoiceAI;
var my_car;
var preshotText;
var preShotKB;
var money_1;
var money_2;
var heart_1;
var heart_2;
var money_3_X;
var heart_3_X;
var money_3_Y;
var heart_3_Y;
var redLight;
var left;
var right;
var up;
var down;
var arrow;
var obstaclePositionX;
var obstaclePositionY;
var feedbackobstacleDuration;
var correct;
var incorrect;
var key_list;
var key_name;
var keypressobstacle;
var stimulus;
var carMovementClock;
var tolerance;
var LEFT, RIGHT, UP, DOWN;
var txt_display;
var txt_c2_X;
var txt_c3_X;
var txt_c2_Y;
var txt_c3_Y;
var error_kp_txt;
//var x_keyPress;

//var y_keyPress;
var arrival_keypress;
var NospacekpComponentsClock;
var text_NospacekpComponents;
var key_NospacekpComponents;
var keypreShot;
var sound_neutral;
var sound_bad;
var sound_good;
var SonClock;
var Estimation_tempsClock;
var estimation_key_resp;
var estimation_txt;
var score_trial_AI;
var Feedback_tempsClock;
var feedback_text;
var feedback_kp;
var SoAClock;
var SoA_key_resp;
var SoA_txt;
var SoA_validation_key;
var nbOfTrialAI;


async function experimentInit() {

  winSize=[psychoJS.window.size[1],psychoJS.window.size[1]];

  LeftUpCorner=[-winSize[0] / 2.5, winSize[1] / 2.5];
  LeftDownCorner=[-winSize[0] / 2.5, -winSize[1] / 2.5];
  RightUpCorner=[winSize[0] / 2.5, winSize[1] / 2.5];
  RightDownCorner=[winSize[0] / 2.5, -winSize[1] / 2.5];

  // Initialize components for Routine "Consigne"
  Consigne_AI_Clock = new util.Clock();
  text_AI_instruc1 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc1',
    text:'Vous entrez maintenant dans le BLOC EXPÉRIMENTAL.\n\n Appuyez sur la touche entrée pour continuer avec les instructions',
    font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc2 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc2',
    text:'Tout au long de ce bloc vous interagirez avec une intelligence artificielle(IA) qui aura pour rôle d\'effectuer les déplacements de la voiture et ainsi de la conduire à votre place jusqu’à la cible.\n\n Cette IA a la capacité de calculer et déterminer une trajectoire optimale qui équilibre.\n\n1) votre sécurité. \n\n 2) l\'optimisation de vos gains (c\'est-à-dire en donnant la priorité aux récompenses élevées si possible). \n\n3) votre temps de conduite.\n\n Pour déterminer la trajectoire à prendre l\'IA prendra en compte dans son calcul ces 3 aspects et ce avant chacun des essais.\n\n Appuyez sur la touche entrée pour continuer ',
    font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc3 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc3',text:'Ainsi, vos actions se limiteront donc à :\n\n1) Fournir votre objectif/cible initial que vous souhaitez atteindre dans 50% des essais.\nIMPORTANT:Souvent le choix de l\'IA ne correspondra pas avec le vôtre.\n\n 2) Surveiller la conduite autonome du véhicule, assurée par l\'IA,et donc d\'éviter les obstacles. \n\n 3) Appuyer sur espace lorsque la voiture arrive sur la cible pour valider votre action conjointe effectuée avec l\'IA. \n\n 4) Estimer le temps écoulé entre votre action et le son entendu ainsi que votre sentiment de contrôle sur la conduite.\n\n Appuyez sur la touche entrée pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc4 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc4',text:'Les mêmes stratégies (SÛRE & RAPIDE) et cibles ( 2 RAPIDE/dollars et 2 SÛRE/coeurs ) que celles du BLOC D\'ENTRAÎNEMENT N°2 vous seront proposées.\n\n Pour rappel la stratégie SÛRE/COEUR vous exposera à un risque faible de rencontrer un obstacle au cours d\'1 des 2 déplacements de la voiture et vous permettra de remporter 2.5 point en cas de succès de l\'essai. \n\nLa stratégie RAPIDE/DOLLAR vous exposera à un risque élevé de rencontrer un obstacle au cours d\'1 des 2  déplacements de la voiture et vous permettra de remporter 4 points en cas de succès de l\'essai. \n\n Appuyez sur la touche entrée pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc5 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc5',text:'Pour ce qui est de l \'obstacle les instructions qui vous ont été données au cours du BLOC D\'ENTRAÎNEMENT N°2 sont les mêmes. \n\n Appuyez sur la touche entrée pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc6 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc6',text:'Concernant le succès de l\'essai, il sera possible UNIQUEMENT si vous appuyez à temps sur la touche espace lorsque la voiture sera arrivée sur la cible comme au cours du BLOC D\'ENTRAÎNEMENT N°2.\n\n Si l\'essai est réussi, comme lors des BLOCS D\'ENTRAÎNEMENTS N°1 et N°2 vous entendrez un son avec un délai compris entre 1 et 1500 ms. \n\n Vous devrez alors estimer ce délai temporel c\'est à dire le temps écoulé entre votre action (pression sur la touche espace)et le son entendu. \n\nAttention vous serez aussi limités dans le temps pour entrer votre estimation (indiqué par une ligne blanche).\n\n IMPORTANT : Votre performance à l\'estimation de ce délai est essentiel pour que vous puissiez remporter le gain supplémentaire.\n\n Appuyez sur la touche entrée pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc7 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc7',text:' Puis une seconde estimation vous sera demandée, celle concernant votre sentiment de contrôle en répondant à la question suivante: \n\n Dans quelle mesure vous êtes-vous senti au contrôle de l’essai ? \n\nCette estimation se fera suivant une échelle de valeur allant de 1 à 10.\n\n 1: Je ne me suis pas du tout senti au contrôle de l\'essai.\n\n 10: Je me suis complètement senti au contrôle de l\'essai. \n\n Appuyez sur la touche entrée pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc8 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc8',text:' À la fin de cette estimation votre score s\'affichera indiquant la fin de l\'essai.\n\n Vous pourrez alors appuyer sur la touche entrée pour passer à l\’essai suivant.\n\n Appuyez sur la touche entrée pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  text_AI_instruc9 = new visual.TextStim({ win : psychoJS.window, name:'text_AI_instruc9',text:'IMPORTANT : Au cours de certains essais, l\'intelligence artificielle avec laquelle vous interagirez vous donnera des informations/explications sur son intention avant de la réaliser.\n\n Soyez bien attentif à ses informations car elles vous permettront de plus facilement remporter l\'essai en cours et donc de gagner des points, dans le cas où vos choix différeraient de ceux fait par l\'intelligence artificielle \n\n Vous êtes prêt? Si oui appuyez sur la touche entrée pour commencer le BLOC EXPÉRIMENTAL',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  
  key_resp1_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true}); 
  key_resp2_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp3_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp4_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp5_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp6_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp7_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp8_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  key_resp9_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});

  // estimation risque 
  clock_break=new util.Clock();
  
  txt_break_1= new visual.TextStim({ win : psychoJS.window, name:'txt_break_1',text:'Il est temps de prendre 1 minute de pause',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_break_2= new visual.TextStim({ win : psychoJS.window, name:'txt_break_2',text:'Vous entrez maintenant dans la 2ième partie de l\'expérience au cours de laquelle il vous sera demandé d\'entrer votre choix de cible " "\n\n Il est ainsi temps de nouveau une pause d\'1 minute',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_timer_break=new visual.TextStim({ win : psychoJS.window, name:'txt_timer_break',text:'',font:'Open Sans',units: undefined,pos:LeftUpCorner, height:70,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_timer_ENDbreak=new visual.TextStim({ win : psychoJS.window, name:'txt_timer_ENDbreak',text:'C\'est la fin de la pause ! Appuyez sur entrée pour reprendre l\'expérience',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  key_timer_ENDbreak=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true}); 

  clock_Error_EstimRisk=new util.Clock();
  nRepEstimRisk=1;
  txt_estimrisk = new visual.TextStim({ win : psychoJS.window, name:'txt_estimrisk',text:'Veuillez entrer à l\'aide du clavier le niveau de risque ,de rencontrer un obstacle au cours de chaque essai, que vous êtes prêt à prendre pour le bloc expérimental(en %).\n\n La valeur de ce pourcentage doit être comprise entre 15 et 50%. \n\n REMARQUE :\n 15% équivaut à un risque faible de rencontrer un obstacle au cours de chaque essai.\n 50% équivaut à un risque élevé de rencontrer un obstacle au cours de chaque essai.\n\n Appuyez sur la touche entrée quand vous avez entré votre valeur choisi pour continuer',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  feedback_estim_risk=new visual.TextStim({win : psychoJS.window,name:'feedback_estim_risk',text:'',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  texte_erreur = new visual.TextStim({ win : psychoJS.window, name:'texte_erreur',text:'Vous n\'avez pas entré le niveau de risque demandé.\n\n Veuillez appuyer sur la touche entrée afin de pouvoir de nouveau entrer cette valeur',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  estimRisk=0;
  
  key_estimrisk=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true}); 
  key_estimrisk_validation=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true}); 
  key_feedback_estim_risk=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true}); 
  key_estimrisk_erreurvalid=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true}); 
  
  // Affichage fin de l'entrainement
  clock_fin_AI=new util.Clock();
  txt_fin_AI=new visual.TextStim({ win : psychoJS.window, name:'txt_fin_AI', text:'C\'est la fin du BLOC EXPÉRIMENTAL ! \n\n Appuyez sur la touche entrée pour quitter', font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  fin_kp_AI = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  globalClock_AI = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer(); 
  ///// User target choice////

  /// MAP CHOICE ET AFFICHAGE//

  

  mapConfigs = {
    1: [LeftUpCorner, RightUpCorner, RightDownCorner, LeftDownCorner],
    2: [RightUpCorner, LeftUpCorner, LeftDownCorner, RightDownCorner],
    3: [LeftUpCorner, RightUpCorner, LeftDownCorner, RightDownCorner],
    4: [RightUpCorner, LeftUpCorner, RightDownCorner, LeftDownCorner],
    5: [LeftUpCorner, LeftDownCorner, RightUpCorner, RightDownCorner],
    6: [LeftDownCorner, LeftUpCorner, RightDownCorner, RightUpCorner]};
  // Countdown timer for choice
  
  
  userchoiceClock_AI=  new util.Clock();
  nRepsUserchoice=0;
  lEndpoint_AI= -winSize[0] / 5;
  rEndPoint_AI= winSize[0] / 5;
  //[lEndpoint_AI, (winSize[0] / 2) * 0.3], [rEndPoint_AI,(winSize[0] / 4)]
  line_AI = new visual.ShapeStim ({ win: psychoJS.window, name: 'polygon', vertices: [[lEndpoint_AI, (winSize[0] / 2) * 0.3], [rEndPoint_AI,(winSize[0] / 4)]], ori: 0.0, pos: [0, 0], lineWidth: 1.0, colorSpace: 'rgb', lineColor: new util.Color('white'), fillColor: new util.Color('white'), opacity: undefined, depth: -2, interpolate: true});
  // Initialize compo for routine feedback 
  text_1_pos_AI = [-winSize[0] / 2.5, winSize[1] / 3];
  text_2_pos_AI = [winSize[0] / 2.5, winSize[1] / 3];
  text_3_pos_AI = [-winSize[0] / 2.5, -winSize[1] / 3];
  text_4_pos_AI = [winSize[0] / 2.5, -winSize[1] / 3];

  CentrePos_AI = [0, 0];
  text_go_pos = [0, winSize[1] / 4.5];
  obstaclePositionX= {1: [-winSize[0] /4, 0],2: [winSize[0] / 4, 0],3: [-winSize[0] /4, 0],4: [winSize[0] / 4, 0]};
  obstaclePositionY={1: [-winSize[0] / 2.5, winSize[1] /4],2: [winSize[0] / 2.5, winSize[1] /4],3: [-winSize[0] / 2.5, -winSize[1] / 4],4: [winSize[0] / 2.5, -winSize[1] /4]};

  txt_1_AI=new visual.TextStim({ win : psychoJS.window, name:'txt_1_AI',text:'1',font:'Open Sans',units: undefined,pos:text_1_pos_AI, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_2_AI=new visual.TextStim({ win : psychoJS.window, name:'txt_2_AI',text:'2',font:'Open Sans',units: undefined,pos:text_2_pos_AI, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_3_AI=new visual.TextStim({ win : psychoJS.window, name:'txt_3_AI',text:'3',font:'Open Sans',units: undefined,pos:text_3_pos_AI, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_4_AI=new visual.TextStim({ win : psychoJS.window, name:'txt_4_AI',text:'4',font:'Open Sans',units: undefined,pos:text_4_pos_AI, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_choice_AI = [txt_1_AI, txt_2_AI, txt_3_AI, txt_4_AI];
  txt_optionstrategie_AI=new visual.TextStim({ win : psychoJS.window, name:'txt_optionstrategie_AI',text:'Veuillez choisir la cible que vous souhaitez atteindre en appuyant sur :\n\n[1] pour l\'option 1 \n\n  [2] pour l\'option 2 \n\n [3] pour l\'option 3 \n\n[4] pour l\'option 4',font:'Open Sans',units: undefined,pos:CentrePos_AI, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  no_userchoicetxt_AI=new visual.TextStim({ win : psychoJS.window, name:'no_userchoicetxt_AI',text:'Vous n\'avez pas entré un choix de cible valide appuyer pour entrée pour recommencer',font:'Open Sans',units: undefined,pos:[0, winSize[1] / 4.5], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_GO= new visual.TextStim({ win : psychoJS.window, name:'txt_GO',text:'GO ! ',font:'Open Sans',units: undefined,pos:text_go_pos, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  no_userchoicekp_AI=new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  k_presdis_AI = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  userChoiceAI=0;
  my_car = new visual.ImageStim({win : psychoJS.window,name : 'my_car', units : undefined, image : 'img/voiture.png', mask : undefined,ori : 0.0, pos : CentrePos_AI, size : [winSize[0] / 22.2, winSize[1] / 22.2],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  money_1 = new visual.ImageStim({win : psychoJS.window,name : 'money_1', units : undefined, image : 'img/dolard.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  money_2 = new visual.ImageStim({win : psychoJS.window,name : 'money_2', units : undefined, image : 'img/dolard.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  heart_1 = new visual.ImageStim({win : psychoJS.window,name : 'heart_1', units : undefined, image : 'img/heart.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  heart_2 = new visual.ImageStim({win : psychoJS.window,name : 'heart_2', units : undefined, image : 'img/heart.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  stimulus = [money_1, money_2, heart_1, heart_2];  

  money_3_X = new visual.ImageStim({win : psychoJS.window,name : 'money_3_X', units : undefined, image : 'img/dolard.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  heart_3_X = new visual.ImageStim({win : psychoJS.window,name : 'heart_3_X', units : undefined, image : 'img/heart.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});

  money_3_Y = new visual.ImageStim({win : psychoJS.window,name : 'money_3_Y', units : undefined, image : 'img/dolard.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  heart_3_Y = new visual.ImageStim({win : psychoJS.window,name : 'heart_3_Y', units : undefined, image : 'img/heart.png', mask : undefined,ori : 0.0, size : [winSize[0] /20, winSize[1] / 20],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  stimulus = [money_1, money_2, heart_1, heart_2];  
  redLight = new visual.ImageStim({win : psychoJS.window,name : 'redLight', units : undefined, image : 'img/warning_ok_nowarn.png', mask : undefined,ori : 0.0, size : [winSize[0] / 12, winSize[1] / 12],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  correct = new visual.ImageStim({win : psychoJS.window,name : 'correct', units : undefined, image : 'img/correct_ok.png', mask : undefined,ori : 0.0, size : [winSize[0] / 8, winSize[1] / 8],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  incorrect = new visual.ImageStim({win : psychoJS.window,name : 'incorrect', units : undefined, image : 'img/cross_ok.png', mask : undefined,ori : 0.0, size : [winSize[0] / 8, winSize[1] / 8],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});

  left = new visual.ImageStim({win : psychoJS.window,name : 'left', units : undefined, image : 'img/arrow_left.png', mask : undefined,ori : 0.0, size : [winSize[0] / 11.1, winSize[1] / 11.1],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  right = new visual.ImageStim({win : psychoJS.window,name : 'right', units : undefined, image : 'img/arrow_right.png', mask : undefined,ori : 0.0, size : [winSize[0] / 11.1, winSize[1] / 11.1],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  up = new visual.ImageStim({win : psychoJS.window,name : 'up', units : undefined, image : 'img/arrow_up.png', mask : undefined,ori : 0.0, size : [winSize[0] / 11.1, winSize[1] / 11.1],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  down = new visual.ImageStim({win : psychoJS.window,name : 'down', units : undefined, image : 'img/arrow_down.png', mask : undefined,ori : 0.0, size : [winSize[0] / 11.1, winSize[1] / 11.1],color : new util.Color([-1, -1, -1]), opacity : undefined,flipHoriz : false, flipVert : false,interpolate : true, depth : 0.0});
  arrow=[down, up, right, left];
  txt_display=new visual.TextStim({win : psychoJS.window, name:'txt_display',text: "+ SÛR",font:'Open Sans',units: undefined,pos:undefined, height:15,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_c2_X= new visual.TextStim({win : psychoJS.window, name:'txt_c2_X',text: "+ SÛR",font:'Open Sans',units: undefined,pos:undefined, height:15,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_c3_X= new visual.TextStim({win : psychoJS.window, name:'txt_c3_X',text: "+ SÛR",font:'Open Sans',units: undefined,pos:undefined, height:15,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_c2_Y= new visual.TextStim({win : psychoJS.window, name:'txt_c2_Y',text: "+ SÛR",font:'Open Sans',units: undefined,pos:undefined, height:15,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  txt_c3_Y= new visual.TextStim({win : psychoJS.window, name:'txt_c3_Y',text: "+ SÛR",font:'Open Sans',units: undefined,pos:undefined, height:15,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});



/// DATA TRIAL strategie etc 
  
  carMovementClock= new util.Clock();
  LEFT = - winSize[0] / 2.5;
  RIGHT = winSize[0] / 2.5;
  UP = winSize[1] / 2.5;
  DOWN = - winSize[1] / 2.5;
  tolerance = 0.00001;
  
  preShotKB= new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  keypressobstacle = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  //x_keyPress = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  preshotText = new visual.TextStim({win : psychoJS.window, name:'preshotText',text: "Vous avez appuyer sur la touche espace alors que cela n'\était pas nécessaire.\n\n Appuyez sur la touche entrée pour pouvoir commencer un nouvel essai",font:'Open Sans',units: undefined,pos:CentrePos_AI, height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  //y_keyPress = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  arrival_keypress = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  //error_kp_txt=new visual.TextStim({ win : psychoJS.window, name:'error_kp_txt',text:'Erreur de touche',font:'Open Sans',units: undefined,pos:[0, winSize[1] / 4.5], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  NospacekpComponentsClock = new util.Clock();
  text_NospacekpComponents= new visual.TextStim({ win : psychoJS.window, name:'text_NospacekpComponents',
    text:'Vous n\'avez pas appuyé sur la touche espace à temps.',
    font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  key_NospacekpComponents = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  SonClock = new util.Clock();
  sound_neutral = new sound.Sound({
    win: psychoJS.window,
    value: 'Sound/neutre.wav',
    secs: 0.2,
    });
  sound_neutral.setVolume(1.0);
  
  sound_bad = new sound.Sound({
    win: psychoJS.window,
    value: 'Sound/buzz.wav',
    secs: 0.2,
    });
  sound_bad.setVolume(1.0);
  
  sound_good = new sound.Sound({
    win: psychoJS.window,
    value: 'Sound/ding.wav',
    secs: 0.2,
    });
  sound_good.setVolume(1.0);

  //function getKeyPress() {
    //let keys = psychoJS.eventManager.getKeys({keyList:[]});
    //if (keys.length > 0) {
      //console.log('PRESHOT KEYS');
      //return keys[0];
    //} else {
      //return null;
    //}
  //} 


  Estimation_tempsClock = new util.Clock();
  estimation_key_resp = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  estimation_txt=new visual.TextStim({ win : psychoJS.window, name:'estimationtext', text:'Le délais entre votre pression sur la touche espace et le son entendu se trouve entre 1 et 1500 millisecondes. \n\n Entrez à l\'aide du clavier votre estimation en millisecondes', font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  score_trial_AI = 0;
  Feedback_tempsClock = new util.Clock();
  feedback_text = new visual.TextStim({win : psychoJS.window,name:'fedbacktxt',text:'',font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  feedback_kp = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  SoAClock = new util.Clock();
  SoA_key_resp= new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  SoA_validation_key= new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  SoA_txt = new visual.TextStim({ win : psychoJS.window, name:'SoA_txt', text:'Dans quelle mesure vous êtes vous senti au contrôle de l\'essai ? (1-10) \n\n Entrez à l\'aide du clavier votre estimation sur une échelle allant de 1 à 10 puis appuyez sur la touche [entrée] pour valider votre choix et passer à l\'essai suivant ', font:'Open Sans',units: undefined,pos:[0, 0], height:20,wrapWidth: 1200, ori:0,color:new util.Color([-1, -1, -1]), opacity:1,depth:0});
  nbOfTrialAI=0;
  
    // Initialize compo for routine feedback 
      //fast_strat, safe_strat, strategie_motor, is_safe, is_fast, fast_true, safe_true = 0, 0, 0, 0, 0, false, false;
        //count_fast, count_safe = 0, 0;

  // Initialize compo for routine feedback 
  //fast_strat, safe_strat, strategie_motor, is_safe, is_fast, fast_true, safe_true = 0, 0, 0, 0, 0, false, false;
  //count_fast, count_safe = 0, 0;
  return Scheduler.Event.NEXT;

}




var t;
var frameN;
var continueRoutine;
var _key_resp_allKeys;

var ConsigneComponents;
function ConsigneRoutineBegin(snapshot) {
  return  async function () {
    TrialHandler.fromSnapshot(snapshot); 
    //------Prepare to start Routine 'Consigne'-------
    //console.log('Consigne routine begin');
    t = 0;
    Consigne_AI_Clock.reset(); // clock
    psychoJS.eventManager.clearEvents();
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
   
    key_resp1_AI.keys = undefined;
    key_resp1_AI.rt = undefined;
    key_resp2_AI.keys = undefined;
    key_resp2_AI.rt = undefined;
    key_resp3_AI.keys = undefined;
    key_resp3_AI.rt = undefined;
    key_resp4_AI.keys = undefined;
    key_resp4_AI.rt = undefined;
    key_resp5_AI.keys = undefined;
    key_resp5_AI.rt = undefined;
    key_resp6_AI.keys = undefined;
    key_resp6_AI.rt = undefined;
    key_resp7_AI.keys = undefined;
    key_resp7_AI.rt = undefined;
    key_resp8_AI.keys = undefined;
    key_resp8_AI.rt = undefined;
    key_resp9_AI.keys = undefined;
    key_resp9_AI.rt = undefined;

    _key_resp_allKeys=[];
          // keep track of which components have finished
    ConsigneComponents = [];
    ConsigneComponents.push(text_AI_instruc1);
    ConsigneComponents.push(text_AI_instruc2);
    ConsigneComponents.push(text_AI_instruc3);
    ConsigneComponents.push(text_AI_instruc4);
    ConsigneComponents.push(text_AI_instruc5);
    ConsigneComponents.push(text_AI_instruc6);
    ConsigneComponents.push(text_AI_instruc7);
    ConsigneComponents.push(text_AI_instruc8);
    ConsigneComponents.push(text_AI_instruc9);
    ConsigneComponents.push(key_resp1_AI);
    ConsigneComponents.push(key_resp2_AI);
    ConsigneComponents.push(key_resp3_AI);
    ConsigneComponents.push(key_resp4_AI);
    ConsigneComponents.push(key_resp5_AI);
    ConsigneComponents.push(key_resp6_AI);
    ConsigneComponents.push(key_resp7_AI);
    ConsigneComponents.push(key_resp8_AI);
    ConsigneComponents.push(key_resp9_AI);
    

   
    
    for (const thisComponent of ConsigneComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function ConsigneRoutineEachFrame(snapshot) {
  var time_txt1_f;
  var txt1_f_affichage;
  var time_txt2_f;
  var txt2_f_affichage;
  var time_txt3_f;
  var txt3_f_affichage;
  var time_txt4_f;
  var txt4_f_affichage;
  var time_txt5_f;
  var txt5_f_affichage;
  var time_txt6_f;
  var txt6_f_affichage;
  var time_txt7_f;
  var txt7_f_affichage;
  var time_txt8_f;
  var txt8_f_affichage;
  var time_txt9_f;
  var txt9_f_affichage;
  var estimR='';
  var erreurestimRisk;
  var finEstimRisk;
  var finerreurestimRisk;
  var time_txtValidationrisk_f;

  

  return async function () {
    //console.log('Consigne routine eachframe');
    //------Loop for each frame of Routine 'Consigne'-------
    // get current time
    t = Consigne_AI_Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    // *Consigne_image* updates
    if (  t >= 0.0 && text_AI_instruc1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc1.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc1.frameNStart = frameN;  // exact frame index
      text_AI_instruc1.setAutoDraw(true);
    }
    
    // *key_resp* updates
    if ( t >= 0.0 && key_resp1_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp1_AI.tStart = t;  // (not accounting for frame time here)
      key_resp1_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp1_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp1_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp1_AI.clearEvents(); });
    }

    if ( key_resp1_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp1_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      //!txt1_f_affichage &&
      if ( !txt1_f_affichage && _key_resp_allKeys.length > 0) {
        txt1_f_affichage=true;
        key_resp1_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp1_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt1_f=Consigne_AI_Clock.getTime();
        text_AI_instruc1.setAutoDraw(false);
        

      }
    }

    if ( t >= time_txt1_f && text_AI_instruc2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc2.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc2.frameNStart = frameN;  // exact frame index
      text_AI_instruc2.setAutoDraw(true);
      
    }
    
    if ( t >= time_txt1_f  && key_resp2_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp2_AI.tStart = t;  // (not accounting for frame time here)
      key_resp2_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp2_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp2_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp2_AI.clearEvents(); });
    }

    if ( key_resp2_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp2_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if (!txt2_f_affichage && theseKeys.length > 0) {
        txt2_f_affichage= true;
        key_resp2_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp2_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt2_f=Consigne_AI_Clock.getTime();
        text_AI_instruc2.setAutoDraw(false);

      }
    }

    if ( t >= time_txt2_f && text_AI_instruc3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc3.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc3.frameNStart = frameN;  // exact frame index
      text_AI_instruc3.setAutoDraw(true);
      //console.log('text_instruc3:');
      
    }
    if (t >= time_txt2_f  && key_resp3_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp3_AI.tStart = t;  // (not accounting for frame time here)
      key_resp3_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp3_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp3_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp3_AI.clearEvents(); });
    }
    if ( key_resp3_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp3_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if ( !txt3_f_affichage && theseKeys.length > 0) {
        txt3_f_affichage=true;
        key_resp3_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp3_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt3_f=Consigne_AI_Clock.getTime();
        text_AI_instruc3.setAutoDraw(false);
        
      }
    }

    if ( t >= time_txt3_f && text_AI_instruc4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc4.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc4.frameNStart = frameN;  // exact frame index
      text_AI_instruc4.setAutoDraw(true);
      //console.log('text_motor_instruc4:');
      
    }
    if (t >= time_txt3_f  && key_resp4_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp4_AI.tStart = t;  // (not accounting for frame time here)
      key_resp4_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp4_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp4_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp4_AI.clearEvents(); });
    }


    if ( key_resp4_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp4_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if ( !txt4_f_affichage && theseKeys.length > 0) {
        txt4_f_affichage=true;
        key_resp4_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp4_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt4_f=Consigne_AI_Clock.getTime();
        text_AI_instruc4.setAutoDraw(false);
        

      }
    }

    if ( t >= time_txt4_f && text_AI_instruc5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc5.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc5.frameNStart = frameN;  // exact frame index
      text_AI_instruc5.setAutoDraw(true);
      //console.log('text_motor_instruc5:');
      
    }
    if ( t >= time_txt4_f  && key_resp5_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp5_AI.tStart = t;  // (not accounting for frame time here)
      key_resp5_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp5_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp5_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp5_AI.clearEvents(); });
    }


    if ( key_resp5_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp5_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if ( !txt5_f_affichage && theseKeys.length > 0) {

        txt5_f_affichage=true;
        key_resp5_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp5_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt5_f=Consigne_AI_Clock.getTime();
        text_AI_instruc5.setAutoDraw(false);
        
      }
    }
    if (t >= time_txt5_f && text_AI_instruc6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc6.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc6.frameNStart = frameN;  // exact frame index
      text_AI_instruc6.setAutoDraw(true);
      
    }
    if (t >= time_txt5_f  && key_resp6_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp6_AI.tStart = t;  // (not accounting for frame time here)
      key_resp6_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp6_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp6_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp6_AI.clearEvents(); });
    }

    if (  key_resp6_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp6_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if ( !txt6_f_affichage && theseKeys.length > 0) {
        txt6_f_affichage=true;
        key_resp6_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp6_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt6_f=Consigne_AI_Clock.getTime();
        text_AI_instruc6.setAutoDraw(false);
        
      }
    }

    if ( t >= time_txt6_f && text_AI_instruc7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc7.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc7.frameNStart = frameN;  // exact frame index
      text_AI_instruc7.setAutoDraw(true);
      //console.log('text_motor_instruc7:');
      
    }
    if ( t >= time_txt6_f  && key_resp7_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp7_AI.tStart = t;  // (not accounting for frame time here)
      key_resp7_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp7_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp7_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp7_AI.clearEvents(); });
    }


    if (key_resp7_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp7_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if (!txt7_f_affichage &&  theseKeys.length > 0) {
        txt7_f_affichage=true;
        key_resp7_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp7_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt7_f=Consigne_AI_Clock.getTime();
        text_AI_instruc7.setAutoDraw(false);
        
      }
    }

    if ( t >= time_txt7_f && text_AI_instruc8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc8.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc8.frameNStart = frameN;  // exact frame index
      text_AI_instruc8.setAutoDraw(true);
      //console.log('text_motor_instruc8:');
    
    }
    if ( t >= time_txt7_f  && key_resp8_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp8_AI.tStart = t;  // (not accounting for frame time here)
      key_resp8_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp8_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp8_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp8_AI.clearEvents(); });
    }


    if ( key_resp8_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp8_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if ( !txt8_f_affichage &&  theseKeys.length > 0) {
        txt8_f_affichage=true;
        key_resp8_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp8_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt8_f=Consigne_AI_Clock.getTime();
        text_AI_instruc8.setAutoDraw(false);
        
      }
    }

    if ( t >= time_txt8_f && text_AI_instruc9.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_AI_instruc9.tStart = t;  // (not accounting for frame time here)
      text_AI_instruc9.frameNStart = frameN;  // exact frame index
      text_AI_instruc9.setAutoDraw(true);
      //console.log('text_motor_instruc9:');
      
    }
    if ( t >= time_txt8_f  && key_resp9_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp9_AI.tStart = t;  // (not accounting for frame time here)
      key_resp9_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp9_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp9_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp9_AI.clearEvents(); });
    }

    if (  key_resp9_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp9_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if ( !txt9_f_affichage && theseKeys.length > 0) {
        txt9_f_affichage=true;
        key_resp9_AI.keys = _key_resp_allKeys[_key_resp_allKeys.length-1].name;  // just the last key pressed
        key_resp9_AI.rt = _key_resp_allKeys[_key_resp_allKeys.length-1].rt;
        time_txt9_f=Consigne_AI_Clock.getTime();
        text_AI_instruc9.setAutoDraw(false);
        continueRoutine=false;
      }
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of ConsigneComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function ConsigneRoutineEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Consigne'-------
    //console.log('Consigne routine end');
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    for (const thisComponent of ConsigneComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // update the trial handler
    if (currentLoop instanceof MultiStairHandler) {
      currentLoop.addResponse(key_resp1_AI.corr, level);
    }
    

  

    key_resp1_AI.stop();
    key_resp2_AI.stop();
    key_resp3_AI.stop();
    key_resp4_AI.stop();
    key_resp5_AI.stop();
    key_resp6_AI.stop();
    key_resp7_AI.stop();
    key_resp8_AI.stop();
    key_resp9_AI.stop();
    

  
    // the Routine "Consigne" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();

    return Scheduler.Event.NEXT;
  };
}




var fin_kp_resp_allKeys;
var FinTrialComponents;
function fintrialTextBegin(snapshot) {
  return  async function () {
    TrialHandler.fromSnapshot(snapshot);
    t = 0;
    clock_fin_AI.reset(); // cloc
    frameN = -1;
    continueRoutine=true;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    window.psychoJS = psychoJS;
    window.util = util;
    window.txt_fin_AI=txt_fin_AI;
    // update component parameters for each repeat
    window.fin_kp_AI=fin_kp_AI;
    fin_kp_AI.keys = undefined;
    fin_kp_AI.rt = undefined;
    fin_kp_resp_allKeys = [];
    // keep track of which components have finished
    FinTrialComponents = [];
    FinTrialComponents.push(txt_fin_AI);
    FinTrialComponents.push(fin_kp_AI);
    //console.log('fintrialTextBegin');
    for (const thisComponent of FinTrialComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}

function fintrialTextEachFrame() {
  return async function () {
    //------Loop for each frame of Routine 'Consigne'-------
    // get current time
    //console.log('fintrialTextEachFrame');
    t = clock_fin_AI.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    // update/draw components on each frame
    // *Consigne_image* updates
    if (t >= 0.0 && txt_fin_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_fin_AI.tStart = t;  // (not accounting for frame time here)
      txt_fin_AI.frameNStart = frameN;  // exact frame index
      txt_fin_AI.setAutoDraw(true);
      //console.log('DRAW txt_fin');
    }
    // *key_resp* updates
    if (t >= 0.0 && fin_kp_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      fin_kp_AI.tStart = t;  // (not accounting for frame time here)
      fin_kp_AI.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { fin_kp_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { fin_kp_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { fin_kp_AI.clearEvents(); });
    }

    if (fin_kp_AI.status === PsychoJS.Status.STARTED) {
      let theseKeys = fin_kp_AI.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      fin_kp_resp_allKeys = fin_kp_resp_allKeys.concat(theseKeys);
      if (fin_kp_resp_allKeys.length > 0) {
        fin_kp_AI.keys = fin_kp_resp_allKeys[fin_kp_resp_allKeys.length-1].name;  // just the last key pressed
        fin_kp_AI.rt = fin_kp_resp_allKeys[fin_kp_resp_allKeys.length-1].rt;
        let time_fin_kp= clock_fin_AI.getTime();
        //console.log('time_fin_kp:',time_fin_kp);
        // a response ends the routine
        continueRoutine = false;
        //console.log('textfin KEYP');
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of FinTrialComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function fintrialTextEachEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Consigne'-------
    //console.log('fintrialTextEachEnd');
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    for (const thisComponent of FinTrialComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // update the trial handler
    
    psychoJS.experiment.addData('fin_kp_AI.keys', fin_kp_AI.keys);
    if (typeof fin_kp_AI.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('fin_kp_AI.rt', fin_kp_AI.rt);
        routineTimer.reset();
        }
    
    fin_kp_AI.stop();
    // the Routine "Consigne" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    return Scheduler.Event.NEXT;
  };
}

var currentLoop;
var trialsloopRisk;
function trialsloopRiskBegin(trialsloopRiskScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    // set up handler to look after randomisation of conditions etc
    trialsloopRisk = new TrialHandler({psychoJS: psychoJS,nReps: nRepEstimRisk, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,trialList: undefined,seed: undefined, name: 'trialsloopRisk'});
    psychoJS.experiment.addLoop(trialsloopRisk); // add the loop to the experiment
    currentLoop = trialsloopRisk;
    console.log('trialsloopRisk');

    // Schedule all the trials in the trialList:
    for (const thisTrialsloop of trialsloopRisk) {
      snapshot = trialsloopRisk.getSnapshot();
      trialsloopRiskScheduler.add(importConditions(snapshot));
      trialsloopRiskScheduler.add(estimationRiskTextBegin(snapshot));
      trialsloopRiskScheduler.add(estimationRiskTextEachFrame());
      trialsloopRiskScheduler.add(estimationRiskEnd(snapshot));
      trialsloopRiskScheduler.add(trialsloopEndIteration(trialsloopRiskScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}

async function trialsloopRiskEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(trialsloopRisk);
  // update the current loop from the ExperimentHandler
  return Scheduler.Event.NEXT;
}

var estimationrisk_allKeys;
var finestimation_allKeys;
var key_feedback_allKeys;
var finestimationRisk_allKeys;
var finestimationRiskERREUR_allKeys;
var EstimriskCompo;
function estimationRiskTextBegin(snapshot) {
  
  return  async function () {
    TrialHandler.fromSnapshot(snapshot);
    //console.log('estimationRiskTextBegin');
    t = 0;
    clock_Error_EstimRisk.reset(); // cloc
    frameN = -1;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    continueRoutine=true;
    window.psychoJS = psychoJS;
    window.util = util;
    key_estimrisk.keys= undefined;
    key_estimrisk.rt=undefined;
    key_estimrisk_validation.keys=undefined;
    key_estimrisk_validation.rt=undefined;
    key_estimrisk_erreurvalid.keys=undefined;
    key_estimrisk_erreurvalid.rt=undefined;
    key_feedback_estim_risk.keys=undefined;
    key_feedback_estim_risk.rt=undefined;
    estimationrisk_allKeys=[];
    finestimationRisk_allKeys=[];
    key_feedback_allKeys=[];
    finestimationRiskERREUR_allKeys=[];
    // keep track of which components have finished
    EstimriskCompo = [];
    EstimriskCompo.push(txt_estimrisk);
    EstimriskCompo.push(feedback_estim_risk);
    EstimriskCompo.push(key_estimrisk);
    EstimriskCompo.push(key_estimrisk_validation);
    EstimriskCompo.push(key_feedback_estim_risk);
    EstimriskCompo.push(texte_erreur);
    EstimriskCompo.push(key_estimrisk_erreurvalid);

    
    //console.log('fintrialTextBegin');
    for (const thisComponent of EstimriskCompo)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function estimationRiskTextEachFrame() {
  let estimR='';
  let time_txtestimrisk_f;
  let time_txtValidationrisk_f;
  let txtestimrisk_f_affichage;
  let time_txtFeedbackrisk_f;
  let erreurestimRisk;
  let finEstimRisk;
  let finerreurestimRisk;
  let errorRisk;
  let errorRiskeaffichage;



  return async function () {
    //console.log('estimationRiskTextEachFrame');
    //------Loop for each frame of Routine 'Consigne'-------
    // get current time
    //console.log('fintrialTextEachFrame');
    t = clock_Error_EstimRisk.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    
    // update/draw components on each frame
    // *Consigne_image* updates
    if ( t >= 0 && txt_estimrisk.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_estimrisk.tStart = t;  // (not accounting for frame time here)
      txt_estimrisk.frameNStart = frameN;  // exact frame index
      txt_estimrisk.setAutoDraw(true);
    }
    
    if (t >= 0 && key_estimrisk.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_estimrisk.tStart = t;  // (not accounting for frame time here)
      key_estimrisk.frameNStart = frameN;  // exact frame index
     
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_estimrisk.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_estimrisk.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_estimrisk.clearEvents(); });
    }

    if (key_estimrisk.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_estimrisk.getKeys({keyList: ['0','1','2','3','4','5','6','7','8','9','num_0', 'num_1', 'num_2', 'num_3', 'num_4', 'num_5','num_6', 'num_7', 'num_8', 'num_9'],waitRelease: false});
      for (let i = 0; i < theseKeys.length; i++) {
        let key = theseKeys[i].name;
        estimationrisk_allKeys.push(key); // Use push to add elements to the array
        //console.log("estimationrisk_allKeys", estimationrisk_allKeys);
        //console.log("key", key);
      }

      if (theseKeys.length > 0) {
        key_estimrisk.keys = estimationrisk_allKeys.join(""); // Join the array elements into a string
        key_estimrisk.rt = theseKeys[0].rt; // Assuming you want the reaction time of the first key
        estimR = key_estimrisk.keys.replace("num_", "");
        estimRisk=parseInt(estimR);
        time_txtestimrisk_f=clock_Error_EstimRisk.getTime();
        if (estimRisk > 14 && estimRisk < 51) {
          window.erreurestimRisk=false;
          //window.errorRisk=false;
          
        } else if ( estimRisk < 15 || estimRisk > 50){
          window.erreurestimRisk=true;
          
        }
      }
      
    }
    if (t >= time_txtestimrisk_f && key_estimrisk_validation.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_estimrisk_validation.tStart = t;  // (not accounting for frame time here)
      key_estimrisk_validation.frameNStart = frameN;  // exact frame index
      //console.log('SoA_validation_key');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_estimrisk_validation.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_estimrisk_validation.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_estimrisk_validation.clearEvents(); });
    }

    if ( key_estimrisk_validation.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_estimrisk_validation.getKeys({keyList: ['return','enter','num_enter'],waitRelease: false});
      finestimationRisk_allKeys = finestimationRisk_allKeys.concat(theseKeys);
      if ( theseKeys.length > 0 ) {
        key_estimrisk_validation.keys = finestimationRisk_allKeys[finestimationRisk_allKeys.length-1].name;  // just the last key pressed
        key_estimrisk_validation.rt = finestimationRisk_allKeys[finestimationRisk_allKeys.length-1].rt;
        time_txtValidationrisk_f=clock_Error_EstimRisk.getTime();
        txt_estimrisk.setAutoDraw(false);
      } 
    }

    
    if (!window.erreurestimRisk && !window.finEstimRisk&&  t>=time_txtValidationrisk_f && feedback_estim_risk.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      feedback_estim_risk.tStart = t;  // (not accounting for frame time here)
      feedback_estim_risk.frameNStart = frameN;  // exact frame index
      feedback_estim_risk.setText('Votre niveau de risque pris est de :' + estimRisk + ' %. \n\n Vous êtes prêt ? Si oui appuyez sur la touche entrée pour commencer l\'expérience!');
      feedback_estim_risk.setAutoDraw(true);

      //console.log('FEEDBACK TEXT DRAW:');
    }
    // *key_resp* updates
    if ( !window.erreurestimRisk && ! window.finEstimRisk &&  t>=time_txtValidationrisk_f &&  key_feedback_estim_risk.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_feedback_estim_risk.tStart = t;  // (not accounting for frame time here)
      key_feedback_estim_risk.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_feedback_estim_risk.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_feedback_estim_risk.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_feedback_estim_risk.clearEvents(); });
    }

    if ( key_feedback_estim_risk.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_feedback_estim_risk.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      key_feedback_allKeys = key_feedback_allKeys.concat(theseKeys);
      if (theseKeys.length > 0) {
        key_feedback_estim_risk.keys = key_feedback_allKeys[key_feedback_allKeys.length-1].name;  // just the last key pressed
        key_feedback_estim_risk.rt = key_feedback_allKeys[key_feedback_allKeys.length-1].rt;
        window.finEstimRisk=true;
        window.errorRisk=false;
        // a response ends the routine
        time_txtFeedbackrisk_f=clock_Error_EstimRisk.getTime();
        continueRoutine=false;

        //console.log('key press feedback');
      }
    }

    if (window.erreurestimRisk && t>=time_txtValidationrisk_f &&  texte_erreur.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      texte_erreur.tStart = t;  // (not accounting for frame time here)
      texte_erreur.frameNStart = frameN;  // exact frame index
      texte_erreur.setAutoDraw(true);
      errorRiskeaffichage=true;

    }


    if (window.erreurestimRisk && t>=time_txtValidationrisk_f && errorRiskeaffichage &&  key_estimrisk_erreurvalid.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_estimrisk_erreurvalid.tStart = t;  // (not accounting for frame time here)
      key_estimrisk_erreurvalid.frameNStart = frameN;  // exact frame index
      //console.log('SoA_validation_key');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_estimrisk_erreurvalid.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_estimrisk_erreurvalid.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_estimrisk_erreurvalid.clearEvents(); });
    }

    if ( window.erreurestimRisk && errorRiskeaffichage && key_estimrisk_erreurvalid.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_estimrisk_erreurvalid.getKeys({keyList: ['return','enter','num_enter'],waitRelease: false});
      finestimationRiskERREUR_allKeys = finestimationRiskERREUR_allKeys.concat(theseKeys);
      //console.log("theseKeys", theseKeys);
      if (theseKeys.length > 0) {
        window.finerreurEstimRisk=true;
        window.errorRisk=true;
        key_estimrisk_erreurvalid.keys = finestimationRiskERREUR_allKeys[finestimationRiskERREUR_allKeys.length-1].name;  // just the last key pressed
        key_estimrisk_erreurvalid.rt = finestimationRiskERREUR_allKeys[finestimationRiskERREUR_allKeys.length-1].rt;
        continueRoutine=false;
        
      }
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of EstimriskCompo)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function estimationRiskEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Consigne'-------
    //console.log('fintrialTextEachEnd');
    //console.log('estimationRiskEnd');

    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    
    if (!window.erreurestimRisk && !window.errorRisk){
      // nbOfTrialMotor >= 30
      trialsloopRisk.finished=true;
      //console.log('trialsloopRisk.finished:',trialsloopRisk.finished);
      continueRoutine=false;
      //console.log('trialsloop.continueRoutineTrialRoutineBegin:',continueRoutine);
      //console.log('trialsloopRisk.estimationRiskEnd:',trialsloopRisk.finished);
      //console.log('continueRoutine.estimationRiskEnd:',continueRoutine);

    } else{
      nRepEstimRisk+=1;
      trialsloopRisk.finished=false;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      //console.log('trialsloopRisk.finished:',trialsloopRisk.finished);
      //console.log('trialsloop.continueRoutineTrialRoutineBegin:',continueRoutine);
      continueRoutine=true;
      //console.log('trialsloopRisk.estimationRiskEnd:',trialsloopRisk.finished);
      //console.log('continueRoutine.estimationRiskEnd:',continueRoutine);
    }
    
    for (const thisComponent of EstimriskCompo) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // update the trial handler

    psychoJS.experiment.addData("estimRisk",estimRisk);
    
    if (typeof key_estimrisk.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('key_estimrisk.rt', key_estimrisk.rt);
        routineTimer.reset();
        }
    
    psychoJS.experiment.addData('key_estimrisk_validation.keys', key_estimrisk_validation.keys);
    if (typeof key_estimrisk_validation.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('key_estimrisk_validation.rt', key_estimrisk_validation.rt);
        routineTimer.reset();
        }

    psychoJS.experiment.addData('key_estimrisk_erreurvalid.keys', key_estimrisk_erreurvalid.keys);
    if (typeof key_estimrisk_erreurvalid.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('key_estimrisk_erreurvalid.rt', key_estimrisk_erreurvalid.rt);
        routineTimer.reset();
        }

    psychoJS.experiment.addData('key_feedback_estim_risk.keys', key_feedback_estim_risk.keys);
    if (typeof key_feedback_estim_risk.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('key_feedback_estim_risk.rt', key_feedback_estim_risk.rt);
        routineTimer.reset();
        }
    //psychoJS.experiment.addData('time_txtestimrisk_f', time_txtestimrisk_f);
    //psychoJS.experiment.addData("window.erreurestimRisk ", window.erreurestimRisk);
    //psychoJS.experiment.addData("time_txtValidationrisk_f",time_txtValidationrisk_f);
    //psychoJS.experiment.addData("window.finEstimRisk", window.finEstimRisk);
    //psychoJS.experiment.addData("window.errorRisk", window.errorRisk);
    //psychoJS.experiment.addData("time_txtFeedbackrisk_f",time_txtFeedbackrisk_f);
    //psychoJS.experiment.addData("window.finerreurEstimRisk", window.finerreurEstimRisk);
    key_estimrisk.stop();
    key_estimrisk_erreurvalid.stop();
    key_estimrisk_validation.stop();
    key_feedback_estim_risk.stop();
    // the Routine "Consigne" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    return Scheduler.Event.NEXT;
  };
}



var trialsMain;
function trialsloopMainBegin(trialsloopMainScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    trialsMain = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList:'condition_files27_03_ok.xlsx',
      seed: undefined, name: 'trialsMain'
    });
    psychoJS.experiment.addLoop(trialsMain); // add the loop to the experiment
    currentLoop = trialsMain;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisTrial of trialsMain) {
      const snapshot = trialsMain.getSnapshot();
      trialsloopMainScheduler.add(importConditions(snapshot));
      trialsloopMainScheduler.add(BreakRoutineBegin(snapshot));
      trialsloopMainScheduler.add(BreakRoutineEachFrame());
      trialsloopMainScheduler.add(BreakRoutineEnd(snapshot));
      const trialsUserchoiceLoopScheduler = new Scheduler(psychoJS);
      trialsloopMainScheduler.add(trialsUserchoiceLoopBegin(trialsUserchoiceLoopScheduler, snapshot));
      trialsloopMainScheduler.add(trialsUserchoiceLoopScheduler);
      trialsloopMainScheduler.add(trialsUserchoiceLoopEnd);
      trialsloopMainScheduler.add(CarMovementBegin(snapshot));
      trialsloopMainScheduler.add(CarMovementEachFrame());
      trialsloopMainScheduler.add(CarMovementEnd(snapshot));
      trialsloopMainScheduler.add(SonRoutineBegin(snapshot));
      trialsloopMainScheduler.add(SonRoutineEachFrame());
      trialsloopMainScheduler.add(SonRoutineEnd(snapshot));
      trialsloopMainScheduler.add(Estimation_tempsRoutineBegin(snapshot));
      trialsloopMainScheduler.add(Estimation_tempsRoutineEachFrame());
      trialsloopMainScheduler.add(Estimation_tempsRoutineEnd(snapshot));
      trialsloopMainScheduler.add(Estimation_SoARoutineBegin(snapshot));
      trialsloopMainScheduler.add(Estimation_SoARoutineEachFrame());
      trialsloopMainScheduler.add(Estimation_SoARoutineEnd(snapshot));
      trialsloopMainScheduler.add(FeedbackRoutineBegin(snapshot));
      trialsloopMainScheduler.add(FeedbackRoutineEachFrame());
      trialsloopMainScheduler.add(FeedbackRoutineEnd(snapshot));
      trialsloopMainScheduler.add(trialsloopEndIteration(trialsloopMainScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


let i;
var BreakComponents;
var timerend_allKeys;
function BreakRoutineBegin(snapshot) {
  return async function () {      
    console.log('BreakRoutineBegin');
    
    TrialHandler.fromSnapshot(snapshot);
      //------Prepare to start Routine 'Son'-------
    t = 0;
    clock_break.reset(); // clock
    frameN = -1;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    continueRoutine=true;
    i=1;
    
    key_timer_ENDbreak.keys = undefined;
    key_timer_ENDbreak.rt=undefined;
    timerend_allKeys=[];
    BreakComponents=[];
    window.txt_break_1=txt_break_1;
    window.txt_break_2=txt_break_2;
    window.txt_timer_break=txt_timer_break;
    window.txt_timer_ENDbreak=txt_timer_ENDbreak;
    BreakComponents.push(txt_break_1);
    BreakComponents.push(txt_break_2);
    BreakComponents.push(txt_timer_break);
    BreakComponents.push(txt_timer_ENDbreak);
    BreakComponents.push(key_timer_ENDbreak);

   
    for (const thisComponent of BreakComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
      return Scheduler.Event.NEXT;
  }
}

let txt_break;
function BreakRoutineEachFrame() {
  
  return async function () {
    //------Loop for each frame of Routine 'Son'-------
    //console.log('UserChoiceEachFrame');
    t = clock_break.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    //console.log('erroruserchoice',window.erroruserchoice);
    if (trialsMain.thisN ==26 || trialsMain.thisN ==80 || trialsMain.thisN ==54  ){
      continueRoutine=true;
    } else {
      continueRoutine=false;
    }

    
    // get current time
    
    //console.log('frameN:', frameN);    
    // update/draw components on each frame
    
    if (t >= 0 && (trialsMain.thisN ==26 || trialsMain.thisN ==80 ) && txt_break_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_break_1.tStart = t;  // (not accounting for frame time here)
      txt_break_1.frameNStart = frameN;  // exact frame index
      txt_break_1.setAutoDraw(true);
    }
    if (t >= 0 && (trialsMain.thisN ==54 ) && txt_break_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_break_2.tStart = t;  // (not accounting for frame time here)
      txt_break_2.frameNStart = frameN;  // exact frame index
      txt_break_2.setAutoDraw(true);
    }
    
    
    if (t >= 0 && txt_timer_break.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_timer_break.tStart = t;  // (not accounting for frame time here)
      txt_timer_break.frameNStart = frameN;  // exact frame index
      txt_timer_break.setAutoDraw(true);
    }

    if (txt_timer_break.status === PsychoJS.Status.STARTED && t<=60) {
      //console.log('dist_AI:', dist_AI); 
      let timing = clock_break.getTime();
      if (timing >=i){
        txt_timer_break.setText(''+String(60-i)+'');
        txt_timer_break.setAutoDraw(true);
        i += 1;
        console.log('i:',i);
      }
    }
    if ( t >= 60 && txt_timer_ENDbreak.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_timer_ENDbreak.tStart = t;  // (not accounting for frame time here)
      txt_timer_ENDbreak.frameNStart = frameN;  // exact frame index
      txt_timer_break.setAutoDraw(false);
      txt_break_1.setAutoDraw(false);
      txt_break_2.setAutoDraw(false);
      txt_timer_ENDbreak.setAutoDraw(true);
    }


    if (t >= 60 && key_timer_ENDbreak.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      //console.log('key_estimrisk not started');
      key_timer_ENDbreak.tStart = t;  // (not accounting for frame time here)
      key_timer_ENDbreak.frameNStart = frameN;  // exact frame index
      txt_timer_break.setAutoDraw(false);
      txt_break_1.setAutoDraw(false);
      txt_break_2.setAutoDraw(false);
      //console.log('SoA_key_resp');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_timer_ENDbreak.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_timer_ENDbreak.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_timer_ENDbreak.clearEvents(); });
    }

    if ( t >= 60 && key_timer_ENDbreak.status === PsychoJS.Status.STARTED) {
      //console.log('key_estimrisk started');
      txt_timer_break.setAutoDraw(false);
      let theseKeys = key_timer_ENDbreak.getKeys({keyList: ['return','enter','num_enter'],waitRelease: false});
      timerend_allKeys = timerend_allKeys.concat(theseKeys);
      
      if (theseKeys.length > 0) {
        let time_end_break_kp=clock_break.getTime();
        //console.log('type of estimRisk:', typeof estimRisk);
        //console.log("key_estimrisk.keys", key_estimrisk.keys);
        //console.log("key_estimrisk.rt", key_estimrisk.rt);
        //console.log("estimRisk", estimRisk);
        key_timer_ENDbreak.keys = timerend_allKeys[timerend_allKeys.length-1].name;  // just the last key pressed
        key_timer_ENDbreak.rt = timerend_allKeys[timerend_allKeys.length-1].rt;
        continueRoutine=false;
        
      
      }
      
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of BreakComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function BreakRoutineEnd(snapshot) {
  return async function () {
    //console.log('UserChoiceEnd end');
    //------Ending Routine 'Estimation temps '-------
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    for (const thisComponent of BreakComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }

    psychoJS.experiment.addData('key_timer_ENDbreak.keys', key_timer_ENDbreak.keys);
    if (typeof key_timer_ENDbreak.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('key_timer_ENDbreak.rt', key_timer_ENDbreak.rt);
        routineTimer.reset();
        }
    key_timer_ENDbreak.stop();

    
    // the Routine "Trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}


var trialsUserchoice;
function trialsUserchoiceLoopBegin(trialsUserchoiceLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    trialsUserchoice = new TrialHandler({
      psychoJS: psychoJS,
      nReps: nRepsUserchoice, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'trialsUserchoice'
    });
    psychoJS.experiment.addLoop(trialsUserchoice); // add the loop to the experiment
    currentLoop = trialsUserchoice;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisTrialsloop of trialsUserchoice) {
      snapshot = trialsUserchoice.getSnapshot();
      trialsUserchoiceLoopScheduler.add(importConditions(snapshot));
      trialsUserchoiceLoopScheduler.add(UserChoiceBegin(snapshot));
      trialsUserchoiceLoopScheduler.add(UserChoiceEachFrame());
      trialsUserchoiceLoopScheduler.add(UserChoiceEnd(snapshot));
      
      trialsUserchoiceLoopScheduler.add(trialsloopEndIteration(trialsUserchoiceLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function trialsUserchoiceLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(trialsUserchoice);
  // update the current loop from the ExperimentHandle
  return Scheduler.Event.NEXT;
}




async function trialsloopMainEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(trialsMain);
  // update the current loop from the ExperimentHandler
  return Scheduler.Event.NEXT;
}





let selectedMapUserchoice;
let target_AI;
let strategieAI;
let intentionAI;
let dist_AI;
var userchoice_allKeys;
var userchoice_feedback_allKeys;
var UserChoiceComponents;

function UserChoiceBegin(snapshot) {
  return async function () {      
    //console.log('UserChoiceBegin');
    
    TrialHandler.fromSnapshot(snapshot);
      //------Prepare to start Routine 'Son'-------
    t = 0;
    userchoiceClock_AI.reset(); // clock
    frameN = -1;
    
    intentionAI=intention;
    console.log('intentionAI UserChoiceBegin: ',intentionAI);
    if (intentionAI==0){
      nRepsUserchoice=0;
      continueRoutine=false;
      //trialsUserchoice.finished==rue;
      
      //console.log('UserChoiceBegin.continueRoutine intentionAI==0:',continueRoutine);
      //console.log('UserChoiceBegin.finished:',trialsUserchoice.finished);
      //console.log('trialsloop.continueRoutineTrialRoutineBegin:',continueRoutine);

    } else if (intentionAI==1){
      //trialsMain.finished=false;
      //console.log('trialsMain.finished.UserChoiceBegin:',trialsMain.finished);
      nRepsUserchoice=1;
      strategieAI=strategie;
      target_AI=target;
      selectedMapUserchoice=configmap;
      console.log('strategieAI UserChoiceBegin: ',strategieAI);
      console.log('target_AI UserChoiceBegin: ',target_AI);
      console.log('selectedMapUserchoice UserChoiceBegin: ',selectedMapUserchoice);
      continueRoutine=true;
      //trialsUserchoice.finished==rue;
      
      //console.log('UserChoiceBegin.continueRoutine intentionAI==1:',continueRoutine);
    }
    //psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    //continueRoutine=true;
    
    
    

    
    lEndpoint_AI= -winSize[0] / 5;
    rEndPoint_AI= winSize[0] / 5;
    dist_AI=(rEndPoint_AI * 2) / (60 * 5);
    
    function mapdisplay_AI(selectedMapUserchoice, mapConfigs) {
      let positions = mapConfigs[selectedMapUserchoice];
      //console.log('positions',positions);
      if (positions) {
        money_1.setPos(positions[0]);
        heart_1.setPos(positions[1]);
        money_2.setPos(positions[2]);
        heart_2.setPos(positions[3]);
      }
    }

    //console.log("selectedMapUserchoice userchoice:",selectedMapUserchoice);
    mapdisplay_AI(selectedMapUserchoice, mapConfigs);
    k_presdis_AI.keys = undefined;
    k_presdis_AI.rt=undefined;
    no_userchoicekp_AI.keys= undefined;
    no_userchoicekp_AI.rt=undefined;
    userchoice_allKeys=[];
    userchoice_feedback_allKeys=[];
    UserChoiceComponents=[];
    UserChoiceComponents.push(txt_1_AI);
    UserChoiceComponents.push(txt_2_AI);
    UserChoiceComponents.push(txt_3_AI);
    UserChoiceComponents.push(txt_4_AI);
    UserChoiceComponents.push(heart_1);
    UserChoiceComponents.push(heart_2);
    UserChoiceComponents.push(money_1);
    UserChoiceComponents.push(money_2);
    UserChoiceComponents.push(txt_choice_AI);
    UserChoiceComponents.push(txt_optionstrategie_AI);
    //UserChoiceComponents.push(no_userchoicetxt);
    UserChoiceComponents.push(line_AI);
    UserChoiceComponents.push(k_presdis_AI);
    UserChoiceComponents.push(no_userchoicekp_AI);
    for (const thisComponent of UserChoiceComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
      return Scheduler.Event.NEXT;
  }
}



function UserChoiceEachFrame() {
  let erroruserchoice;
  let timetest;
  let time_keypress_userchoice;
  let time_erroruserchoice;
  let erroruserchoiceaffichage;
  let no_userc;
  let userC='';

  return async function () {
    //------Loop for each frame of Routine 'Son'-------
    //console.log('UserChoiceEachFrame');
    t = userchoiceClock_AI.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    //console.log('window.no_userc',window.no_userc);
    //console.l
    // get current time
    
    //console.log('frameN:', frameN);    
    // update/draw components on each frame
    if (t >= 0 && txt_1_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_1_AI.tStart = t;  // (not accounting for frame time here)
      txt_1_AI.frameNStart = frameN;  // exact frame index
      txt_1_AI.setAutoDraw(true);
    }
    if (t >= 0 && txt_2_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_2_AI.tStart = t;  // (not accounting for frame time here)
      txt_2_AI.frameNStart = frameN;  // exact frame index
      txt_2_AI.setAutoDraw(true);
    }
    if (t >= 0 && txt_3_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_3_AI.tStart = t;  // (not accounting for frame time here)
      txt_3_AI.frameNStart = frameN;  // exact frame index
      txt_3_AI.setAutoDraw(true);
    }
    if (t >= 0 && txt_4_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_4_AI.tStart = t;  // (not accounting for frame time here)
      txt_4_AI.frameNStart = frameN;  // exact frame index
      txt_4_AI.setAutoDraw(true);
    }

    if (t >= 0 && heart_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      heart_1.tStart = t;  // (not accounting for frame time here)
      heart_1.frameNStart = frameN;  // exact frame index
      heart_1.setAutoDraw(true);
    }
    if (t >= 0 && heart_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      heart_2.tStart = t;  // (not accounting for frame time here)
      heart_2.frameNStart = frameN;  // exact frame index
      heart_2.setAutoDraw(true);
    }
    if (t >= 0 && money_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      money_1.tStart = t;  // (not accounting for frame time here)
      money_1.frameNStart = frameN;  // exact frame index
      money_1.setAutoDraw(true);
    }
    if (t >= 0 && money_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      money_2.tStart = t;  // (not accounting for frame time here)
      money_2.frameNStart = frameN;  // exact frame index
      money_2.setAutoDraw(true);
    }
    if (t >= 0 && txt_optionstrategie_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_optionstrategie_AI.tStart = t;  // (not accounting for frame time here)
      txt_optionstrategie_AI.frameNStart = frameN;  // exact frame index
      txt_optionstrategie_AI.setAutoDraw(true);
    }

    if (t >= 0 && line_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      line_AI.tStart = t;  // (not accounting for frame time here)
      line_AI.frameNStart = frameN;  // exact frame index
      line_AI.setAutoDraw(true);
    }
    if (line_AI.status === PsychoJS.Status.STARTED && t<=5) {
      //console.log('dist_AI:', dist_AI); 
      rEndPoint_AI -= dist_AI;
      //console.log('rEndPoint_AI',rEndPoint_AI);
      //[lEndpoint_AI, (winSize[0] / 2) * 0.3], [rEndPoint_AI,(winSize[0] / 4)]
      line_AI.setVertices([[lEndpoint_AI,(winSize[0] / 2) * 0.3], [rEndPoint_AI,(winSize[0] / 2) * 0.3]]);
      line_AI.setAutoDraw(true);
      //timetest=userchoiceClock.getTime();
      //console.log('timetest',timetest);
    }

    if (t >= 0 && k_presdis_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      k_presdis_AI.tStart = t;  // (not accounting for frame time here)
      k_presdis_AI.frameNStart = frameN;  // exact frame index
      //console.log('estimation key press');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { k_presdis_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { k_presdis_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { k_presdis_AI.clearEvents(); });
    }

    
    if (k_presdis_AI.status === PsychoJS.Status.STARTED) {
      let userchoiceKEYS = k_presdis_AI.getKeys({keyList: ['0','1','2','3','4','5','6','7','8','9', 'num_0','num_1', 'num_2', 'num_3','num_4','num_5', 'num_6', 'num_7','num_8','num_9'],waitRelease: false});
      userchoice_allKeys=userchoice_allKeys.concat(userchoiceKEYS);
      if (userchoice_allKeys.length > 0 ) {
        k_presdis_AI.keys = userchoice_allKeys[userchoice_allKeys.length-1].name;
        k_presdis_AI.rt = userchoice_allKeys[userchoice_allKeys.length-1].rt;
        time_keypress_userchoice=userchoiceClock_AI.getTime();
        //console.log("k_presdis_AI.keys",k_presdis_AI.keys);
        //console.log("k_presdis_AI.rt",k_presdis_AI.rt);
        //console.log('time_keypress userchoice target:',time_keypress_userchoice);
        userC = k_presdis_AI.keys.replace("num_", "");
        userChoiceAI=parseInt(userC);
        
        //console.log("userChoiceAI:",userChoiceAI);
        //psychoJS.experiment.addData("userChoiceMotor", userChoiceMotor);

        if ( userChoiceAI == 1 || userChoiceAI == 2 || userChoiceAI == 3 || userChoiceAI == 4) {
          window.no_userc=false;
          window.erroruserchoice=false;
          
          //psychoJS.experiment.addData("erroruserchoice", erroruserchoice);
          
          
          //console.log('no_userc key > 0 et choice dans les choix cible ',window.no_userc);
          //console.log('erroruserchoice ',erroruserchoice);
          //console.log("userchoiceKEYS.length", userchoiceKEYS.length);

        }else if ( userChoiceAI != 1 || userChoiceAI != 2 || userChoiceAI != 3 ||  userChoiceAI != 4) {
          window.erroruserchoice=true;
          time_erroruserchoice=userchoiceClock_AI.getTime();
          
          //psychoJS.experiment.addData("time_erroruserchoice", time_erroruserchoice);
          //psychoJS.experiment.addData("erroruserchoice", erroruserchoice);
          //console.log('time_erroruserchoice :',time_erroruserchoice);
          //console.log('erroruserchoice :',erroruserchoice);
          
          // a response ends the routine
        }
      } else if (t >= 5 && userchoiceKEYS.length <= 0) {
        window.erroruserchoice=true;
        time_erroruserchoice=userchoiceClock_AI.getTime();
        
        //psychoJS.experiment.addData("time_erroruserchoice", time_erroruserchoice);
        //console.log('time_erroruserchoice pas de choix fait au bout de 4 sec:',time_erroruserchoice);
        //psychoJS.experiment.addData("erroruserchoice", erroruserchoice);
        //console.log('erroruserchoice key < 0 ',erroruserchoice);
        
      }
    }

    if (t >= 5 && !window.erroruserchoice && !window.no_userc) {
      continueRoutine=false;
      //trialsUserchoice.finished=true;
    }

    if (t >= 5 && window.erroruserchoice && !erroruserchoiceaffichage) {
      for (const thisComponent of UserChoiceComponents) {
        if (typeof thisComponent.setAutoDraw === 'function') {
          thisComponent.setAutoDraw(false);
        }
      }
      no_userchoicetxt_AI.setAutoDraw(true);
      erroruserchoiceaffichage=true;
      
    }
      
    if (t >= 5 && erroruserchoiceaffichage && no_userchoicekp_AI.status === PsychoJS.Status.NOT_STARTED) {
          // keep track of start time/frame for later
      no_userchoicekp_AI.tStart = t;  // (not accounting for frame time here)
      no_userchoicekp_AI.frameNStart = frameN;  // exact frame index
      //console.log('no_userchoicekp not started ');
      psychoJS.window.callOnFlip(function() { no_userchoicekp_AI.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { no_userchoicekp_AI.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { no_userchoicekp_AI.clearEvents(); });
    }
    if (erroruserchoiceaffichage && no_userchoicekp_AI.status === PsychoJS.Status.STARTED) {
      //console.log('no_userchoicekp  started ');
      let theseKeys = no_userchoicekp_AI.getKeys({keyList: ['return','enter','num_enter'],waitRelease: false});
      userchoice_feedback_allKeys=userchoice_feedback_allKeys.concat(theseKeys);
      if (theseKeys.length > 0) {
        window.no_userc=true;
        no_userchoicekp_AI.keys = userchoice_feedback_allKeys[userchoice_feedback_allKeys.length-1].name;
        no_userchoicekp_AI.rt = userchoice_feedback_allKeys[userchoice_feedback_allKeys.length-1].rt;
        no_userchoicetxt_AI.setAutoDraw(false);
        continueRoutine=false;
        //console.log('UserChoiceEachFramecontinue:',continueRoutine);
      } 
    }
      
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of UserChoiceComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function UserChoiceEnd(snapshot) {
  return async function () {
    //console.log('UserChoiceEnd end');
    //------Ending Routine 'Estimation temps '-------
    //psychoJS.window.fullscr = true;
    intentionAI=intention;
    console.log('intentionAI UserChoiceEnd',intentionAI);
    //psychoJS.window.adjustScreenSize();
    if (intentionAI==0){
      continueRoutine=false;
      nRepsUserchoice=0;

    } else {
      nRepsUserchoice=1;
      if (!window.no_userc && !window.erroruserchoice){
        trialsUserchoice.finished=true;
        continueRoutine=false;
       
      } else {
        nRepsUserchoice+=1;
        trialsUserchoice.finished=false;
        continueRoutine=true;
        
      }      
    }
    for (const thisComponent of UserChoiceComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    no_userchoicetxt_AI.setAutoDraw(false);
    
    psychoJS.experiment.addData('User target choice', k_presdis_AI.keys);
    if (typeof k_presdis_AI.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('User target choice time:', k_presdis_AI.rt);
        routineTimer.reset();
        }
    
    psychoJS.experiment.addData('no_userchoicekp_AI.keys', no_userchoicekp_AI.keys);
    if (typeof no_userchoicekp_AI.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('no_userchoicekp_AI.rt', no_userchoicekp_AI.rt);
        routineTimer.reset();
        }
    
    k_presdis_AI.stop();
    no_userchoicekp_AI.stop();
    // the Routine "Trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}

let selectedMap;
let loca;
var CarMovementComponents;
var step_AI_strat;
let objectX;
let objectY;
let objectDist;
let scaleFactor;
let object_offset_x_proxi;
let object_offset_y_proxi;
let object_offset_x_dist;
let object_offset_y_dist;
let text_offset_x_proxi;
let text_offset_y_proxi;
let text_offset_x_dista;
let text_offset_y_dista;
let [obstacleAIPresence, obstaclePositionAI] = [0, 0];
var _preShot_allKeys;
var _car_allKeys_obstacle;
var _car_allKeys_final;
var x_car_AI;
var y_car_AI;
//var no_kp_avoidance_ob;
var feedback_stim;

function CarMovementBegin(snapshot) {
  

    return async function () {    
    //console.log('CarMovementBegin');

    TrialHandler.fromSnapshot(snapshot);
    t = 0;
    carMovementClock.reset(); // clock
    frameN = -1;
    continueRoutine=true;
    psychoJS.eventManager.clearEvents();
   // psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();

    x_car_AI=0;
    y_car_AI=0;
    my_car.setPos([x_car_AI, y_car_AI]);
    selectedMap=configmap;
    strategieAI=strategie;
    target_AI=target;
    intentionAI=intention;
    console.log('selectedMap CarMovementBegin: ',selectedMap);
    console.log('target_AI CarMovementBegin: ',target_AI);
    console.log('selectedMap CarMovementBegin: ',selectedMap);
    console.log('intentionAI CarMovementBegin',intentionAI);
    

    //console.log("selectedMap CarMovementBegin",selectedMap);
    //------Prepare to start Routine 'Son'-------
    
    nbOfTrialAI+=1;
    console.log('nbOfTrialAI:',nbOfTrialAI);
    
    if (intentionAI==0){

      function mapdisplay_AI(selectedMap, mapConfigs) {
        let positions = mapConfigs[selectedMap];
        //console.log('positions',positions);
        if (positions) {
          money_1.setPos(positions[0]);
          heart_1.setPos(positions[1]);
          money_2.setPos(positions[2]);
          heart_2.setPos(positions[3]);
        }
      }
      mapdisplay_AI(selectedMap, mapConfigs);
    }



    function movement_step(strategieAI) {
        return strategieAI === 1 ? 42 : 36;
    }

    function destination_finale_AI() {
      let mapstructConfigurations = {
          1: [3, 1, 2, 4],
          2: [1, 3, 4, 2],
          3: [3, 1, 4, 2],
          4: [1, 3, 2, 4],
          5: [3, 4, 1, 2],
          6: [1, 2, 3, 4]
      };
      
      let configmapValue = selectedMap;
      if (configmapValue in mapstructConfigurations) {
          let mapstruct = mapstructConfigurations[configmapValue];
          let loca = mapstruct.indexOf(target);
          return loca;
      }
    }
    
    loca = destination_finale_AI();
    console.log('loca:',loca);
    step_AI_strat=movement_step(strategieAI);
    obstacleAIPresence= obstacle;
    obstaclePositionAI=obstacle_position;

    scaleFactor = 100;
    if (condition_AI==2){
      text_offset_x_proxi = Math.round(winSize[0] / 25 * scaleFactor) / scaleFactor;
      text_offset_y_proxi = Math.round(winSize[1] / 25 * scaleFactor) / scaleFactor;
    } else if (condition_AI==3){
      text_offset_y_dista=Math.round(winSize[1] / 14 * scaleFactor) / scaleFactor;
    }else if (condition_AI==4){
      text_offset_x_proxi = Math.round(winSize[0] / 20 * scaleFactor) / scaleFactor;
      text_offset_y_proxi = Math.round(winSize[1] / 25 * scaleFactor) / scaleFactor;
      text_offset_y_dista=Math.round(winSize[1] / 14 * scaleFactor) / scaleFactor;
    }
  
    
    preShotKB.keys= undefined;
    preShotKB.rt=undefined;
    keypressobstacle.keys = undefined;
    keypressobstacle.rt=undefined;
    //
    arrival_keypress.keys = undefined;
    arrival_keypress.rt=undefined;
    _preShot_allKeys=[];
    _car_allKeys_obstacle=[];
    _car_allKeys_final=[];
    
    CarMovementComponents=[];
    CarMovementComponents.push(heart_1);
    CarMovementComponents.push(heart_2);
    CarMovementComponents.push(money_1);
    CarMovementComponents.push(money_2);
    CarMovementComponents.push(my_car);
    CarMovementComponents.push(txt_GO);
    CarMovementComponents.push(left);
    CarMovementComponents.push(right);
    CarMovementComponents.push(txt_c2_X);
    CarMovementComponents.push(money_3_X);
    CarMovementComponents.push(heart_3_X);
    CarMovementComponents.push(txt_c3_X);
    CarMovementComponents.push(preShotKB);
    //CarMovementComponents.push(preshotText);
    CarMovementComponents.push(keypressobstacle);
    CarMovementComponents.push(up);
    CarMovementComponents.push(down);
    CarMovementComponents.push(txt_c2_Y);
    CarMovementComponents.push(money_3_Y);
    CarMovementComponents.push(heart_3_Y);
    CarMovementComponents.push(txt_c3_Y);
    CarMovementComponents.push(arrival_keypress);
    
    //CarMovementComponents.push(error_kp_txt);
    
    for (const thisComponent of CarMovementComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}

//var s_correct ;
//var s_incorrect;


var frameRemains;
function CarMovementEachFrame() {
  let objectXDirection;
  let objectYDirection;
  let offsetMultiplierX;
  let offsetMultiplierY;
  let conditionSatisfied_x= false;
  let conditionSatisfied_y=false;
  let conditionSatisfied_obstacle= false;
  let conditionSatisfied_obstacle_avoided=false;
  let conditionSatisfied_obstacleEND= false;
  let conditionSatisfied_feedbackEND=false;
  //let error_kp=false;
  let keypressstrat=false;
  //let time_error_kp=0;
  let time_preshot_kp=0;
  let time_obstacle_disp=0;
  let time_obstacle_kp=0;
  let time_feedbackobsta_begin=0;
  let time_feedbackobsta_end=0;
  let preshotaffichage; ///// LALALAL
  let preShot;
  let keypressright= false;
  let keypressleft=false;
  let keypressup= false;
  let keypressdown= false;
  let x_pos_proxi;
  let y_pos_proxi;
  let x_pos_dista;
  let y_pos_dista;
  let timetest;
  let s_correct;
  let s_incorrect;
  let time_xmoveobstacle=0;
  let time_xmove=0;
  let time_ymoveobstacle=0;
  let time_ymove=0;
  let keycar_x='';
  let keycar_y='';
  let playSound;
  let time_test;
  let timeavantmoveX;
  let timeavantmoveX_BeforeOb;
  let time_before_ymove;
  let timetesty_carmove;
  let timetestx_carmove_avantobs;
  let timetestx_carmove_apresobs;
  let timetesty_carmove_avantobs;
  let timetesty_carmove_apresobs;
  let time_tota_y;

  
  return async function () {
    //------Loop for each frame of Routine 'Son'-------
    //console.log('CarMovementEachFrame');
    t = carMovementClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();

    if (nbOfTrialAI >= 107){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.continueRoutineTrialRoutineBegin:',continueRoutine);

    } else {
      trialsMain.finished=false;
      continueRoutine=true;
      
    }

    
    // update/draw components on each frame
    if (condition_AI == 2 && Number((Math.abs(x_car_AI)).toFixed(2)) < (winSize[0] / 2.5) && y_car_AI == 0) {
      if ((loca == 0 || loca == 2)) {
        setPositionsForCondition2X(left, -1);
      } else if ((loca == 1 || loca == 3)) {
        setPositionsForCondition2X(right, 1);
      }
    } else if (condition_AI == 3 && Number((Math.abs(x_car_AI)).toFixed(2)) < (winSize[0] / 2.5) && y_car_AI == 0) {
      setPositionsForCondition3X();
    } else if (condition_AI == 4 && Number((Math.abs(x_car_AI)).toFixed(2)) < (winSize[0] / 2.5) && y_car_AI == 0) {
      if ((loca == 0 || loca == 2)) {
        setPositionsForCondition4X(left, -1);
      } else if ((loca == 1 || loca == 3)) {
        setPositionsForCondition4X(right, 1);
      }
    }

    function setPositionsForCondition2X(objectXDirection, offsetMultiplierX) {
      objectX = objectXDirection;
      object_offset_x_proxi = offsetMultiplierX * Math.round(winSize[0] / 20 * scaleFactor) / scaleFactor;
      object_offset_y_proxi = 0;
      x_pos_proxi = x_car_AI + offsetMultiplierX * text_offset_x_proxi;
      y_pos_proxi = y_car_AI + text_offset_y_proxi;
      txt_c2_X.setPos([x_pos_proxi, y_pos_proxi]);
      objectX.setPos([x_car_AI + object_offset_x_proxi, y_car_AI + object_offset_y_proxi]);
      if (!preshotaffichage){
        txt_c2_X.setAutoDraw(true);
        objectX.setAutoDraw(true);

      }      
    }

    function setPositionsForCondition3X() {
      if (strategieAI == 1) {
        objectDist = heart_3_X;
      } else if (strategieAI == 2) {
        objectDist = money_3_X;
      }
      object_offset_x_dist = 0;
      object_offset_y_dist = Math.round(winSize[1] / 25 * scaleFactor) / scaleFactor;
      x_pos_dista = x_car_AI;
      y_pos_dista = y_car_AI + text_offset_y_dista;
      txt_c3_X.setPos([x_pos_dista, y_pos_dista]);
      objectDist.setPos([x_car_AI + object_offset_x_dist, y_car_AI + object_offset_y_dist]);
      if (!preshotaffichage){
        txt_c3_X.setAutoDraw(true);
        objectDist.setAutoDraw(true);

      }
      
    }

    function setPositionsForCondition4X(objectXDirection, offsetMultiplierX) {
      setPositionsForCondition2X(objectXDirection, offsetMultiplierX);
      setPositionsForCondition3X();
      
    }

    if ( loca ==1 || loca == 3) {
      keypressright= true;
      
    } else if (loca ==0 || loca == 2) {
      keypressleft=true;
      
    }
    
    if (t >= 0 && heart_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      heart_1.tStart = t;  // (not accounting for frame time here)
      heart_1.frameNStart = frameN;  // exact frame index
      heart_1.setAutoDraw(true);
    }
    if (t >= 0 && heart_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      heart_2.tStart = t;  // (not accounting for frame time here)
      heart_2.frameNStart = frameN;  // exact frame index
      heart_2.setAutoDraw(true);
    }
    if (t >= 0 && money_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      money_1.tStart = t;  // (not accounting for frame time here)
      money_1.frameNStart = frameN;  // exact frame index
      money_1.setAutoDraw(true);
    }
    if (t >= 0 && money_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      money_2.tStart = t;  // (not accounting for frame time here)
      money_2.frameNStart = frameN;  // exact frame index
      money_2.setAutoDraw(true);
    }
    if (t >= 0 && my_car.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      my_car.tStart = t;  // (not accounting for frame time here)
      my_car.frameNStart = frameN;  // exact frame index
      my_car.setAutoDraw(true);
    }

    if (t >= 0 && txt_GO.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      txt_GO.tStart = t;  // (not accounting for frame time here)
      txt_GO.frameNStart = frameN;  // exact frame index
      txt_GO.setAutoDraw(true);
      let timegodisplay=carMovementClock.getTime();
      //console.log('timegoDisplay:',timegodisplay);
    }

    
    if (t >= 0 && (condition_AI==2 || condition_AI==4) && txt_c2_X.status === PsychoJS.Status.NOT_STARTED) {
      //console.log('txt_c2_X');
      // keep track of start time/frame for later
      txt_c2_X.tStart = t;  // (not accounting for frame time here)
      txt_c2_X.frameNStart = frameN;  // exact frame index
      txt_c2_X.setAutoDraw(true);
    }

    if (t >= 0 && (condition_AI==2|| condition_AI==4) && objectX.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      ///console.log('objectX NOT_STARTED:',objectX);
      objectX.tStart = t;  // (not accounting for frame time here)
      objectX.frameNStart = frameN;  // exact frame index
      objectX.setAutoDraw(true);
    }

    if (t >= 0 && (condition_AI==3|| condition_AI==4) && txt_c3_X.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      //console.log('txt_c3_X ');
      txt_c3_X.tStart = t;  // (not accounting for frame time here)
      txt_c3_X.frameNStart = frameN;  // exact frame index
      txt_c3_X.setAutoDraw(true);
    }

    if (t >= 0 && (condition_AI==3|| condition_AI==4) && objectDist.status === PsychoJS.Status.NOT_STARTED) {
      //console.log('objectDist',objectDist);
      // keep track of start time/frame for later
      objectDist.tStart = t;  // (not accounting for frame time here)
      objectDist.frameNStart = frameN;  // exact frame index
      objectDist.setAutoDraw(true);
    }

    if (t >= 0.6  && txt_GO.status === PsychoJS.Status.STARTED) {
      txt_GO.setAutoDraw(false);
      let timegoFinDisplay=carMovementClock.getTime();
      //console.log('timegoFinDisplay:',timegoFinDisplay);
      //console.log("txt_GOfin");
    }

    
    function hideDrawablesBasedOnCondition_X() {
      if (((Number((Math.abs(x_car_AI)).toFixed(2)) === (winSize[0] / 5) )||conditionSatisfied_obstacle||conditionSatisfied_x) && condition_AI == 2) {
        objectX.setAutoDraw(false);
        txt_c2_X.setAutoDraw(false);
      } else if (((Number((Math.abs(x_car_AI)).toFixed(2)) === (winSize[0] / 5) )||conditionSatisfied_obstacle||conditionSatisfied_x) && condition_AI == 3) {
        objectDist.setAutoDraw(false);
        txt_c3_X.setAutoDraw(false);
      } else if (((Number((Math.abs(x_car_AI)).toFixed(2)) === (winSize[0] / 5) )||conditionSatisfied_obstacle||conditionSatisfied_x) && condition_AI == 4) {
        objectX.setAutoDraw(false);
        txt_c2_X.setAutoDraw(false);
        txt_c3_X.setAutoDraw(false);
        objectDist.setAutoDraw(false);
      }
    }


    function preshot_NoObstacle(){
      let preShotKeys = psychoJS.eventManager.getKeys({keyList:['space'],waitRelease: false});
      if ( (Number((Math.abs(y_car_AI)).toFixed(2)) != winSize[1] /2.5  ) && preShotKeys.length > 0 ) {
        time_preshot_kp=carMovementClock.getTime();
        preshotaffichage=true;        
        if (preshotaffichage) {
          for (const thisComponent of CarMovementComponents) {
            if (typeof thisComponent.setAutoDraw === 'function') {
              thisComponent.setAutoDraw(false);
            }
          }
          preshotText.setAutoDraw(true);
        }
      }else if ( preShotKeys.length <= 0) {
        preshotaffichage=false;
        window.preShot=false;

        
      }

    }

    function preshot_Obstacle(){
      let preShotKeys = psychoJS.eventManager.getKeys({keyList:['space'],waitRelease: false});
      if ( (!preshotaffichage && !conditionSatisfied_obstacle && preShotKeys.length > 0 && (Number((Math.abs(y_car_AI)).toFixed(2)) != winSize[1] /2.5  ))|| (!preshotaffichage && conditionSatisfied_obstacle && !conditionSatisfied_obstacle_avoided && conditionSatisfied_feedbackEND && preShotKeys.length > 0 && (Number((Math.abs(y_car_AI)).toFixed(2)) != winSize[1] /2.5  ) ) || (!preshotaffichage && conditionSatisfied_obstacle && conditionSatisfied_obstacle_avoided && conditionSatisfied_feedbackEND && preShotKeys.length > 1 && (Number((Math.abs(y_car_AI)).toFixed(2)) != winSize[1] /2.5 ) )) {
        time_preshot_kp=carMovementClock.getTime();
        preshotaffichage=true;      
        if (preshotaffichage) {
          for (const thisComponent of CarMovementComponents) {
            if (typeof thisComponent.setAutoDraw === 'function') {
              thisComponent.setAutoDraw(false);
            }
          }
          preshotText.setAutoDraw(true);
        }
      }else if ( preShotKeys.length <= 0) {
        preshotaffichage=false;
        window.preShot=false;
        
        
      }

    }

    


    function preshot_feedbakNoObstacle(){
      //console.log('preshotaffichage preshot_feedbakNoObstacle ',preshotaffichage);
      //console.log('window.preShot preshot_feedbakNoObstacle :',window.preShot);
      if (preshotaffichage && preShotKB.status === PsychoJS.Status.NOT_STARTED) {
            // keep track of start time/frame for later
        preShotKB.tStart = t;  // (not accounting for frame time here)
        preShotKB.frameNStart = frameN;  // exact frame index
  
        psychoJS.window.callOnFlip(function() { preShotKB.clock.reset(); });  // t=0 on next screen flip
        psychoJS.window.callOnFlip(function() { preShotKB.start(); }); // start on screen flip
        psychoJS.window.callOnFlip(function() { preShotKB.clearEvents(); });
      }

  
      if ( preshotaffichage &&  preShotKB.status === PsychoJS.Status.STARTED) {
        //console.log('preShotKB  started ');
        let keyyy = preShotKB.getKeys({keyList: ['return','enter','num_enter'],waitRelease: false});
        _preShot_allKeys=_preShot_allKeys.concat(keyyy);
        if (keyyy.length > 0) {
          preShotKB.keys = _preShot_allKeys[_preShot_allKeys.length-1].name;  // just the last key pressed
          preShotKB.rt = _preShot_allKeys[_preShot_allKeys.length-1].rt;
          window.preShot=true;
          continueRoutine=false;
          preshotText.setAutoDraw(false);
            
        }
      }

    }
      
    
// OBSTACLE X LEFT
    if  (t >= 0.6 && (obstacleAIPresence == 0 || (obstacleAIPresence == 1 && obstaclePositionAI == 2 )) && (Number((Math.abs(x_car_AI)).toFixed(2)) < (winSize[0] / 2.5) ) &&  (keypressright||keypressleft) && !preshotaffichage ){
      timeavantmoveX=carMovementClock.getTime();
      let dist_xmove;
      if (keypressright){
        dist_xmove = RIGHT / step_AI_strat;
        objectXDirection=right;
        offsetMultiplierX=1;
        
      }else if( keypressleft){
        dist_xmove = LEFT / step_AI_strat;
        objectXDirection=left;
        offsetMultiplierX=-1;
        
      }
      x_car_AI += dist_xmove;
      if ( condition_AI==2) {
        setPositionsForCondition2X(objectXDirection, offsetMultiplierX);
      }else if ( condition_AI==3) {
        setPositionsForCondition3X();
      }else if (condition_AI==4){
        setPositionsForCondition4X(objectXDirection, offsetMultiplierX);
      }
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
      preshot_NoObstacle();
    }
    preshot_feedbakNoObstacle();
      
    
    if (t >= 0.6 && obstacleAIPresence == 1 &&  obstaclePositionAI == 1 &&  (keypressright||keypressleft)  && Number((Math.abs(x_car_AI)).toFixed(2)) < (winSize[0] / 5 ) && !conditionSatisfied_obstacle &&!preshotaffichage ){
      timeavantmoveX_BeforeOb=carMovementClock.getTime();
      
      let dist_xmove;
      if (keypressright){
        dist_xmove = RIGHT / step_AI_strat;
        objectXDirection=right;
        offsetMultiplierX=1;
        //console.log("dist_xmove",dist_xmove);
        //console.log("objectXDirection",objectXDirection);
        //console.log("offsetMultiplierX",offsetMultiplierX);
      }else if( keypressleft){
        dist_xmove = LEFT / step_AI_strat;
        objectXDirection=left;
        offsetMultiplierX=-1;
        //console.log("dist_xmove",dist_xmove);
        //console.log("objectXDirection",objectXDirection);
        //console.log("offsetMultiplierX",offsetMultiplierX);
      }
      x_car_AI += dist_xmove;
      if ( condition_AI==2) {
        setPositionsForCondition2X(objectXDirection, offsetMultiplierX);
      }else if ( condition_AI==3) {
        setPositionsForCondition3X();
      }else if (condition_AI==4){
        setPositionsForCondition4X(objectXDirection, offsetMultiplierX);
      }
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
      preshot_Obstacle();
    }
    preshot_feedbakNoObstacle();

    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 1 && (keypressright||keypressleft) && (Number((Math.abs(x_car_AI)).toFixed(2)) === (winSize[0] / 5) ) && !conditionSatisfied_obstacle && !preshotaffichage) {
      time_obstacle_disp=carMovementClock.getTime();
      conditionSatisfied_obstacle = true;
      hideDrawablesBasedOnCondition_X();
      
      let [x1_obstacle_AI, y1_obstacle_AI] = obstaclePositionX[loca + 1];
      redLight.setPos([x1_obstacle_AI,y1_obstacle_AI]);
      redLight.setAutoDraw(true);
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
    
    }

    if (  (keypressright||keypressleft) && !preshotaffichage && t >=time_obstacle_disp && conditionSatisfied_obstacle && keypressobstacle.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      //console.log("OBSTACLE RIGHT ");
      //console.log('time obstacle NOT started :',t);
      
      keypressobstacle.tStart = t;  // (not accounting for frame time here)
      keypressobstacle.frameNStart = frameN;  // exact frame index

      psychoJS.window.callOnFlip(function() { keypressobstacle.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { keypressobstacle.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { keypressobstacle.clearEvents(); });
      keypressstrat=true;
      if (obstacleAIPresence == 1 &&  obstaclePositionAI == 1 ){
        hideDrawablesBasedOnCondition_X();

      }
      //hideDrawablesBasedOnCondition_X();
      //console.log("keypressstrat",keypressstrat);
    }


    if (  (keypressright||keypressleft) && !preshotaffichage && conditionSatisfied_obstacle &&  keypressobstacle.status === PsychoJS.Status.STARTED &&  keypressstrat ) {
      
      if (obstacleAIPresence == 1 &&  obstaclePositionAI == 1 ){
        hideDrawablesBasedOnCondition_X();

      }
      let keysob = keypressobstacle.getKeys({keyList: ['space'], waitRelease: false});
      _car_allKeys_obstacle = _car_allKeys_obstacle.concat(keysob);
      
      if (t <= time_obstacle_disp + 0.350 && conditionSatisfied_obstacle && !conditionSatisfied_obstacle_avoided && !conditionSatisfied_obstacleEND && keysob.length == 1 && !preshotaffichage ) {
        time_obstacle_kp=carMovementClock.getTime();
        keypressobstacle.keys = _car_allKeys_obstacle[_car_allKeys_obstacle.length-1].name;  // just the last key pressed
        keypressobstacle.rt = _car_allKeys_obstacle[_car_allKeys_obstacle.length-1].rt;
        redLight.setAutoDraw(false);
        window.s_correct = true;
        window.s_incorrect = false;
        conditionSatisfied_obstacle_avoided=true;
        conditionSatisfied_obstacleEND=true;
        
      
      } else if ((t >= time_obstacle_disp + 0.350 && conditionSatisfied_obstacle && !conditionSatisfied_obstacleEND && keysob.length >= 0 &!preshotaffichage)|| (t <= time_obstacle_disp + 0.350 && conditionSatisfied_obstacle && !conditionSatisfied_obstacleEND && keysob.length > 1 &&!preshotaffichage)) {
        time_obstacle_kp=carMovementClock.getTime();
        redLight.setAutoDraw(false);
        window.s_incorrect = true;
        window.s_correct = false;
        conditionSatisfied_obstacleEND=true;
        
      }
    }
    //time_obstacle_kp + 0.50
    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 1 &&  (keypressright||keypressleft) && t <=time_obstacle_kp + 0.50 && window.s_incorrect &&  conditionSatisfied_obstacleEND && keypressstrat &&  !conditionSatisfied_feedbackEND && !preshotaffichage) {
     
      let [x1_obstacle_AI,y1_obstacle_AI]=obstaclePositionX[loca+1];
      incorrect.setPos([x1_obstacle_AI,y1_obstacle_AI]);
      incorrect.setAutoDraw(true);
      time_feedbackobsta_begin=carMovementClock.getTime();
      
      
    } else if (obstacleAIPresence == 1 &&  obstaclePositionAI == 1 &&  (keypressright||keypressleft) && t >= time_obstacle_kp + 0.50 && window.s_incorrect && conditionSatisfied_obstacleEND && keypressstrat && !conditionSatisfied_feedbackEND && !preshotaffichage )  {
        //console.log('time_obstacle feedback fin :',t);
      conditionSatisfied_feedbackEND=true;
      time_feedbackobsta_end=carMovementClock.getTime();
  
    }
    //time_obstacle_kp + 0.50
    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 1 &&  (keypressright||keypressleft) && t <= time_obstacle_kp + 0.50 && window.s_correct&& conditionSatisfied_obstacleEND && keypressstrat && !conditionSatisfied_feedbackEND && !preshotaffichage ) {
      //console.log('time_obstacle feedback:',t);
      //console.log('loca obstacleAIPresence == 1 &&  obstaclePositionAI == 1 && CORRECT DISPLAY:',loca);
      let [x1_obstacle_AI,y1_obstacle_AI]=obstaclePositionX[loca+1];
      correct.setPos([x1_obstacle_AI,y1_obstacle_AI]);
      correct.setAutoDraw(true);
      time_feedbackobsta_begin=carMovementClock.getTime();
    } else if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 1 &&  (keypressright||keypressleft) && t >=time_obstacle_kp + 0.50 && window.s_correct && conditionSatisfied_obstacleEND && keypressstrat && !conditionSatisfied_feedbackEND && !preshotaffichage )  {
        //console.log('time_obstacle feedback fin :',t);
      conditionSatisfied_feedbackEND=true;
      time_feedbackobsta_end=carMovementClock.getTime();
      
    }

      
    if (obstacleAIPresence == 1 &&  obstaclePositionAI == 1 &&  (keypressright||keypressleft) && Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 5 )   && Number((Math.abs(x_car_AI)).toFixed(2)) < (winSize[0] / 2.5 ) && conditionSatisfied_obstacleEND && conditionSatisfied_feedbackEND && !preshotaffichage) {
      timetestx_carmove_apresobs=carMovementClock.getTime();
      psychoJS.experiment.addData("timetestx_carmove_apresobs obstacle X:",timetestx_carmove_apresobs);  


      let dist_xmove;
      if (keypressright){
        dist_xmove = RIGHT / step_AI_strat;
        objectXDirection=right;
        offsetMultiplierX=1;
        //console.log("dist_xmove",dist_xmove);
        //console.log("objectXDirection",objectXDirection);
        //console.log("offsetMultiplierX",offsetMultiplierX);
      }else if( keypressleft){
        dist_xmove = LEFT / step_AI_strat;
        objectXDirection=left;
        offsetMultiplierX=-1;
        //console.log("dist_xmove",dist_xmove);
        //console.log("objectXDirection",objectXDirection);
        //console.log("offsetMultiplierX",offsetMultiplierX);
      }
      x_car_AI += dist_xmove;
      if ( condition_AI==2) {
        setPositionsForCondition2X(objectXDirection, offsetMultiplierX);
      }else if ( condition_AI==3) {
        setPositionsForCondition3X();
      }else if (condition_AI==4){
        setPositionsForCondition4X(objectXDirection, offsetMultiplierX);
      }
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
      redLight.setAutoDraw(false);
      incorrect.setAutoDraw(false);
      correct.setAutoDraw(false);
      preshot_Obstacle();
    }
    preshot_feedbakNoObstacle();

    //(obstacleMotorPresence == 0 || (obstacleMotorPresence == 1 && obstaclePosition == 2 )) 
    if (Number((Math.abs(x_car_AI)).toFixed(2)) == (winSize[0] / 2.5) && !conditionSatisfied_x && !preshotaffichage) {
      time_xmove=carMovementClock.getTime();
      psychoJS.experiment.addData("time x arrival:",time_xmove);  
      conditionSatisfied_x=true;
      hideDrawablesBasedOnCondition_X();
      
    }


 // LAAAAAAAAAALA 
    if (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) && condition_AI==2 && conditionSatisfied_x && !preshotaffichage ) {
      //console.log('t:',t);
      
      if ((loca == 0 || loca==1 )){
        setPositionsForCondition2Y(up, 1);
      }else if (loca == 2 || loca==3 ){
        setPositionsForCondition2Y(down, -1);
      }
    }else if (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) && condition_AI==3 && conditionSatisfied_x && !preshotaffichage){
      setPositionsForCondition3Y();
    }else if ( Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) && condition_AI==4 && conditionSatisfied_x && !preshotaffichage){
      if ((loca == 0 || loca==1 )){
        setPositionsForCondition4Y(up, 1);
      }else if (loca == 2 || loca==3 ){
        setPositionsForCondition4Y(down, -1);
      }
    }
    function setPositionsForCondition2Y(objectYDirection, offsetMultiplierY) {
      objectY = objectYDirection;
      object_offset_y_proxi = offsetMultiplierY * Math.round(winSize[1] / 20 * scaleFactor) / scaleFactor;
      if (loca === 0 || loca === 2) {
        x_pos_proxi = x_car_AI + Math.round(winSize[0] / 22 * scaleFactor) / scaleFactor;
        
      }else {
        x_pos_proxi = x_car_AI - Math.round(winSize[0] / 22 * scaleFactor) / scaleFactor;
      }
      y_pos_proxi =  y_car_AI + offsetMultiplierY * Math.round(winSize[1] / 18 * scaleFactor) / scaleFactor;
      txt_c2_Y.setPos([x_pos_proxi, y_pos_proxi]);
      objectY.setPos([x_car_AI , y_car_AI + object_offset_y_proxi]);
      txt_c2_Y.setAutoDraw(true);
      objectY.setAutoDraw(true);
    }

    function setPositionsForCondition3Y() {
      if (strategieAI == 1) {
        objectDist = heart_3_Y;
      } else if (strategieAI == 2) {
        objectDist = money_3_Y;
      }
      text_offset_x_dista=Math.round(winSize[0] / 20 * scaleFactor) / scaleFactor;
      text_offset_y_dista=Math.round(winSize[1] / 35 * scaleFactor) / scaleFactor;
      if (loca === 0 || loca === 2) {
        x_pos_dista = x_car_AI + text_offset_x_dista;
        object_offset_x_dist=Math.round(winSize[0] / 20 * scaleFactor) / scaleFactor;
        object_offset_y_dist = 0;
      }else {
        x_pos_dista = x_car_AI - text_offset_x_dista;
        object_offset_x_dist=-Math.round(winSize[0] / 20 * scaleFactor) / scaleFactor;
        object_offset_y_dist = 0;
      }
      y_pos_dista= y_car_AI + text_offset_y_dista;
      txt_c3_Y.setPos([x_pos_dista, y_pos_dista]);
      objectDist.setPos([x_car_AI + object_offset_x_dist, y_car_AI + object_offset_y_dist]);
      txt_c3_Y.setAutoDraw(true);
      objectDist.setAutoDraw(true);
      //console.log("condition3Y");
    } 
    function setPositionsForCondition4Y(objectYDirection, offsetMultiplierY) {
      //console.log("objectY_4",objectY);
      setPositionsForCondition2Y(objectYDirection, offsetMultiplierY);
      setPositionsForCondition3Y();
      //console.log("condition4Y");
    }
    
    if (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5)&& (loca ==0 || loca == 1)&& !preshotaffichage) {
      keypressup = true;
      //console.log("keypressup",keypressup);
    } else if (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5)&& (loca ==2 || loca == 3)&& !preshotaffichage) {
      keypressdown=true;
     //console.log("keypressdown",keypressdown);
    }
     

    if ( conditionSatisfied_x && !preshotaffichage && (condition_AI==2 || condition_AI==4) && txt_c2_Y.status === PsychoJS.Status.NOT_STARTED ) {
      //console.log('txt_c2_Y :');
      // keep track of start time/frame for later
      txt_c2_Y.tStart = t;  // (not accounting for frame time here)
      txt_c2_Y.frameNStart = frameN;  // exact frame index
      txt_c2_Y.setAutoDraw(true);
    }

  
    if ( conditionSatisfied_x && !preshotaffichage && (condition_AI==2|| condition_AI==4)  && objectY.status === PsychoJS.Status.NOT_STARTED) {
      //console.log("objectY STARTED");
      objectY.tStart = t;  // (not accounting for frame time here)
      objectY.frameNStart = frameN;  // exact frame index
      // keep track of start time/frame for later
      objectY.setAutoDraw(true);
      //txt_display.setAutoDraw(true);
    }

    if (conditionSatisfied_x && !preshotaffichage && (condition_AI==3|| condition_AI==4) && txt_c3_Y.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      //console.log('txt_c3 :');
      //console.log('txt_c3_Y :');
      txt_c3_Y.tStart = t;  // (not accounting for frame time here)
      txt_c3_Y.frameNStart = frameN;  // exact frame index
      txt_c3_Y.setAutoDraw(true);
    }
    

    function hideDrawablesBasedOnCondition_Y() {
      if (conditionSatisfied_x && condition_AI == 2) {
        objectY.setAutoDraw(false);
        txt_c2_Y.setAutoDraw(false);
      } else if (conditionSatisfied_x && condition_AI == 3) {
        objectDist.setAutoDraw(false);
        txt_c3_Y.setAutoDraw(false);
      } else if (conditionSatisfied_x && condition_AI == 4) {
        objectY.setAutoDraw(false);
        txt_c2_Y.setAutoDraw(false);
        objectDist.setAutoDraw(false);
        txt_c3_Y.setAutoDraw(false);
      }
    }

    if (t >= time_xmove + 0.6   && !preshotaffichage && (obstacleAIPresence == 0 || (obstacleAIPresence == 1 && obstaclePositionAI == 1 )) && (keypressup||keypressdown) && (Number((Math.abs(y_car_AI)).toFixed(2)) < (winSize[1] / 2.5) ) && (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) ) ){
      time_before_ymove= carMovementClock.getTime();
      
      let dist_ymove;
      if (keypressup){
        dist_ymove = UP / step_AI_strat;
        objectYDirection=up;
        offsetMultiplierY=1;
        //console.log("dist_ymove",dist_ymove);
        ////console.log("objectYDirection",objectYDirection);
        //console.log("offsetMultiplierY",offsetMultiplierY);
      }else if( keypressdown){
        dist_ymove = DOWN / step_AI_strat;
        objectYDirection=down;
        offsetMultiplierY=-1;
        ///console.log("dist_ymove",dist_ymove);
        //console.log("objectYDirection",objectYDirection);
        //console.log("offsetMultiplierY",offsetMultiplierY);

      }
      //console.log("time_before_ymove:",time_before_ymove);
      y_car_AI += dist_ymove;
      if ( (condition_AI==2)) {
        setPositionsForCondition2Y(objectYDirection, offsetMultiplierY);
      
      }else if ((condition_AI==3)){
        setPositionsForCondition3Y();
      } else if (condition_AI==4){
        setPositionsForCondition4Y(objectYDirection, offsetMultiplierY);
      }
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
      preshot_NoObstacle();
    }
    preshot_feedbakNoObstacle();

  
    // OBSTACLE y en UP 

    if (t >= time_xmove + 0.6   && obstacleAIPresence == 1 &&  obstaclePositionAI == 2 && (keypressup||keypressdown)  &&  Number((Math.abs(y_car_AI)).toFixed(2)) < (winSize[1] / 5 )  && (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) ) && !conditionSatisfied_obstacle && !preshotaffichage  ) {
      timetesty_carmove_avantobs=carMovementClock.getTime();
     
      let dist_ymove;
      if (keypressup){
        dist_ymove = UP / step_AI_strat;
        objectYDirection=up;
        offsetMultiplierY=1;

      }else if( keypressdown){
        dist_ymove = DOWN / step_AI_strat;
        objectYDirection=down;
        offsetMultiplierY=-1;

      }
      //console.log("time_before_ymove:",time_before_ymove);
      y_car_AI += dist_ymove;
      if ( (condition_AI==2)) {
        setPositionsForCondition2Y(objectYDirection, offsetMultiplierY);
      
      }else if ((condition_AI==3)){
        setPositionsForCondition3Y();
      } else if (condition_AI==4){
        setPositionsForCondition4Y(objectYDirection, offsetMultiplierY);
      }
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
      preshot_Obstacle();
    }
    preshot_feedbakNoObstacle();

    
   
    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 2 &&(keypressup||keypressdown) && (Number((Math.abs(y_car_AI)).toFixed(2)) === (winSize[1] / 5) ) && (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) ) && !conditionSatisfied_obstacle && !preshotaffichage ) {
      time_obstacle_disp=carMovementClock.getTime();
      hideDrawablesBasedOnCondition_Y();
      conditionSatisfied_obstacle = true;
      let [x1_obstacle_AI, y1_obstacle_AI] = obstaclePositionY[loca+1];
      redLight.setPos ([x1_obstacle_AI,y1_obstacle_AI]);
      redLight.setAutoDraw(true);
      my_car.setAutoDraw(true);
        
    
    }
    if ( (keypressup||keypressdown)  && !preshotaffichage && t >=time_obstacle_disp && conditionSatisfied_obstacle && keypressobstacle.status === PsychoJS.Status.NOT_STARTED) {
     
      //console.log('time obstacle NOT started :',t);
      keypressobstacle.tStart = t;  // (not accounting for frame time here)
      keypressobstacle.frameNStart = frameN;  // exact frame index

      psychoJS.window.callOnFlip(function() { keypressobstacle.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { keypressobstacle.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { keypressobstacle.clearEvents(); });
      keypressstrat=true;
      if (obstacleAIPresence == 1 &&  obstaclePositionAI == 2 ){
        hideDrawablesBasedOnCondition_Y();
      }
      
    }

    if ( (keypressup||keypressdown)   && !preshotaffichage && conditionSatisfied_obstacle &&  keypressobstacle.status === PsychoJS.Status.STARTED &&  keypressstrat ) {     
      if (obstacleAIPresence == 1 &&  obstaclePositionAI == 2 ){
        hideDrawablesBasedOnCondition_Y();
      }
      
      let keysob = keypressobstacle.getKeys({keyList: ['space'], waitRelease: false});
      _car_allKeys_obstacle = _car_allKeys_obstacle.concat(keysob);
    
      if (t <= time_obstacle_disp +0.350 && conditionSatisfied_obstacle && !conditionSatisfied_obstacle_avoided && !conditionSatisfied_obstacleEND && keysob.length == 1 && !preshotaffichage  ) {
        time_obstacle_kp=carMovementClock.getTime();
        keypressobstacle.keys = _car_allKeys_obstacle[_car_allKeys_obstacle.length-1].name;  // just the last key pressed
        keypressobstacle.rt = _car_allKeys_obstacle[_car_allKeys_obstacle.length-1].rt;
        redLight.setAutoDraw(false);
        window.s_correct = true;
        window.s_incorrect = false;
        conditionSatisfied_obstacle_avoided=true;
        conditionSatisfied_obstacleEND=true;
          
        
      } else if ((t >= time_obstacle_disp + 0.350 && conditionSatisfied_obstacle && !conditionSatisfied_obstacleEND && keysob.length >= 0&& !preshotaffichage )|| (t <= time_obstacle_disp + 0.350 && conditionSatisfied_obstacle && !conditionSatisfied_obstacleEND && keysob.length > 1  && !preshotaffichage )) {
        time_obstacle_kp=carMovementClock.getTime();
        redLight.setAutoDraw(false);
        window.s_incorrect = true;
        window.s_correct = false;
        conditionSatisfied_obstacleEND=true;
  
      }
    }
   
    //time_obstacle_kp + 0.50 
    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 2 && (keypressup||keypressdown)  && t <= time_obstacle_kp + 0.50  && window.s_incorrect && conditionSatisfied_obstacleEND && keypressstrat &&!conditionSatisfied_feedbackEND && !preshotaffichage ) {
      //console.log('time_obstacle feedback incorecct:',t);
      my_car.setAutoDraw(false);
      let [x1_obstacle_AI,y1_obstacle_AI]=obstaclePositionY[loca+1];
      incorrect.setPos([x1_obstacle_AI,y1_obstacle_AI]);
      incorrect.setAutoDraw(true);
      time_feedbackobsta_begin=carMovementClock.getTime();
    } else if (obstacleAIPresence == 1 &&  obstaclePositionAI == 2 && (keypressup||keypressdown)  && t >=time_obstacle_kp + 0.50  && window.s_incorrect && conditionSatisfied_obstacleEND && keypressstrat && !conditionSatisfied_feedbackEND && !preshotaffichage )  {
      //console.log('time_obstacle feedback fin incorecct :',t);
      conditionSatisfied_feedbackEND=true;
      time_feedbackobsta_end=carMovementClock.getTime();
      
    }
    //time_obstacle_kp + 0.50 
    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 2 && (keypressup||keypressdown)  && t <=time_obstacle_kp + 0.50  && window.s_correct && conditionSatisfied_obstacleEND && keypressstrat && !conditionSatisfied_feedbackEND && !preshotaffichage ) {
      my_car.setAutoDraw(false);
      let [x1_obstacle_AI,y1_obstacle_AI]=obstaclePositionY[loca+1];
      correct.setPos([x1_obstacle_AI,y1_obstacle_AI]);
      correct.setAutoDraw(true);
      time_feedbackobsta_begin=carMovementClock.getTime();

    //time_obstacle_kp + 0.50 
    } else if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 2 && (keypressup||keypressdown)  && t >=time_obstacle_kp + 0.50  && window.s_correct && conditionSatisfied_obstacleEND && keypressstrat && !conditionSatisfied_feedbackEND && !preshotaffichage )  {
      //console.log('time_obstacle feedback fin corecct :',t);
      conditionSatisfied_feedbackEND=true;
      time_feedbackobsta_end=carMovementClock.getTime();
      
    }
          //console.log('conditionSatisfied_obstacleEND ',conditionSatisfied_obstacleEND);        
    if ( obstacleAIPresence == 1 &&  obstaclePositionAI == 2 && (keypressup||keypressdown)   && (Number((Math.abs(x_car_AI)).toFixed(2)) >= (winSize[0] / 2.5) ) && Number((Math.abs(y_car_AI)).toFixed(2)) >= (winSize[1] / 5) && Number((Math.abs(y_car_AI)).toFixed(2)) < (winSize[1] / 2.5) && conditionSatisfied_obstacleEND && conditionSatisfied_feedbackEND && !preshotaffichage  ) {
      timetesty_carmove_apresobs=carMovementClock.getTime();
    
      let dist_ymove;
      if (keypressup){
        dist_ymove = UP / step_AI_strat;
        objectYDirection=up;
        offsetMultiplierY=1;

      }else if( keypressdown){
        dist_ymove = DOWN / step_AI_strat;
        objectYDirection=down;
        offsetMultiplierY=-1;

      }
      //console.log("time_before_ymove:",time_before_ymove);
      y_car_AI += dist_ymove;
      if ( (condition_AI==2)) {
        setPositionsForCondition2Y(objectYDirection, offsetMultiplierY);
      
      }else if ((condition_AI==3)){
        setPositionsForCondition3Y();
      } else if (condition_AI==4){
        setPositionsForCondition4Y(objectYDirection, offsetMultiplierY);
      }
      my_car.setPos([x_car_AI, y_car_AI]);
      my_car.setAutoDraw(true);
      redLight.setAutoDraw(false);
      incorrect.setAutoDraw(false);
      correct.setAutoDraw(false);
      preshot_Obstacle();
    }
    preshot_feedbakNoObstacle();

     
    if (Number((Math.abs(y_car_AI)).toFixed(2)) === (winSize[1] / 2.5) && !conditionSatisfied_y && !preshotaffichage ) {
      time_ymove=carMovementClock.getTime();
      psychoJS.experiment.addData("time fin Y move:",time_ymove);
      hideDrawablesBasedOnCondition_Y();
      conditionSatisfied_y = true; 
      

    }

    if ( conditionSatisfied_y && !preshotaffichage  && t >= time_ymove && arrival_keypress.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      arrival_keypress.tStart = t;  // (not accounting for frame time here)
      //console.log('t arrival keypress pas encore started',t);
      arrival_keypress.frameNStart = frameN;  // exact frame index
     
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { arrival_keypress.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { arrival_keypress.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { arrival_keypress.clearEvents(); });

    }
    
    if ( t >= time_ymove && !preshotaffichage && arrival_keypress.status === PsychoJS.Status.STARTED ) {
      hideDrawablesBasedOnCondition_Y();
      let theseKeys = arrival_keypress.getKeys({keyList: ['space'], waitRelease: false});
      _car_allKeys_final = _car_allKeys_final.concat(theseKeys);
     
      if ( t <= time_ymove + 0.5 && conditionSatisfied_y && theseKeys.length > 0 ) {
        arrival_keypress.keys = _car_allKeys_final[_car_allKeys_final.length-1].name;  // just the last key pressed
        arrival_keypress.rt = _car_allKeys_final[_car_allKeys_final.length-1].rt;
        window.playSound=true;
        continueRoutine = false;
      }else if (t >= time_ymove + 0.5 && conditionSatisfied_y && theseKeys.length >= 0){
        let time_arrival_NOkp= carMovementClock.getTime();
        window.playSound=false;
        continueRoutine = false;

      }
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of CarMovementComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function CarMovementEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Estimation temps '-------
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    intentionAI=intention;
    console.log('intentionAI CarMovementEnd',intentionAI);

  
    if (intentionAI=0){
      nRepsUserchoice=0;
      console.log('nRepsUserchoice CarMovementEnd:',nRepsUserchoice);


    }else if (intentionAI==1){
      nRepsUserchoice=1;
      console.log('nRepsUserchoice CarMovementEnd:',nRepsUserchoice);
      
    }
    
    
    if(window.playSound && !window.preShot){ // && !window.preShot

      if (strategieAI==2){
        if (( obstacleAIPresence==0 )|| (obstacleAIPresence==1 && window.s_correct)){
          score_trial_AI += 4;
        }else if ((obstacleAIPresence==1 && window.s_incorrect)){
          score_trial_AI += 2;
          //console.log('score_trial_AI:',score_trial_AI);
        }
          //console.log('score_trial_mot:',score_trial_mot);
      }else if (strategieAI==1){

        if (( obstacleAIPresence==0 )|| (obstacleAIPresence==1 && window.s_correct)){
          score_trial_AI += 2.5;
          //console.log('score_trial_AI:',score_trial_AI);
        }else if ((obstacleAIPresence==1 && window.s_incorrect)){
          score_trial_AI += 0.5;
          //console.log('score_trial_AI:',score_trial_AI);
        }
      }
    }else if (!window.playSound ){
      if (( obstacleAIPresence==0 )|| (obstacleAIPresence==1 && window.s_correct)){
        score_trial_AI += 0;
        //console.log('score_trial_AI:',score_trial_AI);
      }else if ((obstacleAIPresence==1 && window.s_incorrect)){
        score_trial_AI -= 2;
        //console.log('score_trial_AI:',score_trial_AI);
      }
    }
    psychoJS.experiment.addData('nbOfTrialAI', nbOfTrialAI);
    psychoJS.experiment.addData('step_AI_strat',step_AI_strat);
    psychoJS.experiment.addData('window.preShot sans obstacle: ',window.preShot);
    psychoJS.experiment.addData("window.s_correct obstacle X:", window.s_correct);
    psychoJS.experiment.addData("window.s_incorrect obstacle X:", window.s_incorrect);
    psychoJS.experiment.addData("window.playSound:", window.playSound);

    psychoJS.experiment.addData("score_trial_AI:", score_trial_AI);
    //console.log('CarMovementEnd end');
    for (const thisComponent of CarMovementComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    redLight.setAutoDraw(false);
    incorrect.setAutoDraw(false);
    correct.setAutoDraw(false);

    psychoJS.experiment.addData('AI target choice:', loca);
    console.log('AI target choice:',loca);
    psychoJS.experiment.addData('preShotKB.keys', preShotKB.keys);
    if (typeof preShotKB.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('preShotKB.rt', preShotKB.rt);
        routineTimer.reset();
        }


    psychoJS.experiment.addData('keypressobstacle.keys', keypressobstacle.keys);
    if (typeof keypressobstacle.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('keypressobstacle.rt', keypressobstacle.rt);
        routineTimer.reset();
        }

    psychoJS.experiment.addData('arrival_keypress.keys', arrival_keypress.keys);
    if (typeof arrival_keypress.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('arrival_keypress.rt', arrival_keypress.rt);
        routineTimer.reset();
        }

    preShotKB.stop();
    keypressobstacle.stop();
    arrival_keypress.stop();

    // the Routine "Trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}

var soundTypeplay;
let delayIbAI;
var SonComponents;

function SonRoutineBegin(snapshot) {
  return async function () {    
    //console.log('SonRoutineBegin');
    //------Prepare to start Routine 'Son'-------
    TrialHandler.fromSnapshot(snapshot);
    t = 0;
    SonClock.reset(); // clock
    frameN = -1;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    
    if (nbOfTrialAI >= 104){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',continueRoutine);
    } else {
      trialsMain.finished=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',trialsloop.finished);
      if (window.playSound && !window.preShot ) { //&& !preShot //&&!window.preShot
        continueRoutine=true;

        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }else{
        continueRoutine=false;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }
    }

    
    let soundType;
    function sound_AI(soundType) {
        if (obstacleAIPresence === 1) {
          //console.log('obstacleAIPresence:', obstacleAIPresence);
          //console.log('s_incorrect:', window.s_incorrect);
          //console.log('s_correct:', window.s_correct);
          if (window.s_incorrect) {
            soundType = sound_bad;
            //console.log('soundTypebad:', soundType);   
          } else if (window.s_correct) {
            soundType = sound_good;
            //console.log('soundTypegood:', soundType);
          }
        }else {
          //console.log('obstacleAIPresence:', obstacleAIPresence);
          soundType = sound_neutral;
          //console.log('soundTypeneut:', soundType);
        }
        return soundType;  
      }

    
    if (window.playSound && !window.preShot) { // && !window.preShot
      delayIbAI = delay_IB;
      soundTypeplay=sound_AI(soundType);;
      
    }else{
      delayIbAI = delay_IB;
     // console.log('delayIbAI:', delayIbAI);  
      soundTypeplay=sound_neutral;
    }


    soundTypeplay.secs=0.2;
    soundTypeplay.setVolume(1.0);
    
    SonComponents = [];
    SonComponents.push(soundTypeplay);

    for (const thisComponent of SonComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}

var timefinsoundtypePlay;
function SonRoutineEachFrame() {
  return async function () {
    
    //console.log('SonRoutineEachFrame');
    t = SonClock.getTime();
    //console.log('time before s:', t);
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();

    
    if (nbOfTrialAI >= 104){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',continueRoutine);
    } else {
      trialsMain.finished=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',trialsloop.finished);
      if (window.playSound && !window.preShot) { //&& !preShot //&&!window.preShot
        continueRoutine=true;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }else{
        continueRoutine=false;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }
    }
    // && !window.preShot
    
    //console.log('frameN before s:', frameN);
    //window.playSound && !no_userc &&
    if ( window.playSound && !window.preShot && t >= (delayIbAI/1000) && soundTypeplay.status === PsychoJS.Status.NOT_STARTED) { //&& !preShot
      // keep track of start time/frame for later 
      soundTypeplay.tStart = t;  // (not accounting for frame time here)
      //console.log('soundTypeplay.tStart', soundTypeplay.tStart);
      soundTypeplay.frameNStart = frameN;  // exact frame index
      //console.log(' frameN time sound:', soundTypeplay.frameNStart);
      psychoJS.window.callOnFlip(function(){ soundTypeplay.play(); });  // screen flip
      soundTypeplay.status = PsychoJS.Status.STARTED;
      //console.log('sound playyy');
    }
    frameRemains = (delayIbAI/1000) + 0.2 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (soundTypeplay.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      if (0.2 > 0.5) {
        soundTypeplay.stop();  // stop the sound (if longer than duration)
        timefinsound_neutral=t;
        //console.log('timefinsound_neutral', timefinsound_neutral);
      }
      soundTypeplay.status = PsychoJS.Status.FINISHED;
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of SonComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function SonRoutineEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Son'-------
    
    //console.log('SonRoutineEnd');
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    psychoJS.experiment.addData("soundTypeplay:", soundTypeplay);
    for (const thisComponent of SonComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    soundTypeplay.stop(); 
    // the Routine "Son" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}

var estimation_allKeys;
var Estimation_tempsComponents;
function Estimation_tempsRoutineBegin(snapshot) {
  return async function () {    
    //console.log('Estimation_tempsRoutineBegin');
    TrialHandler.fromSnapshot(snapshot);
    //------Prepare to start Routine 'Son'-------

    t = 0;
    Estimation_tempsClock.reset(); // clock
    frameN = -1;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    
    if (nbOfTrialAI >= 104){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',continueRoutine);
    } else {
      trialsMain.finished=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',trialsloop.finished);
      if (window.playSound && !window.preShot ) { //&& !preShot //&&!window.preShot
        continueRoutine=true;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }else{
        continueRoutine=false;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }
    }

    
  //}
    
    lEndpoint_AI= - winSize[0]/5;
    rEndPoint_AI= winSize[0]/5;
    dist_AI=(rEndPoint_AI * 2) / (60 * 4);
    //console.log('dist_AI_2:', dist_AI); 

    // update component parameters for each repeat
    estimation_key_resp.keys = undefined;
    estimation_key_resp.rt=undefined;
    estimation_allKeys=[];
    Estimation_tempsComponents=[];
    Estimation_tempsComponents.push(estimation_txt);
    Estimation_tempsComponents.push(line_AI);
    Estimation_tempsComponents.push(estimation_key_resp);
    for (const thisComponent of Estimation_tempsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}

var estimIB = '';
function Estimation_tempsRoutineEachFrame() {
  return async function () {
    //------Loop for each frame of Routine 'Son'-------
    t = Estimation_tempsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)

    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    if (nbOfTrialAI >= 104){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',continueRoutine);
    } else {
      trialsMain.finished=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',trialsloop.finished);
      if (window.playSound && !window.preShot) { //&& !preShot //&&!window.preShot
        continueRoutine=true;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }else{
        continueRoutine=false;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }
    }
    
    // update/draw components on each frame
    // start/stop sound_1
    if (t >= 0 && estimation_txt.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      estimation_txt.tStart = t;  // (not accounting for frame time here)
      estimation_txt.frameNStart = frameN;  // exact frame index
      estimation_txt.setAutoDraw(true);
    }
    if (t >= 0 && line_AI.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      line_AI.tStart = t;  // (not accounting for frame time here)
      line_AI.frameNStart = frameN;  // exact frame index
      line_AI.setAutoDraw(true);
    }
    if (line_AI.status === PsychoJS.Status.STARTED && t<=4 ) {
      rEndPoint_AI -= dist_AI;
      //console.log('rEndPoint_AI:', rEndPoint_AI); 
      line_AI.setVertices([[lEndpoint_AI,(winSize[0] / 2) * 0.3], [rEndPoint_AI,(winSize[0] / 2) * 0.3]]);
      line_AI.setAutoDraw(true);
      //console.log('LINE DRAW');
    }
    if (t >= 0 && estimation_key_resp.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      estimation_key_resp.tStart = t;  // (not accounting for frame time here)
      estimation_key_resp.frameNStart = frameN;  // exact frame index
      //console.log('estimation key press');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { estimation_key_resp.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { estimation_key_resp.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { estimation_key_resp.clearEvents(); });
    }
    if (estimation_key_resp.status === PsychoJS.Status.STARTED) {
    
      let theseKeys = estimation_key_resp.getKeys({ keyList: ['0','1','2','3','4','5','6','7','8','9','0','num_0', 'num_1', 'num_2', 'num_3', 'num_4', 'num_5','num_6', 'num_7', 'num_8', 'num_9','backspace','return',''], waitRelease: false });

      // Uncomment the loop
      for (let i = 0; i < theseKeys.length; i++) {
        let key = theseKeys[i].name;
        estimation_allKeys.push(key); // Use push to add elements to the array
      }

      if (theseKeys.length > 0) {
        estimation_key_resp.keys = estimation_allKeys.join(""); // Join the array elements into a string
        estimation_key_resp.rt = theseKeys[0].rt; // Assuming you want the reaction time of the first key
        estimIB = estimation_key_resp.keys.replace("num_", "");
        //console.log('estimIB',estimIB);
  
      } else if (t >= 4 && theseKeys.length <= 0) {
        estimIB = '0';
        //console.log('estimIB',estimIB);
      }
    }
    if (t >= 4) {
      continueRoutine=false;
      //console.log('trialsloop.continueRoutine_Estimation_tempsRoutineEachFrame:',continueRoutine);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Estimation_tempsComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Estimation_tempsRoutineEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Estimation temps '-------
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    for (const thisComponent of Estimation_tempsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }

    psychoJS.experiment.addData('estimation_key_resp.keys', estimation_key_resp.keys);
    if (typeof estimation_key_resp.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('estimation_key_resp.rt', estimation_key_resp.rt);
        routineTimer.reset();
        }
    estimation_key_resp.stop();
    // the Routine "Trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}



var estimationSoA_allKeys;
var finestimation_allKeys;
var Estimation_SoA_Components;
function Estimation_SoARoutineBegin(snapshot) {
  return async function () {    
    
    //console.log('Estimation_SoARoutineBegin');
    TrialHandler.fromSnapshot(snapshot);
    //------Prepare to start Routine 'Son'-------

    t = 0;
    SoAClock.reset(); // clock
    frameN = -1;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    if (nbOfTrialAI >= 104){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',continueRoutine);
    } else {
      trialsMain.finished=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',trialsloop.finished);
      if (window.playSound && !window.preShot) { //&& !preShot //&&!window.preShot
        continueRoutine=true;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }else{
        continueRoutine=false;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }
    }
    
    
    // update component parameters for each repeat
    SoA_key_resp.keys = undefined;
    SoA_key_resp.rt=undefined;
    SoA_validation_key.keys = undefined;
    SoA_validation_key.rt=undefined;
    estimationSoA_allKeys=[];
    finestimation_allKeys=[];
    Estimation_SoA_Components=[];
    Estimation_SoA_Components.push(SoA_txt);
    Estimation_SoA_Components.push(SoA_key_resp);
    Estimation_SoA_Components.push(SoA_validation_key);
    for (const thisComponent of Estimation_SoA_Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}
var estimSoA = '';
function Estimation_SoARoutineEachFrame() {
  return async function () {
    //------Loop for each frame of Routine 'Son'-------
    t = SoAClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
  
    if (nbOfTrialAI >= 104){
      trialsMain.finished=true;
      //console.log('trialsloop.finishedTrialRoutineBegin:',trialsloop.finished);
      continueRoutine=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',continueRoutine);
    } else {
      trialsMain.finished=false;
      //console.log('trialsloop.FeedbackRoutineEachFrame:',trialsloop.finished);
      if (window.playSound && !window.preShot) { //&& !preShot // &&!window.preShot
        continueRoutine=true;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }else{
        continueRoutine=false;
        //console.log('FeedbackRoutineEachFrame:',continueRoutine);
      }
    }
    
    // update/draw components on each frame
    // start/stop sound_1
    if (t >= 0 && SoA_txt.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      SoA_txt.tStart = t;  // (not accounting for frame time here)
      SoA_txt.frameNStart = frameN;  // exact frame index
      SoA_txt.setAutoDraw(true);
    }
    
    if (t >= 0 && SoA_key_resp.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      SoA_key_resp.tStart = t;  // (not accounting for frame time here)
      SoA_key_resp.frameNStart = frameN;  // exact frame index
      //console.log('SoA_key_resp');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { SoA_key_resp.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { SoA_key_resp.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { SoA_key_resp.clearEvents(); });
    }

    if (SoA_key_resp.status === PsychoJS.Status.STARTED) {
      let theseKeys = SoA_key_resp.getKeys({keyList: ['0','1','2','3','4','5','6','7','8','9','num_0', 'num_1', 'num_2', 'num_3', 'num_4', 'num_5','num_6', 'num_7', 'num_8', 'num_9'],waitRelease: false});

      for (let i = 0; i < theseKeys.length; i++) {
        let key = theseKeys[i].name;
        estimationSoA_allKeys.push(key); // Use push to add elements to the array
        //console.log("estimationSoA_allKeys", estimationSoA_allKeys);
        //console.log("key", key);
      }

      if (theseKeys.length > 0) {
        SoA_key_resp.keys = estimationSoA_allKeys.join(""); // Join the array elements into a string
        SoA_key_resp.rt = theseKeys[0].rt; // Assuming you want the reaction time of the first key
        estimSoA = SoA_key_resp.keys.replace("num_", "");
        //console.log('estimSoA:',estimSoA);
        
      }else{
        estimSoA = '0';
        //console.log('estimSoA:',estimSoA);
        
      }
      
    }
    if (t >= 0 && SoA_validation_key.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      SoA_validation_key.tStart = t;  // (not accounting for frame time here)
      SoA_validation_key.frameNStart = frameN;  // exact frame index
      //console.log('SoA_validation_key');
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { SoA_validation_key.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { SoA_validation_key.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { SoA_validation_key.clearEvents(); });
    }

    if (SoA_validation_key.status === PsychoJS.Status.STARTED) {
      let theseKeys = SoA_validation_key.getKeys({keyList: ['return','enter','num_enter'],waitRelease: false});
      finestimation_allKeys = finestimation_allKeys.concat(theseKeys);
      if (theseKeys.length > 0) {
        SoA_validation_key.keys = finestimation_allKeys[finestimation_allKeys.length-1].name;  // just the last key pressed
        SoA_validation_key.rt = finestimation_allKeys[finestimation_allKeys.length-1].rt;
        continueRoutine=false;
      }
    }
  
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Estimation_SoA_Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function Estimation_SoARoutineEnd(snapshot) {
  return async function () {
    //------Ending Routine 'Estimation temps '-------
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    
    //console.log('Estimation_SoARoutineEnd');
    for (const thisComponent of Estimation_SoA_Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('SoA_key_resp.keys', SoA_key_resp.keys);
    if (typeof SoA_key_resp.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('SoA_key_resp.rt', SoA_key_resp.rt);
        routineTimer.reset();
        }
    

    psychoJS.experiment.addData('SoA_validation_key.keys', SoA_validation_key.keys);
    if (typeof SoA_validation_key.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('SoA_validation_key.rt', SoA_validation_key.rt);
        routineTimer.reset();
        }
    
    psychoJS.experiment.addData('estimSoA:',estimSoA);
    SoA_key_resp.stop();
    SoA_validation_key.stop();
    // the Routine "Trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}



var _key_feedback_allKeys;
var FeedbackComponents;
function FeedbackRoutineBegin(snapshot) {
  return async function () {
    
    //console.log('FeedbackRoutineBegin');
    
    TrialHandler.fromSnapshot(snapshot);

    t = 0;
    Feedback_tempsClock.reset(); // clock
    frameN = -1;
    psychoJS.eventManager.clearEvents();
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    //------Prepare to start Routine 'Consigne'-------
  
    continueRoutine=true;

    //console.log('nbOfTrialMotor',nbOfTrialMotor);
    window.psychoJS = psychoJS;
    window.util = util;
    window.feedback_text=feedback_text;
    // update component parameters for each repeat
    window.feedback_kp=feedback_kp;
    feedback_kp.keys = undefined;
    feedback_kp.rt = undefined;
    _key_feedback_allKeys = [];
    // keep track of which components have finished
    FeedbackComponents = [];
    FeedbackComponents.push(feedback_text);
    FeedbackComponents.push(feedback_kp);
    
    for (const thisComponent of FeedbackComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function FeedbackRoutineEachFrame() {
  return async function () {
    
    //console.log('FeedbackRoutineEachFrame');
    //------Loop for each frame of Routine 'Consigne'-------
    
    // get current time
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    if (trialsMain.thisN ==25 ||  trialsMain.thisN ==53 || trialsMain.thisN ==79  ){
      continueRoutine=true;
    } else {
      continueRoutine=false;
    }

    t = Feedback_tempsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // *Consigne_image* updates
    
    if (t >= 0.0 && feedback_text.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      feedback_text.tStart = t;  // (not accounting for frame time here)
      feedback_text.frameNStart = frameN;  // exact frame index
      feedback_text.setText(' Votre score est :' + score_trial_AI + '\n\n Appuyez sur la touche entrée pour passer à l\'essai suivant');
      feedback_text.setAutoDraw(true);
      //console.log('FEEDBACK TEXT DRAW:');
    }
    // *key_resp* updates
    if (t >= 0.0 && feedback_kp.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      feedback_kp.tStart = t;  // (not accounting for frame time here)
      feedback_kp.frameNStart = frameN;  // exact frame index
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { feedback_kp.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { feedback_kp.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { feedback_kp.clearEvents(); });
    }
    
    if (feedback_kp.status === PsychoJS.Status.STARTED) {
      let theseKeys = feedback_kp.getKeys({keyList: ['return','enter','num_enter'], waitRelease: false});
      _key_feedback_allKeys = _key_feedback_allKeys.concat(theseKeys);
      if (theseKeys.length > 0) {
        feedback_kp.keys = _key_feedback_allKeys[_key_feedback_allKeys.length-1].name;  // just the last key pressed
        feedback_kp.rt = _key_feedback_allKeys[_key_feedback_allKeys.length-1].rt;
        // a response ends the routine
        continueRoutine = false;
        //console.log('key press feedback');
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of FeedbackComponents) 
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}

function FeedbackRoutineEnd(snapshot) {
  return async function () {
    
    //console.log('FeedbackRoutineEnd');
    //------Ending Routine 'Consigne'-------
    //psychoJS.window.fullscr = true;
    //psychoJS.window.adjustScreenSize();
    for (const thisComponent of FeedbackComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
        //console.log('thisComponent',thisComponent);
      }
    }
    // update the trial handler
    
    psychoJS.experiment.addData('feedback_kp.keys', feedback_kp.keys);
    if (typeof feedback_kp.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('feedback_kp.rt', feedback_kp.rt);
        routineTimer.reset();
        }
    
    feedback_kp.stop();
    // the Routine "Consigne" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }

    return Scheduler.Event.NEXT;
  }
}





function trialsloopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      } else {
        psychoJS.experiment.nextEntry(snapshot);
      
      }
    return Scheduler.Event.NEXT;
    }
  };
}



function importConditions(currentLoop) {
  return async function () {
    psychoJS.importAttributes(currentLoop.getCurrentTrial());
    return Scheduler.Event.NEXT;
    };
}



async function quitPsychoJS(message, isCompleted) {
  // Check for and save orphaned data
  if (psychoJS.experiment.isEntryEmpty()) {
    psychoJS.experiment.nextEntry();
  }
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});
  
  return Scheduler.Event.QUIT;
}

