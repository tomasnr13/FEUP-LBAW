<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// Home
Route::get('/', 'Auth\LoginController@home');

// Authentication
Route::get('account/login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('account/login', 'Auth\LoginController@login');
Route::get('account/logout', 'Auth\LoginController@logout')->name('logout');
Route::get('account/register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('account/register', 'Auth\RegisterController@register');

// Profile
Route::get('profile', 'UserController@showSelf');
Route::get('profile/browse', 'UserController@showPublic');
Route::get('profile/search', 'UserController@showPublic');
Route::get('profile/{id}', 'UserController@show');
Route::get('search', 'UserController@search')->name('search');

//Post
Route::get('post/create', 'PostController@showCreatePostPage')->name('createPost');
Route::post('post/create', 'PostController@create');
Route::get('post/{id}', 'PostController@showSingle');
Route::patch('post/{id}', 'PostController@edit');
Route::delete('post/{id}', 'PostController@delete');
// Route::get('', 'PostController@showPublic');

// Comment
Route::post('post/{post_id}/comment', 'CommentController@create');
Route::patch('post/{post_id}/comment/{id}', 'CommentController@edit');
Route::delete('post/{post_id}/comment/{id}', 'CommentController@delete');

//Feed
Route::get('', 'FeedController@show');
Route::get('fytimeline', 'FeedController@showFy');
// Route::get('search', 'FeedController@search')->name('search');

// Friends
Route::get('validatefreq/{id}', 'FriendController@validatefreq');//post - creates freq
Route::get('createfreq/{id}', 'FriendController@create');//post - creates freq
Route::get('acceptfreq/{id}', 'FriendController@accept');//post - creates friend
Route::get('denyfreq/{id}', 'FriendController@deny');//delete - deletes freq
Route::get('validatedelfreq/{id}', 'FriendController@validatedelfreq');//delete - deleltes friend
Route::get('remfriend/{rel_id}/{user_id}', 'FriendController@delete');//delete - deleltes friend
Route::get('friendreqs', 'FriendController@showfreqs');//get - shows freqs

// Group
Route::get('group/{group_id}', 'GroupController@show');

//About
Route::get('about', 'StaticController@show');


