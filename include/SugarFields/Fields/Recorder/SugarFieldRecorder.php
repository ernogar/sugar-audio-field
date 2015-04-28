<?php
require_once('include/SugarFields/Fields/Base/SugarFieldBase.php');
 
class SugarFieldRecorder extends SugarFieldBase {
	
	
   function getDetailViewSmarty($parentFieldArray, $vardef, $displayParams, $tabindex) {
    $this->setup($parentFieldArray, $vardef, $displayParams, $tabindex);
    return $this->fetch('custom/include/SugarFields/Fields/Recorder/DetailView.tpl');
  }
  
   function getEditViewSmarty($parentFieldArray, $vardef, $displayParams, $tabindex) {
   	
   	global $current_user;
   	$displayParams['user_id_aux'] = $current_user->id;
  	$this->setup($parentFieldArray, $vardef, $displayParams, $tabindex);
  	
  	return $this->fetch('custom/include/SugarFields/Fields/Recorder/EditView.tpl'); //$this->findTemplate('EditView')
  }
 
}
?>

