require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("chartkick")
require("chart.js")

require("trix")
require("@rails/actiontext")

import 'stylesheets/application.scss'
import ahoy from "ahoy.js";
import Rails from '@rails/ujs';

import $ from 'jquery';
window.$ = $;

import dt from 'datatables.net';

import "controllers"

Rails.start();

window.ahoy = ahoy;
window.Rails = Rails;

const app = {}

window.app = app;

$(document).on('turbolinks:load', () => {
    window.dataTable = $('#data-table').DataTable( {
      stateSave: true,
      // responsive: true,
      "columnDefs": [ {
        "targets": 0,
        "orderable": false
      }, {
        "targets": 5,
        "orderable": false
      } ],
      "order": [[ 3, "desc" ]]
    });
    window.dataTableReminds = $('#data-table-reminds').DataTable( {
      stateSave: true,
      // responsive: true,
      // "columnDefs": [ {
      //   "targets": 0,
      //   "orderable": false
      // }, {
      //   "targets": 5,
      //   "orderable": false
      // } ],
      // "order": [[ 3, "desc" ]]
    });
    // .columns.adjust()
    // .responsive.recalc();
})
document.addEventListener("turbolinks:before-cache", function() {
  dataTable.destroy();
  dataTableReminds.destroy();
});
