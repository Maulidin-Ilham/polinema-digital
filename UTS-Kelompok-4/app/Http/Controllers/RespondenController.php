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
        return ["count"=>$count,"data"=>RespondenResource::collection(Responden::all())];
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
        $respondents = Responden::where('nationality', $nationality)->get();
        $count = $respondents->count();
        return [
            "count"=> $count,
            'data' => RespondenResource::collection($respondents),
            'message' => 'Respondents with the specified nationality',
        ];

    }

    public function indexByGender($gender)
    {
        // Retrieve respondents with the specified gender
        $respondents = Responden::where('gender', $gender)->get();
        $count = $respondents->count();
        return [
            "count"=> $count,
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
            "count"=> $count,
            'data' => RespondenResource::collection($respondents),
            'message' => 'Respondents with the specified genre',
        ];

    }
    public function dataSurvey(){

    }

}
