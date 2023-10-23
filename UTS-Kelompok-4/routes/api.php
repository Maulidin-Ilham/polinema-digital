<?php

use App\Http\Controllers\DataSurveyController;
use App\Http\Controllers\RespondenController;
use App\Http\Controllers\GenreController;
use App\Http\Controllers\SurveyDataController;
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


Route::get('/responden/gender/{gender}', [RespondenController::class, 'indexByGender']);

Route::get('/responden/genre/{genre}', [RespondenController::class, 'indexByGenre']);

Route::apiResource("/data-survey",DataSurveyController::class);
