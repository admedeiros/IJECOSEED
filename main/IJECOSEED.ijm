// Macro IJECOSEED / IJECOSEED is designed to provide researchers working 
// with seed images with an automatic image analysis tool.
//
// Copyright(C) 2020 André D.de Medeiros and Laércio J. da Silva 
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3.
// This program is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


requires("1.52a");

//Welcome message
showMessage("IJEcoSeed", "<html>"
+"<h1><font size=+5 color= #d8b365> IJ<font size=+3 color=#5ab4ac>Eco<font size=+5 color=#d8b365>Seed</h1>"
+"<h1><font size=+1 color=gray> A free access tool for seed image analysis </h1>"
+"<h1><font size=-2 color=gray> Version 1.0</h1>"
+"<h1><font size=-2 color=gray> Reference: <i> Article in process </h1>")
	macroPath= getDirectory("Select the IJECOSEED main directory");
	macroPath= getDirectory("current");
// 1) ETAPA 1: Funcao para inicializar
//---------------------------------------------------------------------------------------//					 
initial();
function initial(){
	Dialog.create("ECOSEED");
	items0 = newArray("Gray level","RGB", "Multispectral");
	Dialog.addMessage("Image type",20,"#d8b365");
	Dialog.addRadioButtonGroup("", items0, 1, 3, "Gray level");
	items = newArray("Test", "Individual analysis", "High-throughput analysis");
	Dialog.addMessage("Analysis mode",20,"#5ab4ac");
	Dialog.addRadioButtonGroup("", items, 3, 1, "Test");
	Dialog.show;

	choice0=Dialog.getRadioButton();
	choice1=Dialog.getRadioButton();
	
	if(choice1=="Test" && choice0=="Gray level")
		runMacro(macroPath + "mode_1.ijm");
	else if(choice1=="Individual analysis" && choice0=="Gray level")
		runMacro(macroPath + "mode_2.ijm");
	else if(choice1=="High-throughput analysis" && choice0=="Gray level")
		runMacro(macroPath + "mode_3.ijm");
	else if(choice1=="Test" && choice0=="RGB")
		runMacro(macroPath + "mode_4.ijm");
	else if(choice1=="Individual analysis" && choice0=="RGB")
		runMacro(macroPath + "mode_5.ijm");
	else if(choice1=="High-throughput analysis" && choice0=="RGB")
		runMacro(macroPath + "mode_6.ijm");
	else if(choice1=="Test" && choice0=="Multispectral")
		runMacro(macroPath + "mode_7.ijm");
	else if(choice1=="Individual analysis" && choice0=="Multispectral")
		runMacro(macroPath + "mode_8.ijm");
	else if(choice1=="High-throughput analysis" && choice0=="Multispectral")
		runMacro(macroPath + "mode_9.ijm");
		
}
