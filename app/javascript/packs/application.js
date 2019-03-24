/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "../css/tailwind.css"

document.addEventListener('turbolinks:load', () => {
  const subscriptionForm = document.getElementById('subscription_form')

  if (subscriptionForm) {
   const stripe = Stripe('pk_test_zARpoHaZOl2LQLtr0YOthxBm0097GcQG8Q')
   const elements = stripe.elements()
   

   var style = {
     base: {
       fontSize: '16px',
       color: "#32325d",      
     }
   };
   
   const card = elements.create('card',{style: style}, {hidePostalCode: true})
  

    card.mount('#card-element')

    subscriptionForm.addEventListener('submit', (event) => {
      event.preventDefault();
      stripe.createToken(card).then(result => {
       const hiddenInput = document.createElement('input')
       hiddenInput.setAttribute('type', 'hidden')
       hiddenInput.setAttribute('name', 'stripeToken')
       hiddenInput.setAttribute('value', result.token.id)
       subscriptionForm.appendChild(hiddenInput)
    
       subscriptionForm.submit()
     })
   })
 }
})