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


Route::apiResource("/responden",RespondenController::class);

Route::get('/responden/nationality/{nationality}', [RespondenController::class, 'indexByNationality']);

Route::get('/responden/nationality/{nationality}/{genre}', [RespondenController::class, 'indexByNationalityGenre']);

Route::get('/responden/genre/all', [RespondenController::class, 'getAllGenre']);

Route::get('/responden/gender/{gender}', [RespondenController::class, 'indexByGender']);

Route::get('/responden/genre/{genre}', [RespondenController::class, 'indexByGenre']);

Route::get("/studentDashboard", [StudentController::class, 'dashboard']);

Route::apiResource("/data-survey",DataSurveyController::class);


Route::apiResource("/form", FormController::class);

Route::apiResource("/user", UserController::class);

Route::apiResource("/laporan", LaporanController::class);


Route::get('/user/find/{email}', [UserController::class, 'getUserByEmail']);

