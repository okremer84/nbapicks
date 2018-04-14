<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            max-width: 300px;
            margin: 20px auto;
        }
        @media (max-width:767px) {
            .login-box {
                width: 80%;
                margin: 20px auto;
            }
            .home-wrapper img.logo {
                width:80%;
            }
        }


    </style>
</head>
<body>
{% include 'fb_script.tpl' %}
<div class="home-wrapper">
    <img src="https://www.nbaplayoffpicks.com/images/nba_playoffs.png" class="logo">
    <div class="login-box">
        <form method="POST" action="/team_name.php">
            <label for="team_name">Submit your nick name:</label>
            <input name="team_name" type="text" required {% if errors.team_name_missing %} style="background-color: red" {% endif %}>
            <input type="hidden" name="action" value="submit_team_name">
            <input type="submit">
            {% if errors.team_name_missing %}<br/><small>Don't forget your team name!</small>{% endif %}
        </form>
    </div>

</div>
</body>
</html>