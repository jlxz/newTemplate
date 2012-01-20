-- newTemplate applescript
-- create a new file from a template
-- autor: joseluisdgz
-- version: 0.1
-- fecha: 19/01/2012

-- default folder containing the template files
set defaultTemplateFolder to "Templates"

-- spanish prompts
set sp_createFolder to "La carpeta " & defaultTemplateFolder & " no existe.
ÀCrear la carpeta " & defaultTemplateFolder & "?"
set sp_alert to "Lo siento, para que este script funcione correctamente es necesario que exista una carpeta llamada " & defaultTemplateFolder & " en tu directorio Home"
set sp_buttons to {"S’", "No"}
set sp_titles to {"Crear carpeta", "Selecciona una plantilla:"}

-- english prompts
set en_createFolder to defaultTemplateFolder & " doesn't exist.
 Create " & defaultTemplateFolder & " folder?"
set en_alert to "Sorry, for this script to work properly there must be a folder named " & defaultTemplateFolder & " in your Home folder"
set en_buttons to {"Yes", "No"}
set en_titles to {"Create folder", "Choose a template:"}

-- default language
set defaultLanguage to "En" --Spanish or English

-- config language prompts
if (defaultLanguage is equal to "Sp") then
	set dCreateFolder to sp_createFolder
	set dAlert to sp_alert
	set dButtons to sp_buttons
	set dTitles to sp_titles
else if (defaultLanguage is equal to "En") then
	set dCreateFolder to en_createFolder
	set dAlert to en_alert
	set dButtons to en_buttons
	set dTitles to en_titles
else
	display alert "Wrong language.
 Please, change it to Sp (Spanish) or En (English)"
	return
end if

tell application "Finder"
	if not (the folder defaultTemplateFolder of home exists) then
		set question to display dialog dCreateFolder buttons dButtons default button 1 with icon caution with title item 1 of dTitles
		set folderAnswer to button returned of question
		if folderAnswer is equal to item 1 of dButtons then
			make new folder at home with properties {name:defaultTemplateFolder}
			make new document file at folder defaultTemplateFolder of home with properties {name:"newTxt.txt"}
		else
			display alert dAlert
			return
		end if
	end if
	set the templateFolder to (folder defaultTemplateFolder of home as alias) -- Templates folder in user home directory
	set the currentFolder to (folder of the front window as alias) -- destination folder
	set templateList to the name of every file of templateFolder
	set fileList to every file of templateFolder
	set selectedTemplate to (choose from list templateList with prompt item 2 of dTitles) as string
	repeat with currentFile in fileList
		if (the name of currentFile) is equal to selectedTemplate then
			duplicate currentFile to currentFolder
		end if
	end repeat
end tell
