function statusChangeCallback(response) {
    if (response.status == "connected") {
        $.ajax({
            url: "/api/api_handler.php",
            method: "POST",
            data: {
                "fb_id": response.authResponse['userID'],
                "token": response.authResponse['accessToken'],
                "login_type": 'fb',
                "action": 'save_login',
            }
        }).done(function(data) {
            if (data == 'Success') {
                window.location.replace('/');
            }
        });
    }
}

function checkLoginState() {
    FB.getLoginStatus(function (response) {
        statusChangeCallback(response);
    });
};

function onSignIn(googleUser) {
    var id_token = googleUser.getAuthResponse().id_token;
    $.ajax({
        url: "/api/api_handler.php",
        method: "POST",
        data: {
            "token": id_token,
            "login_type": 'google',
            "action": 'save_login',
        }
    }).done(function(data) {
        if (data == 'Success') {
            window.location.replace('/');
        }
    });

}