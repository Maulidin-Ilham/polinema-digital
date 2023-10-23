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


        $respondents_male = Responden::where('gender', "M")->get();
        $count_male = $respondents_male->count();

        $respondents_female = Responden::where('gender', "F")->get();
        $count_female = $respondents_female->count();

        $male_precentage = (int)number_format($count_male / $count * 100, 0);
        $female_precentage = (int)number_format($count_female / $count * 100, 0);

        return [
            "count_total" => $count,
            "count_male" => $count_male,
            "male_precentage" => $male_precentage,
            "count_female" => $count_female,
            "female_precentage" => $female_precentage,
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
