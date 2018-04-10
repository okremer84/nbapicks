function statusChangeCallback(response) {
    if (response.status == "connected") {
            // redirect to user bracket
            console.log("connected");
            break;
    }
}

function checkLoginState() {
    FB.getLoginStatus(function (response) {
        statusChangeCallback(response);
    });
};

$(document).ready(function () {
    FB.Event.subscribe('xfbml.render', function (response) {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);

        });

    });
});