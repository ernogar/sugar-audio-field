# SugarCRM Audio Recorder field type
## Based on Matt Diamond [Recorder.js](https://github.com/mattdiamond/Recorderjs) plugin 

### To install the field in a sugarCRM instance:

1. Go to the administration page -> Developer Tools -> Module Loader
2. On Module Upload -> Choose File, select the sugar-audio-field.zip package and click the upload button.
3. On Uploaded Packages -> Recorder, click the install button and accept the instalation.

### To add a recorder field to a MODULE by code:

1. Create a field of type 'Recorder' for the module

```PHP
<?php

$dictionary['MODULE']['fields']['NAME']= array(
            'name' => 'NAME',
            'vname' => 'LABEL',
            'type' => 'Recorder',
		 'dbType' => 'varchar',
            'module' => 'MODULE',
            );

?>
```

2. Create a folder where to save the recorded files in 'audio/MODULE':

```PHP
array (
	'from' => '<basepath>/include/blanco.php',
	'to' => 'audio/MODULE/blanco.php',
),
```

3. Add a logic hook to the module to manage the field:

```PHP
<?php
class ModuleManager {

    // after_save
    function renombrarRecorder(&$bean, $event, $args) {
    	if(empty($bean->fetched_row['id']) && !empty($bean->recorder)){
    		rename("audio/$bean->recorder","audio/MODULE/".$bean->id.".wav");
    		$bean->recorder = "MODULE/".$bean->id.".wav";
    		$bean->save();
    	}
    }
    
    // before_delete
    function borrarRecorder(&$bean, $event, $args) {
    	if(!empty($bean->recorder)){
    		unlink("audio/$bean->recorder");
    	}
    }
}
?>
```