<?php


	if(!isset($_POST['fname']) || !isset($_POST['data']) || !isset($_POST['fmodule']))
	{
		exit('No file');
	}

   // pull the raw binary data from the POST array
   $data = substr($_POST['data'], strpos($_POST['data'], ",") + 1);
   
   // decode it
   $decodedData = base64_decode($data);
   
   // print out the raw data,
   $filename = $_POST['fname'];
   $filemodule = $_POST['fmodule'];
   
   // write the data out to the file
   $fp = fopen("$filemodule/$filename", 'wb');
   fwrite($fp, $decodedData);
   
   fclose($fp);
   
?>