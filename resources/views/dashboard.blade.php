@extends('layouts.app')
@section('title')
    Tableau de bord
@endsection
@section('content')
    <div class="container">
        <h2>Bienvenue sur votre Tableau de bord</h2>
        <p>Voici votre tableau de bord où vous pouvez gérer vos tâches, routines, notes et fichiers.</p>
        
        <div class="row mb-4">
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 dashboard-card">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Tâches</h5>
                        <p class="card-text flex-grow-1">Vous avez <strong>{{ $tasksCount }}</strong> tâches en attente.</p>
                        <a href="{{ route('projects.index') }}" class="btn btn-primary mt-auto">Voir les tâches</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 dashboard-card">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Routines</h5>
                        <p class="card-text flex-grow-1">Vous avez <strong>{{ $routinesCount }}</strong> routines programmées aujourd'hui.</p>
                        <a href="{{ route('routines.index') }}" class="btn btn-primary mt-auto">Voir les routines</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 dashboard-card">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Notes</h5>
                        <p class="card-text flex-grow-1">Vous avez <strong>{{ $notesCount }}</strong> notes enregistrées.</p>
                        <a href="{{ route('notes.index') }}" class="btn btn-primary mt-auto">Voir les notes</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 dashboard-card">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Fichiers</h5>
                        <p class="card-text flex-grow-1">Vous avez <strong>{{ $filesCount }}</strong> fichiers.</p>
                        <a href="{{ route('files.index') }}" class="btn btn-primary mt-auto">Voir les fichiers</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Tâches récentes</h5>
                        <ul class="list-group flex-grow-1">
                            @foreach($recentTasks as $task)
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    {{ $task->title }}
                                    <span class="badge bg-primary rounded-pill">{{ $task->status == 'to_do' ? 'À faire' : 'En cours' }}</span>
                                </li>
                            @endforeach
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Routines d'aujourd'hui</h5>
                        <ul class="list-group flex-grow-1">
                            @foreach($todayRoutines as $routine)
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    {{ $routine->title }}
                                    <span class="badge bg-primary rounded-pill">{{ $routine->frequency }}</span>
                                </li>
                            @endforeach
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Notes récentes</h5>
                        <ul class="list-group flex-grow-1">
                            @foreach($recentNotes as $note)
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    {{ $note->title }}
                                </li>
                            @endforeach
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Rappels à venir</h5>
                        <ul class="list-group flex-grow-1">
                            @foreach($upcomingReminders as $reminder)
                                @php
                                    $reminderDate = \Carbon\Carbon::parse($reminder->date);
                                    $reminderTime = $reminder->time;
                                @endphp
                                <li class="list-group-item d-flex justify-content-between align-items-center {{ $reminderDate->isToday() ? 'bg-warning' : ($reminderDate->isPast() ? 'bg-danger' : 'bg-success') }}">
                                    {{ $reminder->title }}
                                    <span class="badge bg-primary rounded-pill notification-badge">{{ $reminderDate->format('M d') }} {{ $reminderTime }}</span>
                                </li>
                            @endforeach
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Conteneur pour l'effet confetti -->
    <div class="confetti-container"></div>
@endsection
