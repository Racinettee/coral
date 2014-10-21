#!/usr/bin/ruby
require 'gtksourceview3'
require './App/callbacks.rb'
require './App/initialize.rb'
# --------------
class App
	include Initialization
	include Callbacks
	# ---------------
	def initialize
		# ---------------------------------------------------------------
		# @window, @notebook and @source_view are exposed by this method
		# --------------------------------------------------------------
		build_win
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
