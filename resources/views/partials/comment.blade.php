<div class="comment" style="border:solid black; width:60%; border-radius: 25px; padding:5px;margin: 5px auto;">
    <a class="author" href="{{ url('/profile/' . $comment->author->id) }}">{{ $comment->author->username }}</a>
    <div class="description">{{ $comment->description }}</div>
    <div class="timestamp">{{ $comment->date_of_post }}</div>
    @if(Auth::check() && Auth::user()->id === $comment->author->id)
        <form class="edit-form" style="display: none" action="{{ url('/post/' . $comment->post->id . '/comment/' . $comment->id) }}" method="POST">
            @method('PATCH')
            @csrf
            <label style="display: flex; flex-direction: column">
                Edit your comment:
                <textarea name="text" required></textarea>
            </label>
            <button type="submit">Save</button>
            <button type="button" onclick="hideEditor(this);">Cancel</button>
        </form>
        <button class="edit-btn" onclick="showEditor(this);">Edit</button>
        <form class="delete-form" action="{{ url('/post/' . $comment->post->id . '/comment/' . $comment->id) }}" method="POST">
            @method('DELETE')
            @csrf
            <button type="submit">Delete</button>
        </form>
    @endif
</div>
