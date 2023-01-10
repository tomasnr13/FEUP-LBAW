<div class="group" style="border:solid black; width:60%; border-radius: 25px; padding:5px;margin: 5px auto;">
    <a class="group-name" href="{{ url('/group/' . $group->name) }}">{{ $group->name }}</a>
    <div class="group-description">{{ $group->description }}</div>
</div>