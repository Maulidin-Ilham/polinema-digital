<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RespondenResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {


        return [

            'id' => $this->id,
            'age' => $this->age,
            'gpa' => (float)number_format($this->gpa,2),
            'year' => $this->year,
            'gender' => $this->gender,
            'nationality' => $this->nationality,
            'genre' => $this->genre,
            'reports' => $this->reports,

        ];


    }
}
