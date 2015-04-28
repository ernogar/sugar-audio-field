<ul id="recordingslist">
{if !empty({{sugarvar key='value' string=true}})}
	<li id="recorderResult">
		<audio controls src="audio/{{sugarvar key='value'}}"></audio>
		<a href="audio/{{sugarvar key='value'}}" download="audio.wav">audio.wav</a>
	</li>
{/if}
</ul>
<input id="{{sugarvar key='name'}}" name="{{sugarvar key='name'}}" type="hidden" value="{{sugarvar key='value'}}" />
<input type="button" id="boton" value="Grabar" onclick="GrabarOParar()" />

{literal}
<script>
  var audio_context;
  var recorder;
  var parar = false;
  function __log(e, data) {
    console.log(e + " " + (data || "") );
  } 
  
 function startUserMedia(stream) {
    var input = audio_context.createMediaStreamSource(stream);
    __log('Media stream created.');

    // Uncomment if you want the audio to feedback directly
    //input.connect(audio_context.destination);
    //__log('Input connected to audio context destination.');
    
    recorder = new Recorder(input,{workerPath: 'custom/include/SugarFields/Fields/Recorder/recorderWorker.js'});
    __log('Recorder initialised.');
 }
 
 function GrabarOParar () {
    if ( parar ) {
        recorder && recorder.stop();
        __log('Stopped recording.');
        document.getElementById('boton').value = 'Grabar';
        sendToServ();
        recorder.clear();
    	parar = false;
    } else {
    	recorder && recorder.record();
    	__log('Recording...');
        document.getElementById ('boton').value = 'Parar y enviar';
        parar = true;
    }
  }
  
 function sendToServ() {
	    recorder && recorder.exportWAV(function(blob) {
	    	  var reader = new FileReader();
	    	  	{/literal}
	    	    {if !empty($fields.id.value)}
	    	  	aux = '{$fields.id.value}';
	    	    {else}
	    	    aux = 'aux-' + {{$displayParams.user_id_aux}};
	    	  	{/if}
	    	  	module = '{{$displayParams.module}}';
	    	    {literal}
	    	  reader.onload = function(event){
	    	    var fd = {};
	    	    fd["fname"] = aux + '.wav';
	    	    fd["fmodule"] = module;
	    	    fd["data"] = event.target.result;
	    	    $.ajax({
	    	      type: 'POST',
	    	      url: 'audio/acceptfile.php',
	    	      data: fd,
	    	      dataType: 'text'
	    	    }).done(function(data) {
	    	        __log("Grabación enviada correctamente");
	    	    });
	    	  };
	    	  {/literal}$('input#{{sugarvar key='name'}}').val(module + '/' + aux + '.wav');{literal}
	    	  reader.readAsDataURL(blob);
	    	  //SHOW
	    	  var url = URLAUX.createObjectURL(blob);
		      var li = document.createElement('li');
		      li.id="recorderResult";
		      var au = document.createElement('audio');
		      var hf = document.createElement('a');
		      au.controls = true;
		      au.src = url;
		      hf.href = url;
		      hf.download = 'audio.wav';
		      hf.innerHTML = hf.download;
		      li.appendChild(au);
		      li.appendChild(hf);
		      
		      if(typeof recorderResult != "undefined") recorderResult.remove();
		      recordingslist.appendChild(li);
	    });
  }
 
 window.onload=function(){
    try {
      // webkit shim
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
      window.URLAUX = window.URL || window.webkitURL;
      
      audio_context = new AudioContext;
      __log('Audio context set up.');
      __log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'disponible.' : 'no esta presente!'));
    } catch (e) {
      alert('No web audio support in this browser!');
    }
   
   navigator.getUserMedia ({audio: true},startUserMedia,function(err){ __log("Ocurrió el siguiente error: " + err); });
  }
</script>
<script src="custom/include/SugarFields/Fields/Recorder/recorder.js"></script>
{/literal}