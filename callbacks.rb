require './scrolledsrcview'
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
def on_edit_choose_font_activate
	font_choose_dialog = Gtk::FontChooserDialog.new :title => 'Select Font'
	response = font_choose_dialog.run
	if response == Gtk::ResponseType::OK
		font_desc = Pango::FontDescription.new font_choose_dialog.font_desc
		if font_desc
			@window.override_font(font_desc)
		end
	end
	font_choose_dialog.destroy
end
end
