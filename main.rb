#!/usr/bin/ruby
require 'gtk3'
require 'gtksourceview3'
require 'pango'
require_relative './callbacks.rb'
# --------------
class App
	include Callbacks
	def initialize
		builder = Gtk::Builder.new
		builder.add_from_file('./testbuilder2.glade')
		builder.connect_signals {|handle| method(handle)}
		@language_man = GtkSource::LanguageManager.new
		@language = @language_man.get_language("ruby")
		source_buffer = GtkSource::Buffer.new(@language)
		@window = builder.get_object("applicationwindow1")
		@window.show
		@source_view = builder.get_object("gtksourceview1")
		@source_view.set_buffer source_buffer
		@notebook = builder.get_object('notebook2')
	end
	attr_reader :source_view
end
# --------
Gtk.init
app = App.new
Gtk.main
