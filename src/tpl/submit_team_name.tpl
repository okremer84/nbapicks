<html>
<head>
    {% include 'header.tpl' %}
    <title>NBA Playoff Picks</title>
    <style>
        body {
            font-family: arial,helvetica, sans-serif;
        }
        .home-wrapper img.logo{
            max-width:300px;
            margin: 30px auto 0 auto;
            display: block;
        }
        .home-wrapper {
            text-align:center;
        }
        .abcRioButtonLightBlue {
            margin: 10px auto 0 auto;
        }
        h1 {
            font-size: 20px;
            margin: 30px 0;
        }
        .login-box {
            border-radius: 5px;
            border: 1px solid #AAA;
            padding: 20px;
            background-color: #f5f5f5;
            width: 300px;
            margin: 0 auto;
        }

    </style>
</head>
<body>
{% include 'fb_script.tpl' %}
<div class="home-wrapper">
    <img src="https://www.nbaplayoffpicks.com/images/nba_playoffs.png" class="logo">
    <div class="login-box">
        <form method="POST" target="/api/api_handler.php">
            <label for="team_name">Select your team name:</label>
            <input name="team_name">
            <input type="hidden" name="action" value="submit_team_name">
            <input type="submit">
        </form>
    </div>

</div>
</body>
</html>