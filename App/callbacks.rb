require './App/scrolledsrcview.rb'
module Callbacks
# ------------------------------------------------
# Quit the app if the user closes the main window
# ------------------------------------------------
def on_main_window_destroy
	Gtk.main_quit
end
# [------------------------------------]
# [ Add a new tab to the notebook view ]
# [ ---------------------------------- ]
def on_menu_file_new_tab_activate
	# -----------------------------
	label = Gtk::Label.new 'Hello'
	new_view = new_scrolled_sourceview()
	@notebook.append_page(new_view, label)
	# ----------------------------------------------------------------
	# Make sure the scrolled window part of the heirarchy is visible
	# when the user goes to view the new tab
	# ---------------------------------------
	new_view.show_all
	#@notebook.set_current_page -1
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
		new_view = new_scrolled_sourceview
		# --------------------------------
		children = new_view.children[0]
		# --------------------------
		buff = children.buffer # i hope this is the source_view
		# ------------------------
		buff.text = File.read(filename)
		# --------------------------------
		label = Gtk::Label.new filename[filename.rindex('/')+1..-1]
		@notebook.append_page(new_view, label)
		
		new_view.show_all
		# -----------------
	end
	# -----------------
	file_dialog.destroy
	@notebook.change_current_page -1
end
def on_menu_file_save_activate
end
def on_menu_file_saveas_activate
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
end
