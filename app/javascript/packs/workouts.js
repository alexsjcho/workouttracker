import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'

document.addEventListener('turbolink:load',()=>{
  Vue.http.header.com.common['X-CSRF-Token'] = doucment.querySelector ('meta[name="csrf-token"]').getAttribute('content')
  Vue.use(VueResource)
  var element = document.getElementById("workout-form")

  if(element !== null) {
    var id = element.dataset.id
    var workout = JSON.parse(element.dataset.workout)
    var exercises_attributes = JSON.parse(element.dataset.exercises_attributes)
    exercises_attributes.forEach(function(exercise){exercise._destroy = null})
    workout.exercises_attributes= exercises_attributes


    var app = new Vue({
      el: element,
      data: function (){
        return { id: id, workout: workout}
      },
      methods: {
        addExercise: function() {
          this.workout.exercises_attributes.push({
            id: null,
            name: "",
            sets: "",
            weights: "",
            _destroy: null
          })
        },

        removeExercise: function(index){
          var exercise = this.workout.exercises_attributes[index]

          if (exercise.id == null){
            this.workout.exercises_attributes.splice(index,1)
          } else {
            this.workout,exercises_attributes[index]._destroy ="1"
          }
        },

        undoRemoe: function (index) {
          this.workout.exercises_attributes[index]._destroy = null
        },

        saveWorkout: function () {
          // Create the workout
          if (this.id == null){
            this.$htttp.post('/workouts',{ workout: this.workout}).then(response => {
              turbolinks.visit('/workouts/${response.body.id}')
            }, response => {
              console.log(response)
            })

            //Editing an existing workout
          } else {
            this.$http.put('/workouts/${this.id}',{workout: this.workout}).then(response => {
              turbolinks.visit('/workouts/${response.body.id}')
            }, response =>{
              console.log(response)
            })

          }
        },

        existingWorkout: function() {
          return this.workout.id !== null
        }
      }
    })
  }
})
