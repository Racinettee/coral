module Initialization
# --------------------
	def build_win
	# -----------
		builder = Gtk::Builder.new
		builder.add_from_file('./testbuilder2.glade')
		builder.connect_signals {|handle| method(handle)}
		# ---------------------------------------------------------
		# Get instance properties while the builder is still around
		# ------------------------------------------------
		@window = builder.get_object("applicationwindow1")
		@notebook = builder.get_object('notebook2')
		# This is probably something that shouldnt be kept, as there will be
		# many of these created that will need to be initialized
		@source_view = builder.get_object("gtksourceview1")
	end
	def init_language
		@language_man = GtkSource::LanguageManager.new
		@language = @language_man.get_language("ruby")
		# ---------------------------------------------
		source_buffer = GtkSource::Buffer.new(@language)
		@source_view.set_buffer source_buffer
	end
end
