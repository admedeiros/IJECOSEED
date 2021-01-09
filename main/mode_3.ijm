//STEP 4: ht_analysis
//---------------------------------------------------------------------------------------//					 

start1();
function start1(){
	//Species choose:
	width=512;
	height=512;
	Dialog.create("Choice");
	items = newArray("Cabbage","Cauliflower","Chicory","Coffee","Cowpea beans","Crambe abyssinica", "Crotalaria juncea","Lentil", "Maize","Melon","Mung bean","Okra","Onion", "Panicum spp.","Papaya", "Pea","Pepper","Sorghum","Soybean","Sunflower","Sweet corn","Tomato","Urochloa spp.","Wheat");
	Dialog.addChoice("Species :", items);
	//Set scale
	Dialog.addMessage("Set the scale for conversion to millimeters:");
	level = newArray("Keep pixel value","First level(14 cm)", "Second level (16.7 cm)","Third level(20.9 cm)", "Fourth level(27.8 cm)", "Fifth level(41.6 cm)", "Sixth level (55.4 cm)","Other");
	Dialog.addChoice("Level (focal distance in cm):", level);
	//Set measurements
	Dialog.addMessage("Measurements_1");
	rows =4;
	columns = 5;
	labels = newArray("SeedArea","SeedPerimeter", "SeedCircularity","SeedWidth","SeedHeight","SeedFeret","SeedAspectRatio","SeedRound","SeedSolidity","SeedRelativeDensity","SeedIntegratedDensity", "SeedMedianGray", "SeedSkewness", "SeedKurtosis", "SeedFilling");
	defaults = newArray(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);
	Dialog.addCheckboxGroup(rows,columns,labels,defaults);
	Dialog.addMessage("Measurements_2");
	rows_1 =1;
	columns_1 = 2;
	labels_1 = newArray("SeedFilling","SeedCoatDetachment(soybean)");
	defaults_1 = newArray(true,false);
	Dialog.addCheckboxGroup(rows_1,columns_1,labels_1,defaults_1);
	Dialog.addHelp("http://rsb.info.nih.gov/ij/docs/");
	Dialog.show();

	//store selected variables 1	
	labels1=newArray();
	for (i=0; i<labels.length; i++){
		if (Dialog.getCheckbox()>0){
			labels1=Array.concat(labels1,labels[i]);
	}
		else {
			labels1=Array.concat(labels1);
	}
	}
	//store selected variables 2
	labels2=newArray();
		for (i=0; i<labels_1.length; i++){
			if (Dialog.getCheckbox()>0){
				labels2=Array.concat(labels2,labels_1[i]);
		}
			else {
				labels2=Array.concat(labels2);
		}
		}

	// transform arrays(labels1) into string with proper encoding for imagej
	string="";
		for(i=0;i<labels1.length;i++){
			if(labels1[i]=="SeedArea"){
				string=string+" "+"area";
				}
			else if(labels1[i]=="SeedPerimeter"){
				string=string+" "+"perimeter";
				}
			else if(labels1[i]=="SeedCircularity"){
				string=string+" "+"shape";
				}
			else if(labels1[i]=="SeedWidth"){
				string=string+" "+"bounding";
				}
			else if(labels1[i]=="SeedHeight"){
				string=string+" "+"bounding";
				}
			else if(labels1[i]=="SeedFeret"){
				string=string+" "+"feret's";
				}
			else if(labels1[i]=="SeedAspectRatio"){
				string=string+" "+"shape";
				}
			else if(labels1[i]=="SeedRound"){
				string=string+" "+"shape";
				}
			else if(labels1[i]=="SeedSolidity"){
				string=string+" "+"shape";
				}
			else if(labels1[i]=="SeedRelativeDensity"){
				string=string+" "+"mean";
				}
			else if(labels1[i]=="SeedIntegratedDensity"){
				string=string+" "+"integrated";
				}
			else if(labels1[i]=="SeedMedianGray"){
				string=string+" "+"median";
				}
			else if(labels1[i]=="SeedSkewness"){
				string=string+" "+"skewness";
				}
			else if(labels1[i]=="SeedKurtosis"){
				string=string+" "+"kurtosis";
				}
			else if(labels1[i]=="SeedFilling"){
				string=string+" "+"area_fraction";
				}
			else {
				string=string;
				}
		}
	// transform arrays(labels2) into string with proper encoding for imagej
	string2="";
		for(i=0;i<labels2.length;i++){
			if(labels2[i]=="SeedFilling"){
				string2=string2+" "+"area_fraction";
				}
			else if(labels2[i]=="SeedCoatDetachment(soybean)"){
				string2=string2+" "+"area_fraction";
				}
			else {
				string2=string2;
				}
		}
	
	//create a variable that will be used when editing the results table 1
	code="";
	for (i=0;i<labels1.length;i++){
		if (labels1[i]=="SeedArea"){
			code=code+"SeedArea=Area;";
			}
		else if(labels1[i]=="SeedPerimeter"){
			code=code+"SeedPerimeter=Perim_;";
			}
		else if(labels1[i]=="SeedCircularity"){
			code=code+"SeedCircularity=Circ_;";
			}
		else if(labels1[i]=="SeedWidth"){
			code=code+"SeedWidth=Width;";
			}
		else if(labels1[i]=="SeedHeight"){
			code=code+"SeedHeight=Height;";
			}
		else if(labels1[i]=="SeedFeret"){
			code=code+"SeedFeret=Feret;";
			}
		else if(labels1[i]=="SeedAspectRatio"){
			code=code+"SeedAspectRatio=AR;";
			}
		else if(labels1[i]=="SeedRound"){
			code=code+"SeedRound=Round;";
			}
		else if(labels1[i]=="SeedSolidity"){
			code=code+"SeedSolidity=Solidity;";
			}
		else if(labels1[i]=="SeedRelativeDensity"){
			code=code+"SeedRelativeDensity=Mean;";
			}
		else if(labels1[i]=="SeedIntegratedDensity"){
			code=code+"SeedIntegratedDensity=IntDen;";
			}
		else if(labels1[i]=="SeedMedianGray"){
			code=code+"SeedMedianGray=Median;";
			}
		else if(labels1[i]=="SeedSkewness"){
			code=code+"SeedSkewness=Skew;";
			}
		else if(labels1[i]=="SeedKurtosis"){
			code=code+"SeedKurtosis=Kurt;";
			}
		else if(labels1[i]=="SeedFilling"){
			code=code+"SeedFilling=_Area;";
			}

		else{ code=code;}
	}
	//create a variable that will be used when editing the results table 2
	code2="";
	for (i=0;i<labels2.length;i++){
		if (labels2[i]=="SeedFilling"){
			code2=code2+"SeedFilling=_Area;";
			}
		else if(labels2[i]=="SeedCoatDetachment(soybean)"){
			code2=code2+"SeedCoatDetachment=(100-_Area);";
			}
		else{ code2=code2;}
	}

	//conditionals for scale selection
	option=Dialog.getChoice();
	valor_escala=Dialog.getChoice();

	if (valor_escala=="Keep pixel value")
		valor_escala=1;
	else if (valor_escala=="First level(14 cm)")
		valor_escala=122.8583;
	else if(valor_escala=="Second level (16.7 cm)")
		valor_escala=101.2554;
	else if(valor_escala=="Third level(20.9 cm)")
		valor_escala=80.2725;
	else if(valor_escala=="Fourth level(27.8 cm)")
		valor_escala=59.5500;
	else if(valor_escala=="Fifth level(41.6 cm)")
		valor_escala=39.325;
	else if(valor_escala=="Sixth level (55.4 cm)")
		valor_escala=29.3459;
	else if(valor_escala=="Other"){
			Dialog.create("Set Threshold");
			Dialog.addMessage("Enter the custom value for your scale:");
			Dialog.addNumber("Pixels/mm:",59);
			Dialog.addHelp("http://rsb.info.nih.gov/ij/docs/");
			Dialog.show();
			valor_escala=Dialog.getNumber();}

	//STEP 4	
	//Activation of the way function
	way();
	//Targeting the specific functions of each species
	function way() {
		if(option=="Cabbage")
			Cabbage();
		else if(option=="Cauliflower")
			Cauliflower();
		else if(option=="Chicory")
			Chicory();
		else if(option=="Coffee")
			Coffee();
		else if(option=="Cowpea beans")
			Cowpea_beans();
		else if(option=="Crambe abyssinica")
			Crambe_abyssinica();
		else if(option=="Crotalaria juncea")
			Crotalaria_juncea();
		else if(option=="Lentil")
			Lentil();
		else if(option=="Maize")
			Maize();
		else if(option=="Melon")
			Melon();
		else if(option=="Mung bean")
			Mung_bean();
		else if(option=="Okra")
			Okra();
		else if(option=="Onion")
			Onion();
		else if(option=="Panicum spp.")
			Panicum();
		else if(option=="Papaya")
			Papaya();
		else if(option=="Pea")
			Pea();
		else if(option=="Pepper")
			Pepper();		
		else if(option=="Sorghum")
			Sorghum();
		else if(option=="Soybean")
			Soybean();
		else if(option=="Sunflower")
			Sunflower();		
		else if(option=="Sweet corn")
			Sweet_corn();
		else if(option=="Tomato")
			Tomato();
		else if(option=="Urochloa spp.")
			Urochloa();
		else if(option=="Wheat")
			Wheat();

	}



//SOYBEAN 
function Soybean(){
	//Directory defaults
	input = getDirectory("Choose a folder to import images");
	output = getDirectory("Choose a folder to save the results");
	directory = output;

	//key function
	activation_Soybean();
	function activation_Soybean(){
	//Selection of threshold methods
	width=512;
	height=512;
	Dialog.create("Set Threshold");
	Dialog.addMessage("Select a seed threshold method :");
	items = newArray("Mean dark","Yen dark","Li dark","Moments dark","Percentile dark","Otsu dark","Default dark","Huang dark",
	"Intermodes dark","IsoData dark","IJ_IsoData dark","MaxEntropy dark","MinError dark","Minimum dark","RenyiEntropy dark","Shanbhag dark","Triangle dark");
	Dialog.addChoice ("Method :", items);
	Dialog.addMessage("Approximate seed size range :");
	Dialog.addSlider("Minimum:", 0.5, 1000000, 40000);
	Dialog.addSlider("Maximum:", 0.5, 1000000, 500000);
	items = newArray("Watershed", "Without watershed");
	Dialog.addMessage(" Select the Watershed option to try to separate touching seeds"); 
	Dialog.addRadioButtonGroup("", items, 2, 1, "Watershed");
	Dialog.addMessage("Select a threshold method to calculate coat detachment:");
	items = newArray("Li dark","Otsu dark","Moments dark","Percentile dark","Mean dark","Yen dark","Default dark","Huang dark",
	"Intermodes dark","IsoData dark","IJ_IsoData dark","MaxEntropy dark","MinError dark","Minimum dark","RenyiEntropy dark","Shanbhag dark","Triangle dark");
	Dialog.addChoice ("Method :", items);
	Dialog.addMessage("Approximate seed size range :");
	Dialog.addSlider("Minimum:", 0.5, 1000000, 40000);
	Dialog.addSlider("Maximum:", 0.5, 1000000, 500000);
	Dialog.addHelp("http://rsb.info.nih.gov/ij/docs/");
	Dialog.show();
	//Assign choice to variables.
	method=Dialog.getChoice();
	min=Dialog.getNumber();
	max=Dialog.getNumber();
	method1=Dialog.getChoice();
	min1=Dialog.getNumber();
	max1=Dialog.getNumber();
	seedwatershed=Dialog.getRadioButton();
	//Import and process images.
	setBatchMode(true); 
	start = getTime();
	list = getFileList(input);
	k = list.length;
	for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	filename = input + list[i];
	if (endsWith(filename, ".tif")) {
	open(filename);
	run("Rotate... ", "angle=8 grid=1 interpolation=Bilinear");
	sourceTitle = getTitle();
	run("8-bit");
	run("Set Scale...","distance=valor_escala known=1 pixel=1 unit=mm global");
	run("Duplicate..."," ");
	rename("imagem1");
	run("Duplicate..."," ");
	rename("imagem2");
	run("Duplicate..."," ");
	rename("imagem3");
	activation_Soybean_1();
	run("Images to Stack", "name=Stack title=[] use keep");
	run("Rotate... ", "angle=-8 grid=1 interpolation=Bilinear stack");
	run("Make Substack...", "delete slices=1,3");
	run("Make Montage...", "columns=2 rows=1 scale=0.25");
	saveAs("Tiff",directory+sourceTitle+"-"+"Processed Image"+"");
	run("Close All");
	}}
	print("The time taken, in seconds, for processing Soybean seeds was:");
	print((getTime()-start)/1000); 
	setBatchMode(false); }

	//Intermediary function
	function activation_Soybean_1(){
	activation_Soybean_2();
	activation_Soybean_3();
	}
	//function to calculate main variables
	function activation_Soybean_2() {

	selectWindow("imagem1");
	run("Mean...", "radius=5");
	run("Find Edges");
	run("Maximum...", "radius=1");
	setAutoThreshold(method);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	run("Fill Holes");
	if(seedwatershed=="Watershed"){
	run("Watershed");}
	else if(seedwatershed=="without watershed"){
	}
	run("Options...", "iterations=5 count=1 edm=8-bit do=Erode");
	run("Options...", "iterations=4 count=4 edm=8-bit do=Open");
	run("Set Measurements...", string+" stack limit add redirect=["+sourceTitle+"] decimal=3");
	Table.reset("Results");
	run("Analyze Particles...", "size=min-max circularity=0.1-1.00 show=[Count Masks] display exclude clear include add in_situ"); 
	nROI=roiManager("count");
	if (nROI > 0) {
	Table.applyMacro(code);
	Table.deleteColumn("Mean");  Table.deleteColumn("Circ.");  Table.deleteColumn("Perim.");  Table.deleteColumn("Width");  Table.deleteColumn("Height"); 
	Table.deleteColumn("Area"); Table.deleteColumn("IntDen"); Table.deleteColumn("Solidity");Table.deleteColumn("Round");  Table.deleteColumn("Feret"); Table.deleteColumn("AR");
	Table.deleteColumn("Median");Table.deleteColumn("Skew");Table.deleteColumn("Kurt");Table.deleteColumn("%Area");  Table.deleteColumn("StdDev");Table.deleteColumn("Min");
	Table.deleteColumn("Max");Table.deleteColumn("X");Table.deleteColumn("Y");Table.deleteColumn("XM");Table.deleteColumn("YM");Table.deleteColumn("BX");Table.deleteColumn("BY");
	Table.deleteColumn("Major");Table.deleteColumn("Minor");Table.deleteColumn("Angle");Table.deleteColumn("RawIntDen");Table.deleteColumn("FeretX");Table.deleteColumn("FeretY");
	Table.deleteColumn("FeretAngle");Table.deleteColumn("MinFeret");Table.deleteColumn("Mode");Table.deleteColumn("Slice"); 
	Table.update;	

	run("3-3-2 RGB");
	run("From ROI Manager");
	run("Labels...", "color=red font=50 show");    
	run("Overlay Options...", "stroke=white width=2 fill=none apply show");
	roiManager("Show All with labels");
	rename("imagem1");
	run("Flatten"); 
	rename("imagem1");
	selectWindow("imagem1");close();
	IJ.renameResults("Results"); 
	saveAs("Results",directory+sourceTitle+"-"+"morphometry and gray level"+".txt");
	selectWindow("Results");
	if (isOpen('Results')) {
	selectWindow('Results');
	run('Close');}
	} 
	else {
	if (isOpen('Results')) {
	selectWindow('Results');
	run('Close');
	}
	showMessage("IJCropSeed", "<html>"
	+"<h2><font size=0.5 color=gray> No seeds were found. Probably the choice of the scale and selection of the minimum and maximum seed size are not adequate. Please make this adjustment to correct the error.<h2>");
	}
	}
	//function to calculate seed filling
	function activation_Soybean_3() {

	selectWindow("imagem2");
	setAutoThreshold(method1);
	run("Convert to Mask");
	selectWindow("imagem3");
	run("Mean...", "radius=5");
	run("Find Edges");
	run("Maximum...", "radius=1");
	setAutoThreshold(method);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	run("Fill Holes");
	if(seedwatershed=="Watershed"){
	run("Watershed");}
	else if(seedwatershed=="without watershed"){
	}
	run("Options...", "iterations=5 count=1 edm=8-bit do=Erode");
	run("Options...", "iterations=4 count=4 edm=8-bit do=Open");
	run("Set Measurements...", string2+" add redirect=imagem2 decimal=2");
	Table.reset("Results");
	run("Analyze Particles...", "size=min1-max1 circularity=0.1-1.00 show=[Count Masks] display stack exclude clear add in_situ");
	nROI=roiManager("count");
	if (nROI > 0) {
	Table.applyMacro(code2);
	Table.deleteColumn("%Area");
	Table.update;	
	run("3-3-2 RGB");
	run("From ROI Manager");
	run("Labels...", "color=red font=50 show");    
	run("Overlay Options...", "stroke=white width=2 fill=none apply show");
	roiManager("Show All with labels");
	rename("imagem2");	
	selectWindow("imagem2");close();
	IJ.renameResults("Results"); 
	saveAs("Results",directory+sourceTitle+"-"+"seed filling"+".txt");
	if (isOpen('Results')) {
	selectWindow('Results');
	run('Close');}
	} 
	else {
	if (isOpen('Results')) {
	selectWindow('Results');
	run('Close');
	}
	showMessage("IJCropSeed", "<html>"
	+"<h2><font size=0.5 color=gray> No seeds were found. Probably the choice of the scale and selection of the minimum and maximum seed size are not adequate. Please make this adjustment to correct the error.<h2>");
	}
	}
}

z1=getBoolean("Your analysis has been successfully completed! Would you like to do another analysis? ", "yes", "no");
if(z1==1)
initial();
else 
end();

function end(){
showMessage("IJCropSeed", "<html>"
+"<h2><font size=+0.5 color=gray> Thank you <font size=0.5 color=gray> for using <font size=+2 color=#e6ac00> IJCrop<font size=+2 color=#006622>Seed</h1>"
+"<h2><font size=+0.5 color=gray> We hope to have contributed with your work! <h2>");
exit ();}
}
