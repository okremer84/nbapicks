<html>
<head>
    {% include 'header.tpl' %}
    <title>NBA Playoff Picks</title>
</head>
<body>
{% include 'fb_script.tpl' %}
<img src="/images/nba_playoffs.png">
<h1>Login using facebook or google below</h1>
<fb:login-button
        scope="public_profile,email"
        onlogin="checkLoginState();">
</fb:login-button>
</body>
</html>