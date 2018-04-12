<!DOCTYPE html>
<html>
<head>
    <title>NBA Playoffs</title>
    <script src="js/bracket.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.js"></script>
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

        /*
        .pick.win {
          background-color: #B8F2B8;
        }
        .pick.loss {
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
        }

        .tiny-number {
            font-size: 10px;
            vertical-align: middle;
        }

        .team-name {
            vertical-align: middle;
            font-weight: bold;
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
    </style>
</head>

<body>
<div class="info-overlay">
    <div class="top-overlay">
        <div class="left-text">
            Western Conference
        </div>
        <div class="center-text">
            <img src="https://www.nbaplayoffpicks.com/images/nba_playoffs.png"/>
            <div class="your-team-name">
                <div class="margin-auto">
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
                        <div class="pick top win" data-team="HOU" data-spot="0">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Houston_Rockets.png"/>
                            </div>
                            <span class="team-name">
								 HOU
							</span>

                        </div>
                        <div class="pick bot loss" data-team="MIN" data-spot="1">
						  <span class="tiny-number">
								[8]
							</span>
                            <div class="team-logo">
                                <img src="images/Minnesota_Timberwolves.png"/>
                            </div>
                            <span class="team-name">
								 MIN
							</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top loss" data-team="OKC" data-spot="2">
						  	<span class="tiny-number">
								[4]
							</span>
                            <div class="team-logo">
                                <img src="images/Oklahoma_City_Thunder.png"/>
                            </div>
                            <span class="team-name">
								 OKC
							</span>
                        </div>
                        <div class="pick bot win" data-team="UTA" data-spot="3">
						  	<span class="tiny-number">
								[5]
							</span>
                            <div class="team-logo">
                                <img src="images/Utah_Jazz.png"/>
                            </div>
                            <span class="team-name">
								 UTA
							</span>
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
                        <div class="pick top loss hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
                        </div>
                        <div class="pick bot win hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>

                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom-left">
                <div class="round r-of-4">
                    <div class="bracket-game">
                        <div class="pick top win" data-team="POR" data-spot="4">
						  <span class="tiny-number">
								[3]
							</span>
                            <div class="team-logo">
                                <img src="images/Portland_Trail_Blazers.png"/>
                            </div>
                            <span class="team-name">
								 POR
							</span>
                        </div>
                        <div class="pick bot loss" data-team="NOP" data-spot="5">
						  <span class="tiny-number">
								[6]
							</span>
                            <div class="team-logo">
                                <img src="images/New_Orleans_Pelicans.png"/>
                            </div>
                            <span class="team-name">
								 NOP
							</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top loss" data-team="GSW" data-spot="6">
						  	<span class="tiny-number">
								[2]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
                        </div>
                        <div class="pick bot win" data-team="SAS" data-spot="7">
						  	<span class="tiny-number">
								[7]
							</span>
                            <div class="team-logo">
                                <img src="images/San_Antonio_Spurs.png"/>
                            </div>
                            <span class="team-name">
								 SAS
							</span>
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
                        <div class="pick top loss hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
                        </div>
                        <div class="pick bot win hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
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
                    <div class="pick top win hidden">
						<span class="tiny-number">
							[1]
						</span>
                        <div class="team-logo">
                            <img src="images/Golden_State_Warriors.png"/>
                        </div>
                        <span class="team-name">
							 GSW
						</span>
                    </div>
                    <div class="pick bot loss hidden">
						<span class="tiny-number">
							[1]
						</span>
                        <div class="team-logo">
                            <img src="images/Golden_State_Warriors.png"/>
                        </div>
                        <span class="team-name">
							 GSW
						</span>
                    </div>
                </div>
                <div class="mid-line">
                    <div class="bottom-line"></div>
                </div>
                <div class="bracket-game center-row">
                    <div class="pick top win hidden">
						<span class="tiny-number">
							[1]
						</span>
                        <div class="team-logo">
                            <img src="images/Golden_State_Warriors.png"/>
                        </div>
                        <span class="team-name">
							 GSW
						</span>
                    </div>
                    <div class="pick bot loss hidden">
						<span class="tiny-number">
							[1]
						</span>
                        <div class="team-logo">
                            <img src="images/Golden_State_Warriors.png"/>
                        </div>
                        <span class="team-name">
							 GSW
						</span>
                    </div>
                </div>
                <div class="mid-line">
                    <div class="bottom-line"></div>
                </div>
                <div class="bracket-game center-row">
                    <div class="pick top win hidden">
						<span class="tiny-number">
							[1]
						</span>
                        <div class="team-logo">
                            <img src="images/Golden_State_Warriors.png"/>
                        </div>
                        <span class="team-name">
							 GSW
						</span>
                    </div>
                    <div class="pick bot loss hidden">
						<span class="tiny-number">
							[1]
						</span>
                        <div class="team-logo">
                            <img src="images/Golden_State_Warriors.png"/>
                        </div>
                        <span class="team-name">
							 GSW
						</span>
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
                        <div class="pick top loss hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
                        </div>
                        <div class="pick bot win hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
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
                        <div class="pick top loss">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Boston_Celtics.png"/>
                            </div>
                            <span class="team-name">
								 BOS
							</span>
                        </div>
                        <div class="pick bot win">
							<span class="tiny-number">
								[8]
							</span>
                            <div class="team-logo">
                                <img src="images/Chicago_Bulls.png"/>
                            </div>
                            <span class="team-name">
								 CHI
							</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top loss">
					  	<span class="tiny-number">
							[4]
						</span>
                            <div class="team-logo">
                                <img src="images/Washington_Wizards.png"/>
                            </div>
                            <span class="team-name">
							 WAS
						</span>
                        </div>
                        <div class="pick bot win">
					  	<span class="tiny-number">
							[5]
						</span>
                            <div class="team-logo">
                                <img src="images/Atlanta_Hawks.png"/>
                            </div>
                            <span class="team-name">
							 ATL
						</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom-right">
                <div class="round r-of-2">
                    <div class="bracket-game">
                        <div class="pick top loss hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
                        </div>
                        <div class="pick bot win hidden">
							<span class="tiny-number">
								[1]
							</span>
                            <div class="team-logo">
                                <img src="images/Golden_State_Warriors.png"/>
                            </div>
                            <span class="team-name">
								 GSW
							</span>
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
                        <div class="pick top win">
						  <span class="tiny-number">
								[3]
							</span>
                            <div class="team-logo">
                                <img src="images/Toronto_Raptors.png"/>
                            </div>
                            <span class="team-name">
								 TOR
							</span>
                        </div>
                        <div class="pick bot loss">
						  <span class="tiny-number">
								[6]
							</span>
                            <div class="team-logo">
                                <img src="images/Milwaukee_Bucks.png"/>
                            </div>
                            <span class="team-name">
								 MIL
							</span>
                        </div>
                    </div>
                    <div class="bracket-game cont">
                        <div class="pick top loss">
					  	<span class="tiny-number">
							[2]
						</span>
                            <div class="team-logo">
                                <img src="images/Cleveland_Cavaliers.png"/>
                            </div>
                            <span class="team-name">
							 CLE
						</span>
                        </div>
                        <div class="pick bot win">
					  	<span class="tiny-number">
							[7]
						</span>
                            <div class="team-logo">
                                <img src="images/Indiana_Pacers.png"/>
                            </div>
                            <span class="team-name">
							 IND
						</span>
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
                <strong>Finals MVP</strong><br/>
                <select>
                    <option value="volvo">omer</option>
                    <option value="saab">is</option>
                    <option value="opel">a</option>
                    <option value="audi">weirdo</option>
                </select>
                <select>
                    <option value="volvo">pay</option>
                    <option value="saab">me</option>
                    <option value="opel">money</option>
                    <option value="audi">please</option>
                </select>
            </div>

        </div>
    </div>
    <div class="right-text">
    </div>
</div>


</body>

</html>