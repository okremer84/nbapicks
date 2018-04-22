<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NBA Playoffs</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.js"></script>
    <script src="js/bracket.js"></script>
    <link rel="stylesheet" href="js/sidenav.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <script src="js/sidenav.min.js"></script>
    <script>user_email = "{{ user.email }}"; user_team_name = "{{ user.team_name }}"</script>
    <style>
        body {
            font-family: arial, helvetica, sans-serif;
            font-size: 12px;
        }

        .round {
            float: left;
        }

        .round.r-of-4 {

        }

        .round.r-of-2 {
            margin-top: 50px;
        }

        .bracket-game {
            max-width: 125px;
            margin: 10px 0;
        }

        .champion-pick{
            margin: 5px auto 15px;
            width: 110px;
            border: 1px solid #AAA;
            padding: 5px;
            background-color: #f5f5f5;
            vertical-align: middle;
        }

        .pick {
            min-width: 110px;
            border: 1px solid #AAA;
            padding: 5px;
            background-color: #f5f5f5;
            vertical-align: middle;
        }

        .pick.top {
            border-radius: 3px 3px 0 0;
            border-bottom: 0;
            height: 33px;
        }

        .pick.bot {
            border-radius: 0 0 3px 3px;
            height: 33px;
        }

        .pick .score {
            display: inline;
            float: right;
            border-left: 1px solid #AAA;
            padding-left: 10px;
            padding-right: 10px;
            background: #EEE;
        }

        .pick[data-team]:hover{
            cursor: pointer;
        }

        /*
        .pick.win {
          background-color: #B8F2B8;
        }
        .pick. {
          background-color: #F2B8B8;
        }
         */
        .connectors {
            float: left;
            min-width: 35px;
        }

        .connectors.r-of-2 .top-line {
            position: relative;
            top: 53px;
            width: 17px;
            border: 1px solid #AAA;
        }

        .connectors.r-of-2 .bottom-line {
            position: relative;
            top: 151px;
            width: 17px;
            border: 1px solid #AAA;
        }

        .connectors.r-of-2 .vert-line {
            position: relative;
            top: 49px;
            left: -16px;
            height: 102px;
            border-right: 2px solid #AAA;
        }

        .connectors.r-of-2 .next-line {
            position: relative;
            top: -3px;
            left: 17px;
            width: 17px;
            border: 1px solid #AAA;
        }

        .clear {
            clear: both;
        }

        .top-left {
            float: left;
        }

        .bottom-left {
            clear: both;
        }

        .right-side {
            float: left;
            display: table-cell;
        }

        .center {
            vertical-align: middle;
            display: table-cell;
            padding-top: 61px;
        }

        .left-side {
            display: table-cell;
            float: right;
        }

        .top-right .connectors.r-of-2 .bottom-line, .bottom-right .connectors.r-of-2 .bottom-line {
            left: 17px;
        }

        .top-right .connectors.r-of-2 .top-line, .bottom-right .connectors.r-of-2 .top-line {
            left: 17px;
        }

        .top-right .connectors.r-of-2 .next-line, .bottom-right .connectors.r-of-2 .next-line {
            left: 0px;
        }

        .center-row {
            display: inline-block;
            text-align: left;
        }

        .bracket-wrapper {
            display: table;
            width: 953px;
            margin: 0 auto;
        }

        .bracket-wrapper-row {
            display: table-row;
        }

        .center-top-left, .center-bottom-left {
            float: none;
            height: 0;
        }

        .center-top-left.connectors.r-of-2 .top-line {
            top: -48px;
            left: 0;
        }

        .center-top-left.connectors.r-of-2 .vert-line {
            position: relative;
            float: left;
            height: 59px;
            top: -50px;
            left: 17px;
        }

        .center-bottom-left.connectors.r-of-2 .bottom-line {
            top: 95px;
            left: 0;
        }

        .center-bottom-left.connectors.r-of-2 .vert-line {
            position: relative;
            float: left;
            height: 64px;
            top: 96px;
            left: 16px;
        }

        .center-top-right.connectors.r-of-2 .top-line {
            top: -157px;
            left: 17px;
        }

        .center-top-right.connectors.r-of-2 .vert-line {
            position: relative;
            float: left;
            height: 57px;
            top: -158px;
            left: 17px;
        }

        .center-bottom-right.connectors.r-of-2 .bottom-line {
            top: -12px;
            left: 52px;
        }

        .center-bottom-right.connectors.r-of-2 .vert-line {
            position: relative;
            float: left;
            height: 63px;
            top: -10px;
            left: 52px;
        }

        .team-logo {
            display: inline-block;
            vertical-align: middle;
            height: 30px;
            width: 30px;
        }

        .tiny-number {
            font-size: 10px;
            vertical-align: middle;
        }

        .team-name {
            vertical-align: middle;
            font-weight: bold;
            margin-left: 5px;
        }

        .team-logo img {
            height: 30px;
            width: 30px;
            margin: 0 5px;
        }

        .center-row-wrap {
            text-align: center;
        }

        .center-bottom-right, .center-top-right {
            float: right;
        }

        .hidden .team-logo, .hidden .tiny-number, .hidden .team-name {
            visibility: hidden;
        }

        .mid-line {
            display: inline-block;
            left: -3px;
            top: -24px;
            position: relative;
            border-bottom: 2px solid #AAA;
            width: 9px;
            margin-right: -7px;
        }

        .top-overlay img {
            max-width: 300px;
            margin: 0 auto;
            display: block;
        }

        .info-overlay {
            width: 953px;
            margin: 0 auto;
        }

        .left-text {
            display: inline-block;
            vertical-align: bottom;
            width: 29.5%;
            text-transform: uppercase;
        }

        .right-text {
            display: inline-block;
            vertical-align: bottom;
            text-align: right;
            text-transform: uppercase;
            width: 29.5%;
        }

        .center-text {
            display: inline-block;
            vertical-align: middle;
            width: 40%;
            text-align: center;
            top: 90px;
            margin-top: -70px;
            position: relative;
        }

        .your-team-name input {
            height: 10px;
            padding: 7px;
            margin-top: 10px;
            width: 140px;
        }

        .margin-auto {
            margin: 0 auto;
        }

        .info-overlay .center-text.bottom-text {
            top: -120px;
            margin-top: 0;
        }

        .info-overlay select {
            width: 140px;
            display: block;
            margin: 15px auto 0 auto;
            height: 30px;
        }

        a.toggle {
            color: #006bb7;
        }

        a.toggle:hover {
            color:#6fbef7
        }

        .sidenav-link-title.user_link {
            position: relative;
            top: -3px;
        }

        .win {
            color: #0c940c;
        }

        .lose {
            color: #c12a2a;
            text-decoration: line-through;
        }
        
        .game-score {
            float: right;
            position: relative;
            top: 10px;
            left: -5px;
        }
    </style>
