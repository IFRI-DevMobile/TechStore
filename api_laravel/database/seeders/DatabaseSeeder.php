<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Article;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Créer un utilisateur de test
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => Hash::make('password123'),
        ]);

        // Créer des articles de test
        Article::create([
            'title' => 'Premier article',
            'content' => 'Contenu du premier article',
            'user_id' => $user->id,
        ]);

        Article::create([
            'title' => 'Deuxième article',
            'content' => 'Contenu du deuxième article',
            'user_id' => $user->id,
        ]);

        // Créer un deuxième utilisateur
        $user2 = User::create([
            'name' => 'Jane Doe',
            'email' => 'jane@example.com',
            'password' => Hash::make('password123'),
        ]);

        Article::create([
            'title' => 'Article de Jane',
            'content' => 'Contenu de l\'article de Jane',
            'user_id' => $user2->id,
        ]);
    }
}