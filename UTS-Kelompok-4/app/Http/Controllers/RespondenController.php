<?php

namespace App\Http\Controllers;

use App\Http\Resources\RespondenResource;
use App\Models\Responden;
use Illuminate\Http\Request;

class RespondenController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $respondents = Responden::all();
        $count = $respondents->count();

        $genres = Responden::select('genre')
            ->distinct()
            ->get();
        $genreList = $genres->pluck('genre')->toArray();

        $genreCounts = Responden::select('genre',)
            ->groupBy('genre')
            ->selectRaw('count(*) as count')
            ->get();
        $genreCounts = $genreCounts->keyBy('genre');

        $genreCountMap = $genreCounts->pluck('count', 'genre')->toArray();



        return [
            "count_total" => $count,
            "genreList" => $genreList,
            "genreCount" => $genreCountMap,
            "data" => RespondenResource::collection(Responden::all())
        ];
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Responden $responden)
    {
        //
        return new RespondenResource($responden);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Responden $responden)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Responden $responden)
    {
        //
    }

    public function indexByNationality($nationality)
    {
        // Retrieve respondents with the specified nationality
        $nation = Responden::where('nationality', $nationality)->get();
        $count = $nation->count();

        $genres = Responden::select('genre')
            ->where('nationality', $nationality)
            ->distinct()
            ->get();

        $genreList = $genres->pluck('genre')->toArray();

        $genreCounts = Responden::select('genre', 'nationality')
            ->where('nationality', $nationality)
            ->groupBy('genre', 'nationality')
            ->selectRaw('count(*) as count')
            ->get();

        $genreCounts = $genreCounts->keyBy('genre');

        $genreCountMap = $genreCounts->pluck('count', 'genre')->toArray();

        return [
            'count' => $count,
            'genreList' => $genreList,
            'genreCount' => $genreCountMap,
            'data' => RespondenResource::collection($nation),
            'message' => 'Respondents with the specified nationality',
        ];
    }

    public function indexByNationalityGenre($nationality, $genre)
    {
        // Retrieve respondents with the specified nationality
        $nationGenre = Responden::where('nationality', $nationality)
        ->where('genre', $genre)
        ->get();
        $count = $nationGenre->count();

        return [
            'count' => $count,
            'nationality' => $nationality,
            'genre' => $genre,
            'data' => RespondenResource::collection($nationGenre),
            'message' => 'Respondents with the specified nationality and genre',
        ];
    }

    public function indexByGender($gender)
    {
        // Retrieve respondents with the specified gender
        $respondents = Responden::where('gender', $gender)->get();
        $count = $respondents->count();
        return [
            "count" => $count,
            'data' => RespondenResource::collection($respondents),
            'message' => 'Respondents with the specified gender',
        ];
    }

    public function indexByGenre($genre)
    {
        // Retrieve respondents with the specified genre
        $respondents = Responden::where('genre', $genre)->get();
        $count = $respondents->count();
        return [
            "count" => $count,
            'data' => RespondenResource::collection($respondents),
            'message' => 'Respondents with the specified genre',
        ];
    }
}
