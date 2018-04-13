<div class="sidenav-header" id="group_sidebar">
    Groups
</div>
<ul class="sidenav-menu">
    {% for group in group_data %}
        <li>
            <a href="javascript:;" onclick="populate_group_view(this)" data-group-id="{{ group.id }}">
                <span class="sidenav-link-icon"><i class="material-icons">group</i></span>
                <span class="sidenav-link-title group_link">{{ group.name }}</span>
            </a>
        </li>
    {% endfor %}
    <li>
        <a href="/new_group.php">
            <span class="sidenav-link-icon"><i class="material-icons">add</i></span>
            <span class="sidenav-link-title go_back" data-back-loc="groups">New group</span>
        </a>
    </li>
</ul>
<div class="sidenav-header"></div>
<ul class="sidenav-menu">
    <li>
        <a href="javascript:;" onclick="populate_global()">
            <span class="sidenav-link-icon"><i class="material-icons">public</i></span>
            <span class="sidenav-link-title" id="global_sidebar">Global</span>
        </a>
    </li>
</ul>