
using Gtk;

class InvisibilityBin : Gtk.Bin {
	private int child_width = 0;
	private int child_height = 0;



	public override void get_preferred_width(out int minimum_width,
	                                         out int natural_width) {
		if(child_width == 0 && child_height == 0) {
			base.get_preferred_width(out minimum_width, out natural_width);
			return;
		}
		minimum_width = child_width;
		natural_width = child_width;
	}

	public override void get_preferred_height(out int minimum_height,
	                                          out int natural_height) {
		if(child_width == 0 && child_height == 0) {
			base.get_preferred_height(out minimum_height, out natural_height);
			return;
		}
		minimum_height = child_height;
		natural_height = child_height;
	}

	public override void add(Widget w){
		// I hate myself for this, but...
		if(!w.visible){
			w.show();
			w.get_preferred_width(out child_width, null);
			w.get_preferred_height(out child_height, null);
			w.hide();
		}
		base.add(w);
	}


	public void hide_child() {
		get_child().get_preferred_width(out child_width, null);
		get_child().get_preferred_height(out child_height, null);
		this.get_child().hide();
	}

	public void show_child() {
		this.get_child().show();
	}


}