# SugarCRM Audio Recorder field type

### To install the field in a sugarCRM instance:

1. Go to the Administration page -> Developer Tools -> Module Loader
2. Click the Choose file button on Module Upload and select the sugar-audio-field.zip package
3. Click the Install button on the Recorder uploaded package and accept the instalation

### To add a recorder field to a module:

* Create a field of type 'Recorder' for the module
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
* Create a folder where to save the recorded files in 'audio/MODULE'
```PHP
array (
	'from' => '<basepath>/include/blanco.php',
	'to' => 'audio/MODULE/blanco.php',
),
```
* Add a logic hook to the module to manage the field
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

Developed in php using Matt Diamond [Recorder.js](https://github.com/mattdiamond/Recorderjs) javascript plugin 
