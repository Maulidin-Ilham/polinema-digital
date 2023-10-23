<?php

namespace Database\Seeders;

use App\Models\Responden;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\LazyCollection;
use League\Csv\Reader;

class RespondenSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // DB::disableQueryLog();

        // LazyCollection::make(function(){
        //     $handle = fopen(public_path("data_fixed.csv"),"r");

        //     while((($line = fgetcsv($handle,1010)))!= false){
        //         $dataString = implode(",",$line);
        //         $row = explode(",",$dataString);
        //         yield $row;
        //     }

        //     fclose($handle);
        // })
        // ->skip(1)
        // ->chunk(1000)
        // ->each(function(LazyCollection $chunk){

        //     $records = $chunk->map(function ($row) {
        //         // Check if "age" is a valid integer, and skip the row if it's not


        //         return [
        //             "age" => $row[2],
        //             "gpa" => $row[3],
        //             "year" => $row[4],
        //             "count" => $row[5],
        //             "genre" => $row[0],
        //             "nationality" => $row[7],
        //             "gender" => $row[6],
        //             "reports" => $row[1],
        //         ];// Filter out rows where "age" is not valid
        //     })->toArray();

        //     $filteredRecords = array_filter($records);
        //     DB::table("respondens")->insert($filteredRecords);
        // });

        $csv = Reader::createFromPath('public/data_fixed.csv', 'r');
        $csv->setHeaderOffset(0);

        foreach ($csv as $record) {
            DB::table('respondens')->insert([
                'genre' => $record['Genre'],
                'reports' => $record['Reports'],
                'age' => $record['Age'],
                'gpa' => $record['Gpa'],
                'year' => $record['Year'],
                'count' => $record['Count'],
                'gender' => $record['Gender'],
                'nationality' => $record['Nationality'],
            ]);
        }
    }
}
