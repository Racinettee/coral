#!/usr/bin/ruby
require 'gtk3'
require 'gdk3'
require 'gtksourceview3'
require 'pango'
require './callbacks.rb'
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
		@source_view = builder.get_object("gtksourceview1")
		@source_view.set_buffer source_buffer
		@notebook = builder.get_object('notebook2')
		@css_provider = Gtk::CssProvider.new
		@css_provider.load(:data => File.read("style.css"))
		# ----------------------------------------
		default_display = Gdk::Display.default
		screen = default_display.default_screen
		# ------------------------------------
		screen.add_provider(@css_provider, 800)
		#@style_context = @window.style_context
		#@style_context.add_provider(@css_provider, 800)
		#@style_context = Gtk::StyleContext.new
		#default_screen = Gdk::Screen.default
		#@style_context.set_screen default_screen
		#@style_context.add_provider(@css_provider, 800)
		@window.show_all
	end
end
# --------
Gtk.init
app = App.new
Gtk.main
