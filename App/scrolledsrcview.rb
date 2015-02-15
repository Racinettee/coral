require 'gtksourceview3'
require './App/callbacks.rb'
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
		#@source_view.signal_connect('key_press_event')do
		#	puts 'key pressed'
			# this works but suggestions need to be added
			#@source_view.completion.show
		#end
		 
		show_all
		show
	end
	attr :source_view
	attr_accessor :saved
	attr_accessor :filepath
	attr :parent
	attr_accessor :label
end
