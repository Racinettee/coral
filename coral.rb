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
		# ------------------------------------------
		# adds @language_man(ager) to this instance
		# ------------------------------------------
		init_language
		# ------------------
		# adds @css_provider
		# ------------------
		apply_style
		# ---------------------------
		@window.show_all
	end
end
# --------
Gtk.init
app = App.new
Gtk.main
