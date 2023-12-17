<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use League\Csv\Reader;

class RespondenSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
      
        // membaca data csv untuk dimasukkan ke dalam database sebagai data default
        $csv = Reader::createFromPath('public/data_fixed.csv', 'r'); // membaca CSV yang ada di direktori Public dengan nama data_fixed.csv
        $csv->setHeaderOffset(0); // mendefinisikan baris pertama sebagai header/nama kolom (bukan real data)

        // perulangan untuk memasukkan tiap data ke dalam database
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
