var next_spot = [];
next_spot[0] = 16;
next_spot[1] = 16;
next_spot[2] = 17;
next_spot[3] = 17;
next_spot[4] = 18;
next_spot[5] = 18;
next_spot[6] = 19;
next_spot[7] = 19;
next_spot[8] = 20;
next_spot[9] = 20;
next_spot[10] = 21;
next_spot[11] = 21;
next_spot[12] = 22;
next_spot[13] = 22;
next_spot[14] = 23;
next_spot[15] = 23;
next_spot[16] = 24;
next_spot[17] = 24;
next_spot[18] = 25;
next_spot[19] = 25;
next_spot[20] = 26;
next_spot[21] = 26;
next_spot[22] = 27;
next_spot[23] = 27;
next_spot[24] = 28;
next_spot[25] = 28;
next_spot[26] = 29;
next_spot[27] = 29;
next_spot[28] = 30;
next_spot[29] = 30;

$(document).ready(function(){

  // click handler for a pick that is populated (it's populated when it has the data-team attribute)
  $(".pick[data-team]").on("click.pick_made", function(){
      handle_spot_clicked($(this));
  });

});


function handle_spot_clicked($spot){
    // Get the team clicked
    var team_clicked =  $spot.attr('data-team');
    // Get the spot of the team clicked
    var spot_clicked = $spot.attr('data-spot');
    // The spot where the team should go
    var new_spot = next_spot[spot_clicked];
    // logo of the team clicked
    var logo_url = $spot.find(".team-logo img").prop('src');

    // ajax call
    //todo

    // update ui
    // add team as data attribute of new spot
    var $new_spot = $(".pick[data-spot='" + new_spot +"'], .champion-pick[data-spot='" + new_spot + "']");
    $new_spot.attr("data-team", team_clicked);
    $new_spot.find(".team-logo").html("<img src='" + logo_url + "'>");
    $new_spot.find(".team-name").html(team_clicked);

    // add click handler on new spot
    $new_spot.off("click.pick_made");
    $new_spot.on("click.pick_made", function(){
        handle_spot_clicked($(this));
    });
}