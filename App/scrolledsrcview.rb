require 'gtk3'
require 'gtksourceview3'
# The object that a tab will store
class ScrolledSrcV < Gtk::ScrolledWindow
	# ----------------------
	def initialize parent=nil
		@parent = parent
		@filepath = ''
		@label = Gtk::Label.new '*new*'
		@saved = false
		# ---------------
		super()
		# -----
		@source_view = GtkSource::View.new
		add(@source_view)
		show_all
		show
	end
	attr :source_view
	attr :saved
	attr :filepath
	attr :parent
	attr :label
end
