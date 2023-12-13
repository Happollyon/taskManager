
const todoInputs = document.querySelector(".todo-inputs"); //input todo
const todoButton = document.querySelector(".todo-button"); //add todo
const todoList = document.querySelector(".todo-list");//ul
const filterOption = document.querySelector(".filter-todos");//filter



document.getElementById('add-task').addEventListener('click', function() {
  var taskName = document.getElementsByClassName('todo-inputs')[0].value;
  if(taskName == ""){
    alert("Please enter a task name");
    return;
  }
  if(document.getElementById("active") == null){
    alert("Please select a topic");
    return;
  }
  var topicId = document.getElementById("active").dataset.topicId; // Get the topic id from the data attribute
  var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content'); // Get the CSRF token from the page
  if (taskName) { // Make sure the task name is not empty
    var xhr = new XMLHttpRequest(); // Create a new XMLHttpRequest
    xhr.open('POST', '/tasks'); // POST to /tasks
    xhr.setRequestHeader('Content-Type', 'application/json'); // Tell the server we're sending JSON
    xhr.setRequestHeader('X-CSRF-Token', token); // Set the CSRF token in the header
    xhr.onload = function() { // When the request is done...
      if (xhr.status === 200) {
        var data = JSON.parse(xhr.responseText);
       
         //todoDiv
        const todoDiv = document.createElement("div");
        todoDiv.classList.add("todo");
        todoDiv.dataset.taskId = data.task.id; // Add the task id as a data attribute

        //create li
        const newTodo = document.createElement("li");
        newTodo.classList.add("todo-item");
        newTodo.innerText = taskName;
        todoDiv.appendChild(newTodo);

        //checked button
        const compleatedButton = document.createElement("button");
        compleatedButton.innerHTML = '<i class="fas fa-check"><i>';
        compleatedButton.classList.add("complete-btn");
        compleatedButton.setAttribute('data-task-id', data.task.id);
        compleatedButton.addEventListener('click', toggleTask);
        todoDiv.appendChild(compleatedButton);
        //trash button
        const trashButton = document.createElement("button");
        trashButton.innerHTML = '<i class="fas fa-trash"><i>';
        trashButton.classList.add("trash-btn");
        trashButton.setAttribute('data-task-id', data.task.id);
        trashButton.addEventListener('click', deleteCheck);
        
        trashButton.addEventListener('click', deleteCheck);
        todoDiv.appendChild(trashButton);
        //append list
        todoList.appendChild(todoDiv);
        // Update the page with the new task
      }
    };
    var data = {
      task: {
        topic_id: topicId, // Replace with the actual topic id
        task_name: taskName,
        completed: false
      }
    };
    xhr.send(JSON.stringify(data));
  }
});
//event listeners
//document.addEventListener("DOMContentLoaded", getTodos);
//todoList.addEventListener("click", deleteCheck);
filterOption.addEventListener("click", filterTodo);

// this function will be called when the user clicks on the trash icon
function deleteCheck(e) { 
  const item = e.target;
  
  
  //delete todo
  if (item.classList[0] === "trash-btn") {
    
    const taskId = item.dataset.taskId; // Get the task id from the data attribute

    // Send a DELETE request to the server
    fetch('/tasks/' + taskId, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
    })
    .then(response => {
      if (response.ok) {
        // If the task was deleted successfully, remove it from the DOM
        const todo = item.closest('.todo');//get the closest parent element with the class todo
        if (todo) {
          todo.remove();//remove from the dom
        }
       
      } else {
        alert('Failed to delete task.');
      }
    });
  }

  //completed btn
 
}
//this function will be called when the user clicks on the filter options
function filterTodo(e) {
  const todos = todoList.childNodes; //get all the child nodes of the ul
  todos.forEach(function (todo) { //loop through all the child nodes
    switch (e.target.value) { //check the value of the filter option
      case "all":
        todo.style.display = "flex";
        break;
      case "completed":
        if (todo.classList.contains("completed")) {
          todo.style.display = "flex";
        } else {
          todo.style.display = "none";
        }
        break;
      case "uncompleted":
        if (!todo.classList.contains("completed")) {
          todo.style.display = "flex";
        } else {
          todo.style.display = "none";
        }
        break;
    }
  });
}
// when user clicks on a topic, this function will be called 
function getTodos(topicId) {

  fetch(`/topics/${topicId}/tasks`) // Send a GET request to the server
    .then(response => response.json())
    .then(todos => {
      todos.forEach(function (todo) { // Loop over the tasks
        //todoDiv
        const todoDiv = document.createElement("div");
        todoDiv.classList.add("todo");
        if(todo.completed){ //if the task is completed, add the completed class to the todoDiv
          todoDiv.classList.add("completed");
        }

        //create li
        const newTodo = document.createElement("li");
        newTodo.classList.add("todo-item");
        newTodo.innerText = todo.task_name; // Assuming the task name is stored in `task_name`
        todoDiv.appendChild(newTodo);

        //checked button
        const compleatedButton = document.createElement("button");
        compleatedButton.innerHTML = '<i class="fas fa-check"><i>';
        compleatedButton.classList.add("complete-btn");
        compleatedButton.setAttribute('data-task-id', todo.id);
        compleatedButton.addEventListener('click', toggleTask);
        todoDiv.appendChild(compleatedButton);
        //trash button
        const trashButton = document.createElement("button");
        trashButton.innerHTML = '<i class="fas fa-trash"><i>';
        trashButton.setAttribute('data-task-id', todo.id);
        trashButton.classList.add("trash-btn");
        trashButton.addEventListener('click',deleteCheck)
        todoDiv.appendChild(trashButton);
      
        //append list
        todoList.appendChild(todoDiv);
      });
    })
    .catch(error => console.error('Error:', error));
    
}


