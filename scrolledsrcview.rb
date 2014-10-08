require 'gtk3'
require 'gtksourceview3'

def new_scrolled_sourceview
	# ---------------------
	scrolled_window = Gtk::ScrolledWindow.new
	new_srcview = GtkSource::View.new
	scrolled_window.add(new_srcview)
	scrolled_window.show
	new_srcview.show
	return scrolled_window	
end
