<?php

use App\Http\Controllers\DataSurveyController;
use App\Http\Controllers\FormController;
use App\Http\Controllers\RespondenController;
use App\Http\Controllers\LaporanController;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


// untuk menampilkan semua data responden
Route::apiResource("/responden",RespondenController::class); 
// untuk menampilkan semua data responden berdasarkan negara
Route::get('/responden/nationality/{nationality}', [RespondenController::class, 'indexByNationality']); 
// untuk menampilkan semua data responden berdasarkan negara dan genre
Route::get('/responden/nationality/{nationality}/{genre}', [RespondenController::class, 'indexByNationalityGenre']); 
// untuk mengampilkan semua data responden dari semua jenis Genre
Route::get('/responden/genre/all', [RespondenController::class, 'getAllGenre']); 
// untuk menampilkan semua data responden berdasarkan Genre
Route::get('/responden/genre/{genre}', [RespondenController::class, 'indexByGenre']); 
// untuk mengampilkan semua data responden berdasarkan Gender
Route::get('/responden/gender/{gender}', [RespondenController::class, 'indexByGender']); 


// untuk menampilkan semua data survey (dashboard Laporan)
Route::apiResource("/data-survey",DataSurveyController::class); 
// untuk operasi CRUD keluhan mahasiswa
Route::apiResource("/form", FormController::class); 
// untuk operasi CRUD laporan mahasiswa
Route::apiResource("/laporan", LaporanController::class); 


// untuk operasi CRUD user aplikasi
Route::apiResource("/user", UserController::class); 
// untuk mendapatkan data user berdasarkan email. (data user ditampilkan pada aplikasi setelah login)
Route::get('/user/find/{email}', [UserController::class, 'getUserByEmail']); 


// untuk menampilkan data di dashboar akademik
Route::get("/studentDashboard", [StudentController::class, 'dashboard']); 