// this function will be called when the user clicks on the plus icon to add a new topic
document.querySelector('.fa-solid.fa-plus').addEventListener('click', function(event) {
  event.preventDefault(); // Prevent the default form submit behavior

  let topicName = prompt('Enter the new topic name:'); // Prompt the user for a topic name

  fetch('/topics', { // Send a POST request to the server
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    body: JSON.stringify({ topic: { topic_name: topicName, user_id: userId } }) // include user_id in the request
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) { // If the topic was added successfully
      // Get the div with the class 'panel-container'
      var panelContainer = document.querySelector('#panel-container');

      // Create a new div for the topic
      var div = document.createElement('div');
      div.className = 'item';
     
      div.dataset.topicId = data.topic.id; // Add the topic id as a data attribute

      var h3 = document.createElement('h3');
      h3.textContent = topicName;
       //add event listener to the div on click that calls getTodos and passes the topic id
       h3.addEventListener('click', function(event) {
        try {
          document.getElementById("active").id = ""; //remove active from the previous topic
        }
        catch(err) {
          
        }
        // add active to the clicked topic parentelement
        event.target.parentElement.id = "active";
        
        getTodos(div.dataset.topicId); // Get the tasks for the topic
      });
      var i = document.createElement('i');
      i.className = 'fa-solid fa-ban';
      i.addEventListener('click', function() { // Add an event listener to the icon
        fetch('/topics/' + div.dataset.topicId, { // Send a DELETE request to the server
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
        })
        .then(response => {
          if (response.ok) {
            div.remove(); // Remove the div from the DOM
          }
        });
      });

      div.appendChild(h3);
      div.appendChild(i);

      // Append the div to the panelContainer
      panelContainer.appendChild(div);

    
    } else {
      alert('Failed to add topic.');
    }
  });
});


// this function will be called when the page loads and loads the topics from the backend
document.addEventListener('DOMContentLoaded', (event) => {
  // Fetch the topics when the page loads
  fetch('/topics', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
  })
  .then(response => response.json())
  .then(topics => {
    // Get the div with the class 'panel-container'
    var panelContainer = document.querySelector('#panel-container');

    // Add a div for each topic
    topics.forEach(topic => {
      var div = document.createElement('div');
      div.className = 'item';
      div.dataset.topicId = topic.id; // Add the topic id as a data attribute
     
      var h3 = document.createElement('h3');
      h3.textContent = topic.topic_name;
       //add event listener to the div on click that calls getTodos and passes the topic id
       h3.addEventListener('click', function(event) {
        try {
          document.getElementById("active").id = "";
        }
        catch(err) {
          
        }
        // add active to the clicked topic parentelement
        event.target.parentElement.id = "active";
        document.querySelector(".todo-list").innerHTML= "";
        
        getTodos(div.dataset.topicId);
      });
      var i = document.createElement('i');
      i.className = 'fa-solid fa-ban';
      i.addEventListener('click', function() { // Add an event listener to the icon
        fetch('/topics/' + div.dataset.topicId, { // Send a DELETE request to the server
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
        })
        .then(response => {
          if (response.ok) {
            div.remove(); // Remove the div from the DOM

          }
        });
      });

      div.appendChild(h3);
      div.appendChild(i);

      panelContainer.appendChild(div);
    }
    
    );
  
  
  });

  
});

// this function will be called when the user clicks on the check icon to mark a task as completed
 function  toggleTask(event) { // Add an event listener to the icon
    var taskId = event.target.getAttribute('data-task-id'); // Get the task id from the data attribute
    
    fetch('/tasks/' + taskId + '/toggle', { // Send a PATCH request to the server
      method: 'PATCH', 
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      credentials: 'same-origin'
    })
    .then(function(response) {
      return response.json();
    })
    .then(function(task) { // When the request is done...
      
      if (task.completed) { // If the task is completed, add the completed class to the parent element
        event.target.parentElement.classList.add('completed');
      } else {
        // Otherwise, remove the completed class from the parent element
        event.target.parentElement.classList.remove('completed');
      }
    });
  };


  