//mode_1 : Gray + Test
//---------------------------------------------------------------------------------------//					 
mode_1();

function mode_1(){
	
Dialog.create("");
	Dialog.addMessage("Select the image for Test analysis",20,"#5ab4ac");
	Dialog.show;
open();

//Atribuir a input o endereço do diretorio que contem as imagens
//	input = getDirectory("Choose a folder to import images");	
	
//Criar caixa de dialogo com as opcoes de escolha da imagem e para ativar função de separar sementes que se tocam
	Dialog.create("IJECOSEED");
//	Dialog.addNumber("Choose an image for analysis:",0);
	Dialog.addMessage("Select the Watershed option to separate touching seeds"); 
	Dialog.addCheckbox("Watershed", false);
	Dialog.show;
//armazena numero da img
//	img=Dialog.getNumber();
 //armazena escolha watershed
	Watershed = Dialog.getCheckbox();
	
// cria uma variavel para armazenar a lista de imagens
//	list = getFileList(input);

// Mostra a mensagem se a imagem nao for encontrada
//	if(img >= list.length){
//		showMessage("IJECOSSED", "<html>"
//		+"<h2><font size=+0.5 color=gray> This image could not be found in the folder<h2>");
//		mode_1();
//		}
		
// Endereco da imagem
// 	filename = input + list[img];
// Roda se a imagem for encontrada
//	if (matches(filename, ".*\\.(tif|tiff|TIFF|TIF|jpeg|jpg|png|PNG)$")){
//		open(filename);
		rename("test");	
	
// Criar caixa de dialogo com as opcoes de escolha de escala
		Dialog.create("Scale");
		Dialog.addMessage("Set the scale for conversion to unit:");
		level = newArray("Keep pixel value","Set scale value","Draw scale");
		Dialog.addChoice("Scale option:", level);
		Dialog.addHelp("http://rsb.info.nih.gov/ij/docs/");
		Dialog.show();
		choice3=Dialog.getChoice();
	
// Condicional para as opções de escala selecionada
			if(choice3=="Set scale value"){
				Dialog.create("Set");
				Dialog.addMessage("Enter the custom value for your scale:");
				Dialog.addString("Unit:","mm");
				Dialog.addNumber("Pixels/Unit:",1);
				Dialog.addHelp("http://rsb.info.nih.gov/ij/docs/");
				Dialog.show();
				valor_escala=Dialog.getNumber();
				unit=Dialog.getString();
				};
			
			else if(choice3=="Draw scale"){
				setTool("line");
				waitForUser("Waiting for user to draw a line. Press Okay to continue....");
				run("Set Scale...");
				};
		
// Pré-processamento da imagem: conversao em 8 bits | suavizacao | limiariacao
			run("8-bit");		
			selectWindow ("test");
			
			run("Duplicate...", " ");
			rename("test-1");
			
	 		run("Mean...", "radius=5");
			run("Find Edges");
			run("Maximum...", "radius=1");
			run("Threshold...");
			
			title = "Action required";
			msg = "Click the \"APPLY button\" \nto select the most suitable threshold method for your seed (default is Mean),\nthen click \"OK\".";
			waitForUser(title, msg);
			
//preenche buracos
			run("Fill Holes");
			selectWindow ("Threshold");
			run("Close");
// seleciona imagem copia 1
			selectWindow ("test-1");
// Aplica separador de sementes
				if(Watershed==true){
				run("Adjustable Watershed");
				}
// remove ruidos
			run("Options...", "iterations=5 count=1 edm=8-bit do=Erode");
			run("Options...", "iterations=4 count=4 edm=8-bit do=Open");
// cria copia 2
			selectWindow ("test-1");
			run("Duplicate...", " ");
			rename("test-2");
// cria opcao para eliminar particulas menores
			setTool("polygon");
			title = "Waiting for user to draw a polygon. Press Okay to continue....";
			msg ="Select the SMALLEST area to be considered " ;
			waitForUser(title, msg);

			run("Set Measurements...", "area add redirect=None decimal=2");
			run("Measure");
			min=getResult("Area",nResults-1);
			selectWindow ("Results");
			run("Close");
// cria opcao para eliminar particulas maiores
			setTool("polygon");
			title = "Waiting for user to draw a line. Press Okay to continue....";
			msg = "Select the LARGEST area to be considered ";
			waitForUser(title, msg);
			run("Set Measurements...", "area add redirect=None decimal=2");
			run("Measure");
			max=getResult("Area",nResults-1);
			
//setBatchMode(true);
//elimina janelas desnecessarias
			selectWindow ("Results");
			run("Close");
			selectWindow ("test-2");
			run("Close");
			
// analisa particulas
			selectWindow ("test-1");
			run("Analyze Particles...", "size=min-max circularity=0.0-1.00 show=[Masks] display exclude clear include add in_situ"); 
//cria selecao			
			run("Create Selection");

//restaura a selecao para visualizacao		
			selectWindow("test");
			run("Restore Selection");
//habilita a ferramenta de zoom
			setTool("zoom");
			title = "WaitForUserDemo";
			msg = "Check if the selection was suitable. Just click on the image to zoom";
			waitForUser(title, msg);
			//fecha resultados
			if (isOpen('Results')) {
			selectWindow('Results');
			run('Close');
			selectWindow('ROI Manager');
			run("Close");
			}
			run('Close All');
			}

Dialog.create("");
	Dialog.addMessage("Select the IJECOSEED directory",20,"#d8b365");
	Dialog.show;

//retoma para funcao chave
macroPath= getDirectory("Select the IJECOSEED main directory");
runMacro(macroPath + "IJECOSEED.ijm");
