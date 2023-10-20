<?php

namespace Database\Seeders;

use App\Models\Responden;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\LazyCollection;

class RespondenSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();

        LazyCollection::make(function(){
            $handle = fopen(public_path("data_uts.csv"),"r");

            while((($line = fgetcsv($handle,1010)))!= false){
                $dataString = implode(",",$line);
                $row = explode(",",$dataString);
                yield $row;
            }

            fclose($handle);
        })
        ->skip(1)
        ->chunk(1000)
        ->each(function(LazyCollection $chunk){

            $records = $chunk->map(function ($row) {
                // Check if "age" is a valid integer, and skip the row if it's not
                $age = is_numeric($row[2]) ? (int)$row[2] : null;
                if ($age === null) {
                    return null;
                }

                $gpa = is_numeric(str_replace(',', '.', $row[4])) ? (float)str_replace(',', '.', $row[1]) : 1.0;
                $fixedCount = 1;

                return [
                    "age" => $age,
                    "gpa" =>    $row[3],
                    "year" => $row[4],
                    "count" => $fixedCount,
                    "genre" => $row[0],
                    "nationality" => $row[7],
                    "gender" => $row[6],
                    "reports" => $row[1],
                ];
            })->filter(function ($record) {
                return $record !== null; // Filter out rows where "age" is not valid
            })->toArray();

            $filteredRecords = array_filter($records);
            DB::table("respondens")->insert($filteredRecords);
        });


    }
}
