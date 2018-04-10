function statusChangeCallback(response) {
    if (response.status == "connected") {
            // TODO: Move user to pick team name screen and save email in DB
            console.log("connected");
            FB.api('/me?fields=email', function(response) {
                // send email to API
                console.log(response.email);
            });
    }
}

function checkLoginState() {
    FB.getLoginStatus(function (response) {
        statusChangeCallback(response);
    });
};

function onSignIn(googleUser) {
    var profile = googleUser.getBasicProfile();
    // TODO: Move user to pick team name screen and save email in DB
    console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
    console.log('Name: ' + profile.getName());
    console.log('Image URL: ' + profile.getImageUrl());
    console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
}

$(window).on("load", function() {
    FB.Event.subscribe('xfbml.render', function (response) {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    });
});