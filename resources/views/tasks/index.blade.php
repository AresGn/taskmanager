@extends('layouts.app')
@section('title')
    @if(isset($project))
        {{ $project->name }} - Tâches
    @else
        Mes Tâches
    @endif
@endsection
@section('content')
    <style>
        .kanban-column {
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            height: 100%;
            margin-bottom: 20px;
        }

        .kanban-list {
            min-height: 300px;
            background-color: #e9ecef;
            border-radius: 5px;
            padding: 10px;
        }

        .kanban-item {
            cursor: move;
        }

        .kanban-item.invisible {
            opacity: 0.4;
        }

        /* Styles responsives pour le Kanban */
        @media (max-width: 991.98px) {
            .kanban-tabs {
                display: flex;
                margin-bottom: 15px;
                overflow-x: auto;
                border-bottom: 1px solid #dee2e6;
            }
            
            .kanban-tab {
                padding: 8px 15px;
                cursor: pointer;
                border: 1px solid transparent;
                border-top-left-radius: 0.25rem;
                border-top-right-radius: 0.25rem;
                margin-right: 5px;
                font-weight: 500;
                white-space: nowrap;
            }
            
            .kanban-tab.active {
                background-color: #fff;
                border-color: #dee2e6 #dee2e6 #fff;
            }
            
            .kanban-tab-content {
                display: none;
            }
            
            .kanban-tab-content.active {
                display: block;
            }
            
            .kanban-list {
                min-height: 400px;
            }
        }
        
        @media (min-width: 992px) {
            .kanban-tabs {
                display: none;
            }
            
            .kanban-tab-content {
                display: block !important;
            }
        }

        /* Empêcher les débordements de texte dans les cartes */
        .card-title, .card-text {
            word-break: break-word;
        }
    </style>
    <div class="container">
        <div class="bg-white align-items-center mb-4 shadow-sm p-3 rounded">
            <h2 class="text-center">
                @if(isset($project))
                    {{ $project->name }} - Tâches
                @else
                    Mes Tâches
                @endif
            </h2>
        </div>

        @if (session('success'))
            <div class="alert alert-success">
                {{ session('success') }}
            </div>
        @endif

        <!-- Tabs pour mobile/tablet -->
        <div class="kanban-tabs d-lg-none">
            <div class="kanban-tab active" data-target="tab-to-do">
                À faire <span class="badge bg-primary ms-1">{{ count($tasks['to_do'] ?? []) }}</span>
            </div>
            <div class="kanban-tab" data-target="tab-in-progress">
                En cours <span class="badge bg-warning ms-1">{{ count($tasks['in_progress'] ?? []) }}</span>
            </div>
            <div class="kanban-tab" data-target="tab-completed">
                Terminé <span class="badge bg-success ms-1">{{ count($tasks['completed'] ?? []) }}</span>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 kanban-tab-content active" id="tab-to-do">
                <div class="kanban-column">
                    <div class="d-flex justify-content-between bg-primary text-white shadow-sm align-items-center px-3 py-2 rounded-top">
                        <h4 class="text-white fw-bolder m-0">À faire</h4>
                        @if(isset($project))
                        <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#createTaskModal"
                            data-status="to_do" style="padding-top: 0.5rem; padding-bottom: 0.5rem;">+</button>
                        @endif
                    </div>
                    
                    <div class="kanban-list" id="to_do">
                        @foreach ($tasks['to_do'] ?? [] as $task)
                            <div class="card mb-3 kanban-item" data-id="{{ $task->id }}" draggable="true">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        {{ $task->title }} 
                                        <span style="font-size: 12px;" class="badge {{ $task->priority == 'low' ? 'bg-success' : ($task->priority == 'medium' ? 'bg-warning' : 'bg-danger') }}">{{ $task->priority == 'low' ? 'Faible' : ($task->priority == 'medium' ? 'Moyenne' : 'Haute') }}</span>
                                    </h5>
                                    
                                    <p class="card-text">{{ Str::limit($task->description, 100) }}</p>
                                    <a href="{{ route('tasks.show', $task->id) }}" class="btn btn-primary btn-sm"><i class="bi bi-eye"></i></a>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>

            <div class="col-lg-4 kanban-tab-content" id="tab-in-progress">
                <div class="kanban-column">
                    <div class="d-flex justify-content-between shadow-sm align-items-center bg-warning px-3 py-2 rounded-top">
                        <h4 class="text-white fw-bolder m-0">En cours</h4>
                        @if(isset($project))
                        <button type="button" class="btn btn-light" data-bs-toggle="modal"
                            data-bs-target="#createTaskModal" data-status="in_progress"
                            style="padding-top: 0.5rem; padding-bottom: 0.5rem;">+</button>
                        @endif
                    </div>
                    
                    <div class="kanban-list" id="in_progress">
                        @foreach ($tasks['in_progress'] ?? [] as $task)
                            <div class="card mb-3 kanban-item" data-id="{{ $task->id }}" draggable="true">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        {{ $task->title }}
                                        <span style="font-size: 12px;" class="badge {{ $task->priority == 'low' ? 'bg-success' : ($task->priority == 'medium' ? 'bg-warning' : 'bg-danger') }}">{{ $task->priority == 'low' ? 'Faible' : ($task->priority == 'medium' ? 'Moyenne' : 'Haute') }}</span>
                                    </h5>
                                    <p class="card-text">{{ Str::limit($task->description, 100) }}</p>
                                    <a href="{{ route('tasks.show', $task->id) }}" class="btn btn-warning btn-sm"><i class="bi bi-eye"></i></a>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>

            <div class="col-lg-4 kanban-tab-content" id="tab-completed">
                <div class="kanban-column">
                    <div class="d-flex justify-content-between shadow-sm align-items-center bg-success px-3 py-2 rounded-top">
                        <h4 class="text-white fw-bolder m-0">Terminé</h4>
                        @if(isset($project))
                        <button type="button" class="btn btn-light" data-bs-toggle="modal"
                            data-bs-target="#createTaskModal" data-status="completed" style="padding-top: 0.5rem; padding-bottom: 0.5rem;">+</button>
                        @endif
                    </div>
                    <div class="kanban-list" id="completed">
                        @foreach ($tasks['completed'] ?? [] as $task)
                            <div class="card mb-3 kanban-item" data-id="{{ $task->id }}" draggable="true">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        {{ $task->title }}
                                        <span style="font-size: 12px;" class="badge {{ $task->priority == 'low' ? 'bg-success' : ($task->priority == 'medium' ? 'bg-warning' : 'bg-danger') }}">{{ $task->priority == 'low' ? 'Faible' : ($task->priority == 'medium' ? 'Moyenne' : 'Haute') }}</span>
                                    </h5>
                                    <p class="card-text">{{ Str::limit($task->description, 100) }}</p>
                                    <a href="{{ route('tasks.show', $task->id) }}" class="btn btn-success btn-sm"><i class="bi bi-eye"></i></a>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>

        @if(isset($project))
        <!-- Modal Création de Tâche -->
        <div class="modal fade" id="createTaskModal" tabindex="-1" aria-labelledby="createTaskModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="{{ route('projects.tasks.store', $project->id) }}" method="POST">
                        @csrf
                        <div class="modal-header">
                            <h5 class="modal-title" id="createTaskModalLabel">Créer une tâche</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="title" class="form-label">Titre</label>
                                <input type="text" name="title" id="title" class="form-control" required>
                                @error('title')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea name="description" id="description" class="form-control"></textarea>
                                @error('description')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label for="due_date" class="form-label">Date d'échéance</label>
                                <input type="date" name="due_date" id="due_date" class="form-control">
                                @error('due_date')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label for="priority" class="form-label">Priorité</label>
                                <select name="priority" id="priority" class="form-select" required>
                                    <option value="low">Faible</option>
                                    <option value="medium">Moyenne</option>
                                    <option value="high">Haute</option>
                                </select>
                                @error('priority')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <label for="user_id" class="form-label">Assigner à</label>
                                <select name="user_id" id="user_id" class="form-select">
                                    <option value="{{auth()->user()->id}}">Moi-même</option>
                                    @foreach ($users as $user)  
                                        <option value="{{$user->id}}">{{$user->name}}</option>
                                    @endforeach
                                </select>
                                @error('user_id')
                                    <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <input type="hidden" name="status" id="task_status">

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                            <button type="submit" class="btn btn-primary">Créer la tâche</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        @endif
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const kanbanItems = document.querySelectorAll('.kanban-item');
            const kanbanLists = document.querySelectorAll('.kanban-list');
            const createTaskModal = document.getElementById('createTaskModal');
            
            // Gestion des onglets sur mobile/tablet
            const kanbanTabs = document.querySelectorAll('.kanban-tab');
            const kanbanTabContents = document.querySelectorAll('.kanban-tab-content');
            
            kanbanTabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    // Retirer la classe active de tous les onglets
                    kanbanTabs.forEach(t => t.classList.remove('active'));
                    // Ajouter la classe active à l'onglet cliqué
                    this.classList.add('active');
                    
                    // Masquer tous les contenus d'onglets
                    kanbanTabContents.forEach(content => content.classList.remove('active'));
                    
                    // Afficher le contenu correspondant à l'onglet
                    const targetId = this.getAttribute('data-target');
                    document.getElementById(targetId).classList.add('active');
                });
            });
            
            if (createTaskModal) {
                const taskStatusInput = document.getElementById('task_status');

                createTaskModal.addEventListener('show.bs.modal', function(event) {
                    var button = event.relatedTarget; 
                    var status = button.getAttribute('data-status'); 
                    taskStatusInput.value = status;
                });
            }

            kanbanItems.forEach(item => {
                item.addEventListener('dragstart', handleDragStart);
                item.addEventListener('dragend', handleDragEnd);
            });

            kanbanLists.forEach(list => {
                list.addEventListener('dragover', handleDragOver);
                list.addEventListener('drop', handleDrop);
            });

            function handleDragStart(e) {
                e.dataTransfer.setData('text/plain', e.target.dataset.id);
                setTimeout(() => {
                    e.target.classList.add('invisible');
                }, 0);
            }

            function handleDragEnd(e) {
                e.target.classList.remove('invisible');
            }

            function handleDragOver(e) {
                e.preventDefault();
            }

            function handleDrop(e) {
                e.preventDefault();
                const id = e.dataTransfer.getData('text');
                const draggableElement = document.querySelector(`.kanban-item[data-id='${id}']`);
                const dropzone = e.target.closest('.kanban-list');
                dropzone.appendChild(draggableElement);

                const status = dropzone.id;

                updateTaskStatus(id, status);
            }

            function updateTaskStatus(taskId, status) {
                fetch(`/tasks/${taskId}/update-status`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                    },
                    body: JSON.stringify({ status: status })
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Erreur lors de la mise à jour du statut');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Statut mis à jour avec succès');
                    // Optionnel: notification ou autre action après mise à jour réussie
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    // Optionnel: notification d'erreur ou autre action
                });
            }
        });
    </script>
@endsection
