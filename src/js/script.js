function statusChangeCallback(response) {
    if (response.status == "connected") {
            // redirect to user bracket
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

$(window).on("load", function() {
    FB.Event.subscribe('xfbml.render', function (response) {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    });
});