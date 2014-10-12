#!/usr/bin/ruby
require 'gtk3'
require 'gdk3'
require 'gtksourceview3'
require './App/callbacks.rb'
require './App/initialize.rb'
# --------------
class App
	include Callbacks
	include Initialization
	# ---------------
	def initialize
		# ---------------------------------------------------------------
		# @window, @notebook and @source_view are exposed by this method
		# --------------------------------------------------------------
		build_win
		# -----------
		init_language
		# -----------
		@css_provider = Gtk::CssProvider.new
		@css_provider.load(:data => File.read("style.css"))
		# ----------------------------------------
		default_display = Gdk::Display.default
		screen = default_display.default_screen
		# ------------------------------------
		screen.add_provider(@css_provider, 800)
		# ---------------------------
		@window.show_all
	end
end
# --------
binding.pry
Gtk.init
app = App.new
Gtk.main
