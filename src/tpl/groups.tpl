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
    <div class="sidenav-header"></div>
    <li>
        <a href="/new_group.php">
            <span class="sidenav-link-icon"><i class="material-icons">add</i></span>
            <span class="sidenav-link-title go_back" data-back-loc="groups">Create new group</span>
        </a>
    </li>
    <li>
        <a href="javascript:;" onclick="show_sidebar()">
            <span class="sidenav-link-icon"><i class="material-icons">arrow_back</i></span>
            <span class="sidenav-link-title go_back" data-back-loc="sidebar">Back</span>
        </a>
    </li>
</ul>
