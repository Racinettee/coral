module Callbacks
def on_main_window_destroy
	Gtk.main_quit
end
def on_menu_file_new_tab_activate
	label = Gtk::Label.new 'Hello'
	@notebook.append_page(GtkSource::View.new, label)
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
