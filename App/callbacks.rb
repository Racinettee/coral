require './App/scrolledsrcview.rb'
module Callbacks
# ------------------------------------------------
# Quit the app if the user closes the main window
# ------------------------------------------------
def on_main_window_destroy
	# -----------------------------------------------------
	# Add code here to warn user if there are unsaved files
	# --------------
	Gtk.main_quit
end
# [------------------------------------]
# [ Add a new tab to the notebook view ]
# [ ---------------------------------- ]
def on_menu_file_new_tab_activate
	# ------------------------------------
	new_view = ScrolledSrcV.new(@notebook)
	@notebook.append_page(new_view, new_view.label)
	# The new window needs to be visible. Its
	# constructor takes care of that
	# ---------------------------------------
	# switch to the newest open page
	@notebook.page = -1
end
# ---------------------------
# File open, save and save as
# ---------------------------
def on_menu_open_file_activate
	# ---------------------------------
	# Initialize a file chooser dialogue
	# ------------------------------------
	file_dialog = Gtk::FileChooserDialog.new :title=>'Open File',
		:action=>Gtk::FileChooser::Action::OPEN, :parent=>@window,
		:buttons=>[['Open', Gtk::ResponseType::OK], ['Cancel', Gtk::ResponseType::CANCEL]]
	# ----------------------------------------------------------
	# This should set the dialog to teh current working folder
	# ------------------------------
	file_dialog.current_folder = '.'
	# Run the dialog
	response = file_dialog.run
	# If the user selected a filename and chose open then we can open the file
	if response == Gtk::ResponseType::OK
		filename = file_dialog.filename
		# --------------------------------
		new_view = ScrolledSrcV.new(@notebook)
		# --------------------------------
		buff = new_view.source_view.buffer
		# ------------------------
		buff.text = File.read(filename)
		# --------------------------------
		label = Gtk::Label.new filename[filename.rindex('/')+1..-1]
		# ------------------------------------
		@notebook.append_page(new_view, label)
		# ------------------------
		new_view.filepath = filename
		
		lang = @lang_manager.guess_language(filename,'')
		buff.language=lang
	else
		puts 'Failed to open #{filename}'
	end
	# -----------------
	file_dialog.destroy
	@notebook.page = -1
end
def on_menu_file_save_activate
	# --------------------------
	scrld_src = @notebook.get_nth_page @notebook.page
	# --------------------------------------------------
	# if this current document has never been saved before
	# then utilize the save as call back
	# --------------------------------------------------
	if scrld_src.filepath == ''
		on_menu_file_saveas_activate
	else
		file = File.open(scrld_src.filepath, 'w')
		# -----------------------------
		file.write(scrld_src.source_view.buffer.text)
		file.close
	end
end
def on_menu_file_saveas_activate
	file_dialog = Gtk::FileChooserDialog.new :title=>'Save As',
		:action=>Gtk::FileChooser::Action::SAVE, :parent=>@window,
		:buttons=>[['Save', Gtk::ResponseType::OK],
		['Cancel', Gtk::ResponseType::CANCEL]]
	# -----------------------------
	file_dialog.current_folder = '.'
	
	if file_dialog.run == Gtk::ResponseType::OK
		# ------------------------------
		filename = file_dialog.filename
		# ------------------------------
		# Open the new file for writing
		# -------------------------						# scrolled window: sourceview
		scrldsrc = @notebook.get_nth_page(@notebook.page)
		
		lbl = filename[filename.rindex('/')+1..-1]
		
		scrldsrc.label.text = lbl
		# ----------------------------
		File.open(filename, 'w') do |f|
			f.write(scrldsrc.source_view.buffer.text)
			# --------------
			f.close
		end
		# ------------------
		scrldsrc.saved = true
		scrldsrc.filepath = filename
		lang = @lang_manager.guess_language(filename,'')
		scrldsrc.source_view.buffer.language=lang
	end
	file_dialog.destroy
end
# -----------------------------
def on_edit_choose_font_activate
	# -------------------------------
	# Initialize a font chooser dialogue
	# -----------------------------------
	font_choose_dialog = Gtk::FontChooserDialog.new :title => 'Select Font'
	
	# Wait for it to finish running
	response = font_choose_dialog.run
	# If Select/Ok was selected then set the windows font to the one selected
	if response == Gtk::ResponseType::OK
		font_desc = Pango::FontDescription.new font_choose_dialog.font_desc
		if font_desc
			@window.override_font(font_desc)
		end
	end
	# Destroy the dialogue
	font_choose_dialog.destroy
end
# -------------------------------
def on_view_activate
	source_view = @notebook.get_nth_page(@notebook.page).source_view
	# -----------------------------------------------
	
end
def on_menu_show_lineno_toggled
	source_view = @notebook.get_nth_page(@notebook.page).source_view
	# -------------------------------
	if source_view.show_line_numbers? 
		source_view.show_line_numbers=false
	else
		source_view.show_line_numbers=true
	end
end
end
