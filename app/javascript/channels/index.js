// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

// add to cart button animation
const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)


$(document).ready(function(){
    $('#addtocart').on('click',function(){
      
      var button = $(this);
      var cart = $('#cart');
      var cartTotal = cart.attr('data-totalitems');
      var newCartTotal = parseInt(cartTotal) + 1;
      
      button.addClass('sendtocart');
      setTimeout(function(){
        button.removeClass('sendtocart');
        cart.addClass('shake').attr('data-totalitems', newCartTotal);
        setTimeout(function(){
          cart.removeClass('shake');
        },500)
      },1000)
    })
  })