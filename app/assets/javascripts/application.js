// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function() {

metal = ["deathmetal","darkdevil","satan","satanic","666","hell","demon","demons","satanicsymbols","sataniccross","satanicbible","satanicpentagram","fire","flames","onfire","houseonfire","stvitusbrooklyn"];

// var country = [
// "farm",
// "barn",
// "oldpickuptruck",
// "acousticguitar",
// "strawhatfarmer",
// "farmerwearingoveralls",
// "clouds",
// "cowboyboots",
// "cowboyhat",
// "cowboyspurs",
// "brokenheart",
// "countryroad",
// "fiddle",
// "harmonica",
// "honkytonkbar"
// "countrybar"
// ];



// var edm = [
// "ravekandi",
// "furryraveboots",
// "plurkandi",
// "ravers",
// "glowsticks",
// "cdjs",
// "clubdjbooth",
// "electricforestfestival",
// "ibizaclubs",
// "gogodancer",
// "electricdaisycarnivaldancers",
// "ultramusicfestivaloutfits",
// "ultramusicfestivalstage"
// ];

// var hiphop = [
// "goldchain",
// "fancycar",
// "cigar",
// "breakdancer",
// "turntables",
// "microphone",
// "money",
// "bronx",
// "graffiti",
// "10subwoofer",
// "carsoundsystem",
// "escalade",
// "hummerlimo"
// ];



// var classical = [
// "flutes",
// "oboes",
// "clarinets",
// "bassoons",
// "frenchhorns",
// "trumpets",
// "violins",
// "violas",
// "cellos",
// "bassclarinets",
// "snaredrum",
// "bassdrum",
// "cymbals",
// "triangle",
// "tambourine",
// "piccolo",
// "harps",
// "piano",
// "cello",
// "xylophone",
// "orchestra",
// "newyorkphilharmonic"
// ];

    play_status = false;
    var url_front = 'http://';
    //var images = ['house', 'car'];
    var url_back = '.jpg.to';

    var audioSection = $('section#audio');
    $('a.html5').click(function() {
 
        var audio = $('<audio>', {
             controls : 'controls'
        });
 
        var url = $(this).attr('href');
        $('<source>').attr('src', url).appendTo(audio);
        audioSection.html(audio);
        return false;
    });

    $('section#audio').on("click", function(){
        if(play_status == false){


            i = 0;
            length = metal.length;
            var delay = 2000;
            var tid = setInterval(function() {
            $(".music-video-container").empty();        
            $(".music-video-container").append("<img src=" + url_front + metal[(length + i) % length] + url_back + " style='max-width:400px;'>");
            //console.log((length + i) % length);
            i += 1;
        
            }, delay);
        }
        else{
        clearInterval(tid);
        play_status = false;
        }
        
    })
});