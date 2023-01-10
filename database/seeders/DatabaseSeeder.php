<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $path = 'resources/sql/seed.sql';
        DB::unprepared(file_get_contents($path));
        $this->command->info('Database seeded!');
    //     // Set the path of your .sql file
    //    $sql = storage_path('resources/sql/seed.sql');

    //    // You must change this one, its depend on your mysql bin.
    //    $db_bin = "C:\wamp64\bin\mariadb\mariadb10.3.14\bin";

    //    // PDO Credentials
    //    $db = [
    //        'username' => env('DB_USERNAME'),
    //        'password' => env('DB_PASSWORD'),
    //        'host' => env('DB_HOST'),
    //        'database' => env('DB_DATABASE')
    //    ];
    //    exec("{$db_bin}\mysql --user={$db['username']} --password={$db['password']} --host={$db['host']} --database {$db['database']} < $sql");
    }
}
