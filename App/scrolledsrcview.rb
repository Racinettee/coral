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
	attr_accessor :saved
	attr_accessor :filepath
	attr :parent
	attr_accessor :label
end
