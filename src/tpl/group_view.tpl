<div class="sidenav-header" id="group_sidebar">
    {{ group_data[0].group_name }}
</div>
<ul class="sidenav-menu">
    {% for user_data in group_data %}
        <li>
            <a href="javascript:;" onclick="show_user_picks({{ user_data.id }})" data-user-id="{{ user_data.id }}">
                <span class="sidenav-link-icon">{{ user_data.score }}</span>
                <span class="sidenav-link-title user_link">{{ user_data.team_name }}</span>
            </a>
        </li>
    {% endfor %}
    <div class="sidenav-header"></div><div class="sidenav-header"><small>Invite more friends to this group!</small>
        <small>Send them the link below!</small>
        <input type="text" value="https://www.nbaplayoffpicks.com/new_group.php?group={{ group_data[0].group_name }}">
    </div>
    <li>
        <a href="javascript:;" onclick="show_sidebar()">
            <span class="sidenav-link-icon"><i class="material-icons">arrow_back</i></span>
            <span class="sidenav-link-title go_back" data-back-loc="groups">Back</span>
        </a>
    </li>
</ul>