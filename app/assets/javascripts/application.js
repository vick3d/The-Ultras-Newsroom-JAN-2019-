// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener('turbolinks:load', () => {
 		const subscriptionForm = document.getElementById('subscription_form')
  
     if (subscriptionForm) {
      const stripe = Stripe('pk_test_zARpoHaZOl2LQLtr0YOthxBm0097GcQG8Q')
      const elements = stripe.elements()
      

      var style = {
        base: {
          // Add your base input styles here. For example:
          fontSize: '16px',
          color: "#32325d",
          hidePostalCode: true
        }
      };
      
      // Create an instance of the card Element.
      const card = elements.create('card',{style: style})
     
  
       card.mount('#card-element')

       
			stripe.createToken(card).then(result => {
				const hiddenInput = document.createElement('input')
				hiddenInput.setAttribute('type', 'hidden')
				hiddenInput.setAttribute('name', 'stripeToken')
				hiddenInput.setAttribute('value', result.token.id)
				subscriptionForm.appendChild(hiddenInput)
        subscriptionForm.submit()
      })
    }
  })