<?php
$manifest =
        array(
            'acceptable_sugar_versions' =>
            array('regex_matches' =>array('6\\.*',),),'aceptable_sugar_flavors' =>array('CE','PRO','CORP','ENT','ULT',),
            'name' => 'Recorder',
            'description' => 'Audio Recorder Field',
            'version' => '0.8',
            'author' => 'Ernesto Noya Garcia',
            'readme' => 'README.md',
            'icon' => '',
            'is_uninstallable' => true,
            'published_date' => '2015-02-15 17:00:00',
            'type' => 'module',
        	'remove_tables' => 'false',
);

$installdefs =
        array(
            'id' => 'Recorder-ini',
            'copy' =>
            array(
            	//SugarFields
            	array(
            		'from' => '<basepath>/include/SugarFields/Fields/Recorder',
            		'to' => 'custom/include/SugarFields/Fields/Recorder',
            	),
            	array (
            		'from' => '<basepath>/include/acceptfile.php',
            		'to' => 'audio/acceptfile.php',
            	),
            		
            ),

);
?>


