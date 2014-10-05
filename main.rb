#!/usr/bin/ruby
require 'gtk3'
require 'gtksourceview3'
require 'pango'
# --------------
class App
	def initialize
		builder = Gtk::Builder.new
		builder.add_from_file('./testbuilder2.glade')
		builder.connect_signals {|handle| method(handle)}
		@window = builder.get_object("applicationwindow1")
		@window.show
		@source_view = builder.get_object("gtksourceview1")
		@notebook = builder.get_object('notebook2')
	end
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
	attr_reader :source_view
end
# --------
Gtk.init
language_man = GtkSource::LanguageManager.new
language = language_man.get_language("ruby")
source_buffer = GtkSource::Buffer.new(language)
app = App.new
app.source_view.set_buffer(source_buffer)
Gtk.main
