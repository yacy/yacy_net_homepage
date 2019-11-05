# The YaCy Network

<table class="table table-bordered table-sm" id="networktable">
  <thead>
    <tr style="font-size: smaller">
      <th class="table-warning">Hash</th>
      <th class="table-warning">Name</th>
      <th class="table-danger">PPM</th>
      <th class="table-danger">QPH</th>
      <th class="table-danger">Uptime</th>
    </tr>
  </thead>
</table>

<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/dataTables.bootstrap.min.js"></script>
<script>
$(document).ready(function() {
    $('#networktable').DataTable( {
        "paging":   false,
        "ordering": false,
        "info":     false,
        "searching":   false,
        "ajax": {
	   "url": "https://yacy.searchlab.eu/Network.json?page=1&maxCount=1000",
	   "dataSrc": "peers"
	},
        "columns": [
            { "data": "hash", "defaultContent": "" },
            { "data": "fullname", "defaultContent": "" },
            { "data": "ppm", "defaultContent": "" },
            { "data": "qph", "defaultContent": "" },
            { "data": "uptime", "defaultContent": "" }
        ]
    } );
} );
</script>
