script "gambaru-4-fases"

AI division.
  let cohesion      =  0
  let alignment     =  0
  let dispersion    =  0
  let spacing       = 40
  let offensiveness =  1

Physics division.
  let gravity    = -100
  let velocity   =   20
  let cameraMass =   10

Track division.
  let intro = 3
  let menu = 20 in 200 seconds
  let gameover = 21 in 86 seconds
  let boss = 19 in 43 seconds
  let level = 14 in 68 seconds
  let levelcomplete = 49 in 19 seconds

Level division.

  level 1:
    let level = 22 in 100 seconds
    let arena = '.\Modelos\maze01.3DS'
    let movie = '.\media\default.wmv'
    let velocity   =   10
	
    let cohesion      =  1
    let alignment     =  1
    let dispersion    =  1
    let spacing       =  1
    let offensiveness =  10


    let scale = 0.2/0.2/0.2
    let loading = 'Algum tempo depois...'
    let sejiroText = 'Siga-me se for capaz, camera maldita!'

    add oni boss at -19/2/84 life 100    
    add sejiro at -6/2/-22 life 150
    let camera = -10/240/60

  level 2:
    let movie = '.\media\gambaru_4.wmv'

    let cohesion      =  1
    let alignment     =  1
    let dispersion    =  1
    let spacing       =  1
    let offensiveness =  10


    let level = 12 in 33 seconds
    let arena = '.\Modelos\sakoji.3DS'
    let scale = 1.5/1.5/1.5
    let loading = 'Algum tempo depois...'
    let sejiroText = 'A Lanterna me deu o poder de criar um exercito !'

    add mitsuake at -25.5/2/120 life 15
    add mitsuake at -29.5/2/100 life 15
    add mitsuake leader at -38.5/2/125 life 30
    add mitsuake boss at -21.5/2/125 life 120    
    add mitsuake at -20.5/2/100 life 30    
    add mitsuake at -19.5/2/120 life 15
    add mitsuake at -18.5/2/120 life 15
    add mitsuake at -17.5/2/100 life 15
    add mitsuake at -16.5/2/100 life 15
    add mitsuake at -14.5/2/100 life 15
    add mitsuake at -14.5/2/100 life 15


    add sejiro at -6/2/230 life 150
    add katsome at -18/2/245 life 15
    add katsome at -17/2/245 life 15
    add katsome at -16/2/245 life 15
    add katsome at -15/2/245 life 15
    add katsome at -14/2/245 life 15
    add katsome at -13/2/245 life 15
    add katsome at -12/2/245 life 15
    add katsome at -11/2/245 life 15
    add katsome at -10/2/245 life 15
    add katsome at -9/2/245 life 15


    let camera = -10/2/250


