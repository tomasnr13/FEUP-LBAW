<div class="post" style="border:solid black; width:60%; border-radius: 25px; padding:5px;margin: 5px auto;">
    <a class="author" href="{{ url('/profile/' . $post->author->id) }}">{{ $post->author->username }}</a>
    <div class="description">{{ $post->description }}</div>
    <div class="timestamp">{{ $post->date_of_post }}</div>
    <a class="comment-count" href="{{ url('/post/' . $post->id) }}">{{ $post->comments->count() }} comments</a>
    @if(Auth::check() && Auth::user()->id === $post->author->id)
        <form class="edit-form" style="display: none" action="{{ url('/post/' . $post->id) }}" method="POST">
            @method('PATCH')
            @csrf
            <label style="display: flex; flex-direction: column">
                Edit your post:
                <textarea name="text" required></textarea>
            </label>
            <button type="submit">Save</button>
            <button type="button" onclick="hideEditor(this);">Cancel</button>
        </form>
        <button class="edit-btn" onclick="showEditor(this);">Edit</button>
        <form class="delete-form" action="{{ url('/post/' . $post->id) }}" method="POST">
            @method('DELETE')
            @csrf
            <button type="submit">Delete</button>
        </form>
    @endif
</div>