</head>

<body>
{% include 'sidebar.tpl' %}
<a href="javascript:;" class="toggle" id="sidenav-toggle">
    <i class="material-icons">menu</i>
</a>
<div class="info-overlay">
    <div class="top-overlay">
        <div class="left-text">
            Western Conference
        </div>
        <div class="center-text">
            <img src="https://www.nbaplayoffpicks.com/images/nba_playoffs.png"/>
            <div class="your-team-name">
                <div class="margin-auto" id="team_name">
                    <strong>Your Team Name:</strong><br/>
                    <strong>{{ user.team_name }}</strong>
                </div>

            </div>
        </div>

        <div class="right-text">
            Eastern Conference
        </div>
    </div>
</div>
<div class="bracket-wrapper">
    <div class="bracket-wrapper-row">
        <div class="left-side">
            <div class="top-left">
                <div class="round r-of-4">
                    <div class="bracket-game">
                        <div class="pick top" data-team="HOU" data-spot="0">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Houston_Rockets.png"/>
                            </div>
                            <span class="team-name">
								 HOU
							</span>
                            <span class="game-score" id="score_spot_0">{% if series_score[0] is not empty %}{{ series_score[0] }}{% endif %}</span>

                        </div>
                        <div class="pick bot " data-team="MIN" data-spot="1">
						  <span class="tiny-number">
								[8]
							</span>
                            <div class="team-logo">
                                <img src="images/Minnesota_Timberwolves.png"/>
                            </div>
                            <span class="team-name">
								 MIN
							</span>
                            <span class="game-score" id="score_spot_1">{% if series_score[1] != '0' %}{{ series_score[1] }}{% endif %}</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top " data-team="OKC" data-spot="2">
						  	<span class="tiny-number">
								[4]
							</span>
                            <div class="team-logo">
                                <img src="images/Oklahoma_City_Thunder.png"/>
                            </div>
                            <span class="team-name">
								 OKC
							</span>
                            <span class="game-score" id="score_spot_2">{% if series_score[2] != '0' %}{{ series_score[2] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-team="UTA" data-spot="3">
						  	<span class="tiny-number">
								[5]
							</span>
                            <div class="team-logo">
                                <img src="images/Utah_Jazz.png"/>
                            </div>
                            <span class="team-name">
								 UTA
							</span>
                            <span class="game-score" id="score_spot_3">{% if series_score[3] != '0' %}{{ series_score[3] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
                <div class="connectors r-of-2">
                    <div class="top-line"></div>
                    <div class="clear"></div>
                    <div class="bottom-line"></div>
                    <div class="clear"></div>
                    <div class="vert-line"></div>
                    <div class="clear"></div>
                    <div class="next-line"></div>
                    <div class="clear"></div>
                </div>
                <div class="round r-of-2">
                    <div class="bracket-game">
                        <div class="pick top " data-spot="16">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_16">{% if series_score[16] is not empty %}{{ series_score[16] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="17">
							<span class="tiny-number">
                            </span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_17">{% if series_score[17] is not empty %}{{ series_score[17] }}{% endif %}</span>

                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom-left">
                <div class="round r-of-4">
                    <div class="bracket-game">
                        <div class="pick top" data-team="POR" data-spot="4">
						  <span class="tiny-number">
								[3]
							</span>
                            <div class="team-logo">
                                <img src="images/Portland_Trail_Blazers.png"/>
                            </div>
                            <span class="team-name">
								 POR
							</span>
                            <span class="game-score" id="score_spot_4">{% if series_score[4] is not empty %}{{ series_score[4] }}{% endif %}</span>
                        </div>
                        <div class="pick bot " data-team="NOP" data-spot="5">
						  <span class="tiny-number">
								[6]
							</span>
                            <div class="team-logo">
                                <img src="images/New_Orleans_Pelicans.png"/>
                            </div>
                            <span class="team-name">
								 NOP
							</span>
                            <span class="game-score" id="score_spot_5">{% if series_score[5] is not empty %}{{ series_score[5] }}{% endif %}</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top " data-team="GSW" data-spot="6">
						  	<span class="tiny-number">
								[2]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
                            <span class="game-score" id="score_spot_6">{% if series_score[6] is not empty %}{{ series_score[6] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-team="SAS" data-spot="7">
						  	<span class="tiny-number">
								[7]
							</span>
                            <div class="team-logo">
                                <img src="images/San_Antonio_Spurs.png"/>
                            </div>
                            <span class="team-name">
								 SAS
							</span>
                            <span class="game-score" id="score_spot_7">{% if series_score[7] is not empty %}{{ series_score[7] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
                <div class="connectors r-of-2">
                    <div class="top-line"></div>
                    <div class="clear"></div>
                    <div class="bottom-line"></div>
                    <div class="clear"></div>
                    <div class="vert-line"></div>
                    <div class="clear"></div>
                    <div class="next-line"></div>
                    <div class="clear"></div>
                </div>
                <div class="round r-of-2">
                    <div class="bracket-game">
                        <div class="pick top " data-spot="18">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_18">{% if series_score[18] is not empty %}{{ series_score[18] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="19">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_19">{% if series_score[19] is not empty %}{{ series_score[19] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="center">
            <div class="connectors r-of-2 center-top-left">
                <div class="top-line"></div>
                <div class="clear"></div>
                <div class="vert-line"></div>
                <div class="clear"></div>
            </div>
            <div class="connectors r-of-2 center-bottom-left">
                <div class="vert-line"></div>
                <div class="clear"></div>
                <div class="bottom-line"></div>
                <div class="clear"></div>
            </div>
            <div class="center-row-wrap">
                <div class="bracket-game center-row">
                    <div class="pick top" data-spot="24">
						<span class="tiny-number">
						</span>
                        <div class="team-logo">
                        </div>
                        <span class="team-name">
						</span>
                        <span class="game-score" id="score_spot_24">{% if series_score[24] is not empty %}{{ series_score[24] }}{% endif %}</span>
                    </div>
                    <div class="pick bot " data-spot="25">
						<span class="tiny-number">
						</span>
                        <div class="team-logo">
                        </div>
                        <span class="team-name">
						</span>
                        <span class="game-score" id="score_spot_25">{% if series_score[25] is not empty %}{{ series_score[25] }}{% endif %}</span>
                    </div>
                </div>
                <div class="mid-line">
                    <div class="bottom-line"></div>
                </div>
                <div class="bracket-game center-row">
                    <div class="pick top" data-spot="28">
						<span class="tiny-number">
						</span>
                        <div class="team-logo">
                        </div>
                        <span class="team-name">
						</span>
                        <span class="game-score" id="score_spot_28">{% if series_score[28] is not empty %}{{ series_score[28] }}{% endif %}</span>
                    </div>
                    <div class="pick bot " data-spot="29">
						<span class="tiny-number">
						</span>
                        <div class="team-logo">
                        </div>
                        <span class="team-name">
						</span>
                        <span class="game-score" id="score_spot_29">{% if series_score[29] is not empty %}{{ series_score[29] }}{% endif %}</span>
                    </div>
                </div>
                <div class="mid-line">
                    <div class="bottom-line"></div>
                </div>
                <div class="bracket-game center-row">
                    <div class="pick top" data-spot="26">
						<span class="tiny-number">
						</span>
                        <div class="team-logo">
                        </div>
                        <span class="team-name">
						</span>
                        <span class="game-score" id="score_spot_26">{% if series_score[26] is not empty %}{{ series_score[26] }}{% endif %}</span>
                    </div>
                    <div class="pick bot " data-spot="27">
						<span class="tiny-number">
						</span>
                        <div class="team-logo">
                        </div>
                        <span class="team-name">
						</span>
                        <span class="game-score" id="score_spot_27">{% if series_score[27] is not empty %}{{ series_score[27] }}{% endif %}</span>
                    </div>
                </div>
            </div>


            <div class="connectors r-of-2 center-top-right">
                <div class="top-line"></div>
                <div class="clear"></div>
                <div class="vert-line"></div>
                <div class="clear"></div>
            </div>
            <div class="connectors r-of-2 center-bottom-right">
                <div class="vert-line"></div>
                <div class="clear"></div>
                <div class="bottom-line"></div>
                <div class="clear"></div>
            </div>

        </div>
        <div class="right-side">
            <div class="top-right">
                <div class="round r-of-2">
                    <div class="bracket-game">
                        <div class="pick top " data-spot="20">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_20">{% if series_score[20] is not empty %}{{ series_score[20] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="21">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_21">{% if series_score[21] is not empty %}{{ series_score[21] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
                <div class="connectors r-of-2">
                    <div class="top-line"></div>
                    <div class="clear"></div>
                    <div class="bottom-line"></div>
                    <div class="clear"></div>
                    <div class="vert-line"></div>
                    <div class="clear"></div>
                    <div class="next-line"></div>
                    <div class="clear"></div>
                </div>
                <div class="round r-of-4">
                    <div class="bracket-game">
                        <div class="pick top " data-spot="8" data-team="TOR">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Toronto_Raptors.png"/>
                            </div>
                            <span class="team-name">
								 TOR
							</span>
                            <span class="game-score" id="score_spot_8">{% if series_score[8] is not empty %}{{ series_score[8] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="9" data-team="WAS">
							<span class="tiny-number">
								[8]
							</span>
                            <div class="team-logo">
                                <img src="images/Washington_Wizards.png"/>
                            </div>
                            <span class="team-name">
								 WAS
							</span>
                            <span class="game-score" id="score_spot_9">{% if series_score[9] is not empty %}{{ series_score[9] }}{% endif %}</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top " data-spot="10" data-team="CLE">
					  	<span class="tiny-number">
							[4]
						</span>
                            <div class="team-logo">
                                <img src="images/Cleveland_Cavaliers.png"/>
                            </div>
                            <span class="team-name">
							 CLE
						</span>
                            <span class="game-score" id="score_spot_10">{% if series_score[10] is not empty %}{{ series_score[10] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="11" data-team="IND">
					  	<span class="tiny-number">
							[5]
						</span>
                            <div class="team-logo">
                                <img src="images/Indiana_Pacers.png"/>
                            </div>
                            <span class="team-name">
							 IND
						</span>
                            <span class="game-score" id="score_spot_11">{% if series_score[11] is not empty %}{{ series_score[11] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom-right">
                <div class="round r-of-2">
                    <div class="bracket-game">
                        <div class="pick top " data-spot="22">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_22">{% if series_score[22] is not empty %}{{ series_score[22] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="23">
							<span class="tiny-number">
							</span>
                            <div class="team-logo">
                            </div>
                            <span class="team-name">
							</span>
                            <span class="game-score" id="score_spot_23">{% if series_score[23] is not empty %}{{ series_score[23] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
                <div class="connectors r-of-2">
                    <div class="top-line"></div>
                    <div class="clear"></div>
                    <div class="bottom-line"></div>
                    <div class="clear"></div>
                    <div class="vert-line"></div>
                    <div class="clear"></div>
                    <div class="next-line"></div>
                    <div class="clear"></div>
                </div>
                <div class="round r-of-4">
                    <div class="bracket-game">
                        <div class="pick top" data-spot="12" data-team="PHI">
						  <span class="tiny-number">
								[3]
							</span>
                            <div class="team-logo">
                                <img src="images/Philadelphia_76ers.png"/>
                            </div>
                            <span class="team-name">
								 PHI
							</span>
                            <span class="game-score" id="score_spot_12">{% if series_score[12] is not empty %}{{ series_score[12] }}{% endif %}</span>
                        </div>
                        <div class="pick bot " data-spot="13" data-team="MIA">
						  <span class="tiny-number">
								[6]
							</span>
                            <div class="team-logo">
                                <img src="images/Miami_Heat.png"/>
                            </div>
                            <span class="team-name">
								 MIA
							</span>
                            <span class="game-score" id="score_spot_13">{% if series_score[13] is not empty %}{{ series_score[13] }}{% endif %}</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top " data-spot="14" data-team="BOS">
					  	<span class="tiny-number">
							[2]
						</span>
                            <div class="team-logo">
                                <img src="images/Boston_Celtics.png"/>
                            </div>
                            <span class="team-name">
							 BOS
						</span>
                            <span class="game-score" id="score_spot_14">{% if series_score[14] is not empty %}{{ series_score[14] }}{% endif %}</span>
                        </div>
                        <div class="pick bot" data-spot="15" data-team="MIL">
					  	<span class="tiny-number">
							[7]
						</span>
                            <div class="team-logo">
                                <img src="images/Milwaukee_Bucks.png"/>
                            </div>
                            <span class="team-name">
							 MIL
						</span>
                            <span class="game-score" id="score_spot_15">{% if series_score[15] is not empty %}{{ series_score[15] }}{% endif %}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="info-overlay">
    <div class="left-text">
    </div>
    <div class="center-text bottom-text">
        <div class="your-team-name">
            <div class="margin-auto">
                <strong>Finals Winner</strong><br/>
                <div class="champion-pick" data-spot="30" data-team="BOS">
                    <span class="tiny-number">
                    </span>
                    <div class="team-logo">
                    </div>
                    <span class="team-name">
                    </span>
                    <span class="game-score" id="score_spot_30">{% if series_score[30] is not empty %}{{ series_score[30] }}{% endif %}</span>
                </div>
                <strong>Finals MVP</strong><br/>
                <select id="mvp_dropdown" disabled onchange="send_mvp(); return false;">
                    <option disabled selected>Choose finals MVP</option>
                </select>
            </div>

        </div>
    </div>
    <div class="right-text">
    </div>
</div>



</body>
</html>