<!DOCTYPE html>
<?php 
	$sketch = (isset($_GET['sketch']))?$_GET['sketch']:'workbench';
	$view 	= (isset($_GET['view']))?$_GET['view']:'box';
?>
<html>
	<head>
		<title>local.stuff :: sketch :: <?php echo $sketch ?></title>
		<link href='http://fonts.googleapis.com/css?family=Marmelad' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" type="text/css" media="all" href="css/style.css">

		<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script src="lib/javascript/jquery/plugins/jquery.easing.js"></script>
		<script src="lib/javascript/processing/processing.min.js" type="text/javascript" charset="utf-8" ></script>
	</head>
	<body>
		<div id="wrapper">
			<nav id="control">
				<ul class="clearfix">
					<li><a href="/"><-</a></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li><a id="fullscreen" href="#">{fullscreen}</a></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>		
					<li><a href="/?sketch=deehn.pask.1&view=full">deehn.pask.1</a></li>
					<li><a href="/?sketch=deehn.pask.2&view=full">deehn.pask.2</a></li>
					<li><a href="/?sketch=deehn.pask.3&view=full">deehn.pask.3</a></li>
					<li><a href="/?sketch=deehn.pask.4&view=full">deehn.pask.4</a></li>
					<!--<li class="sep"></li>
					<li><a href="/?sketch=veisa.alp&view=full">veisa.alp</a></li>
					<li><a href="/?sketch=veisa.alp.2&view=full">veisa.alp.2</a></li>-->
					<li class="sep"></li>
					<!--<li><a href="/?sketch=veisa.dvek&view=full">veisa.dvek</a></li>-->
					<li><a href="/?sketch=veisa.dvek.2&view=full">veisa.dvek.2</a></li>
					<li><a href="/?sketch=veisa.dvek.3&view=full">veisa.dvek.3</a></li>
					<li><a href="/?sketch=veisa.dvek.4&view=full">veisa.dvek.4</a></li>
					<li><a href="/?sketch=veisa.dvek.5&view=full">veisa.dvek.5</a></li>
					<li class="sep"></li>				
					<li><a href="/?sketch=veisa.sem.1&view=full">veisa.sem.1</a></li>
					<li><a href="/?sketch=veisa.sem.2&view=full">veisa.sem.2</a></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>		
					<li><a href="/?sketch=sprak.ktyl.1&view=full">sprak.ktyl.1</a></li>
					<li><a href="/?sketch=sprak.ktyl.2&view=full">sprak.ktyl.2</a></li>					
					<li><a href="/?sketch=sprak.ktyl.3&view=full">sprak.ktyl.3</a></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>					
					<!--<li><a href="/?sketch=ret.thyik.1&view=full">ret.thyik.1</a></li>-->		
					<li><a href="/?sketch=ret.thyik.2&view=full">ret.thyik.2</a></li>					
					<li><a href="/?sketch=ret.thyik.3&view=full">ret.thyik.3</a></li>					
					<li><a href="/?sketch=ret.thyik.4&view=full">ret.thyik.4</a></li>					
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li><a href="/?sketch=ukl0.oren&view=full">ukl0.oren</a></li>			
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>					
					<li><a href="/?sketch=sut.kl1f.1&view=full">sut.kl1f.1</a></li>
					<li><a href="/?sketch=genart.8.1&view=full">genart.8.1</a></li>					
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>
					<li class="sep"></li>					
					<!--<li><a href="/?sketch=gr3ph.k0e.0&view=full">gr3ph.k0e.0</a></li>
					<li><a href="/?sketch=gr3ph.k0e.1&view=full">gr3ph.k0e.1</a></li>
					<li><a href="/?sketch=gr3ph.k0e.2&view=full">gr3ph.k0e.2</a></li>
					<li><a href="/?sketch=gr3ph.k0e.3&view=full">gr3ph.k0e.3</a></li>			
					<li><a href="/?sketch=gr3ph.k0e.4&view=full">gr3ph.k0e.4</a></li>
					<li><a href="/?sketch=gr3ph.k0e.5&view=full">gr3ph.k0e.5</a></li>
					<li><a href="/?sketch=gr3ph.k0e.6&view=full">gr3ph.k0e.6</a></li>
					<li><a href="/?sketch=gr3ph.k0e.7&view=full">gr3ph.k0e.7</a></li>
					<li class="sep"></li>
					<li><a href="/?sketch=growth.2&view=full">growth.2</a></li>
					<li><a href="/?sketch=growth.3&view=full">growth.3</a></li>
					<li><a href="/?sketch=growth.4&view=full">growth.4</a></li>
					<li class="sep"></li>
					<li><a href="/?sketch=waves.1&view=full">waves.1</a></li>
					<li><a href="/?sketch=lines.1&view=full">lines.1</a></li>
					<li><a href="/?sketch=lines.2&view=full">lines.2</a></li>
					<li><a href="/?sketch=noise.1&view=full">noise.1</a></li>
					<li class="sep"></li>
					<li><strong>[etc]</strong></li>
					<li class="sep"></li>
					<li><a href="/?sketch=substrate.1&view=full">substrate.1</a></li>					
					<li><a href="/?sketch=genart.3.1&view=full">genart.3.1</a></li>							
					<li><a href="/?sketch=genart.7.1&view=full">genart.7.1</a></li>					
					<li><a href="/?sketch=genart.7.1.4&view=full">genart.7.1.4</a></li>					
					<li><a href="/?sketch=genart.7.1.5&view=full">genart.7.1.5</a></li>					
					<li><a href="/?sketch=genart.8.1&view=full">genart.8.1</a></li>					
					<li><a href="/?sketch=genart.8.3&view=full">genart.8.3</a></li>-->					
				</ul>
			</nav>

		<?php 
			$html = '';
			if ($sketch=='workbench') {
				$html .= 	'<h1 class="header">WORKBENCH</h1>';
			} else {
				$html .= 	'<h1 class="header sketch-view in">'.$sketch.'</h1>';
				$html .= 	'<div class="canvas-wrap" style="'.$view.'">';
				$html .= 		'<canvas id="cvs" data-processing-sources="/processing/'.$sketch.'.pde" style="'.$view.'"></canvas>';
				$html .= 	'</div>';
			}
			echo $html;
		 ?>

		</div>
		<script src="javascript/workbench.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" charset="utf-8" >

			(function(){

			    jQuery(document).ready(function($) {
			       
			    	if(typeof b99 != undefined){
						new B99.Main();
			       	} else {

			       		try {
			       			new B99.Main();
			       		} catch (e) {
							alert('OH NOE SOME SHIT BROKED', e);
							console.log('YOU FUCKED UP');
			       		}

			       	}
			    	
			    });

			})();

		</script>

	</body>
</html>
