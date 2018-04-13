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
            width: 500px;
            margin: 0 auto;
        }

    </style>
</head>
<body>
{% include 'fb_script.tpl' %}
<div class="home-wrapper">
    <img src="https://www.nbaplayoffpicks.com/images/nba_playoffs.png" class="logo">
    <div class="login-box">
        {% if added_to_group == true %}
            <span>Successfully added to group!</span><br/>
            <a href="/">Back to bracket</a>
        {% elseif errors.add_to_group_error == true %}
            <span>Can't add you to this group, please check the link</span>
        {% elseif new_group_url is empty %}
            <form method="POST" action="/new_group.php">
                <label for="group_name">Submit your group name:</label>
                <input name="group_name" type="text" required>
                <input type="hidden" name="action" value="submit_group_name">
                <input type="submit">
                {% if errors.try_again %}<br/><small>Having trouble creating group, please try again later</small>{% endif %}
                {% if errors.taken %}<br/><small>Sorry, this name is already in use</small>{% endif %}
            </form>
        {% else %}
            <span>Group {{ group_name }} successfully created!</span><br/>
            <span>Use the link below to invite your friends!</span>
            <input type="text" value="{{ new_group_url }}" style="width: 400px"><br/>
            <a href="/">Back to bracket</a>
        {% endif %}
    </div>

</div>
</body>
</html>