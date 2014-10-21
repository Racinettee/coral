module Initialization
# --------------------
	def build_win
	# -----------
		builder = Gtk::Builder.new
		builder.add_from_file('./Template/testbuilder3.glade')
		builder.connect_signals {|handle| method(handle)}
		# ---------------------------------------------------------
		# Get instance properties while the builder is still around
		# ------------------------------------------------
		@window = builder.get_object("applicationwindow1")
		@notebook = builder.get_object('notebook2')
		# ---------------------
		@lang_manager = GtkSource::LanguageManager.new
		# -----------------------
		@view_menu = builder.get_object('view_menu')
		@main_menu = builder.get_object('main_menu')
	end
	def apply_style
		@css_provider = Gtk::CssProvider.new
		@css_provider.load(:data => File.read("style.css"))
		# ----------------------------------------
		default_display = Gdk::Display.default
		screen = default_display.default_screen
		# ------------------------------------
		screen.add_provider(@css_provider, 800)
	end
end
