// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// $(document).on('turbolinks:load', function() {
//     $("[data-form-prepend]").click(function(e) {
//     var obj = $($(this).attr("data-form-prepend"));
//     obj.find("input, select, textarea").each(function() {
//       $(this).attr("name", function() {
//         return $(this)
//           .attr("name")
//           .replace("new_record", new Date().getTime());
//       });
//     });
//     obj.insertBefore(this);
//     return false;
//   });
// });

require('./nested_forms/addFields')
require('./nested_forms/removeFields')
import "controllers"