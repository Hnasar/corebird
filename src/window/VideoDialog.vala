/*  This file is part of corebird, a Gtk+ linux Twitter client.
 *  Copyright (C) 2013 Timm Bäder
 *
 *  corebird is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  corebird is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with corebird.  If not, see <http://www.gnu.org/licenses/>.
 */

class VideoDialog : Gtk.Window {
#if VINE
  private Gst.Element src;
  private Gst.Element sink;
#endif
  private ulong xid;
  private Gtk.DrawingArea drawing_area = new Gtk.DrawingArea ();


  public VideoDialog (Gtk.Window parent, string uri) {
#if VINE
    src  = Gst.ElementFactory.make ("playbin", "video");
    sink = Gst.ElementFactory.make ("xvimagesink", "sink");
    src.set ("video-sink", sink,
             "uri", uri,
             null);
    drawing_area.realize.connect (realize_cb);
#endif
    add (drawing_area);
  }

  private void realize_cb () {
    this.xid = (ulong)Gdk.X11Window.get_xid (drawing_area.get_window ());
#if VINE
    var xoverlay = (Gst.XOverlay) this.sink;
    xoverlay.set_xwindow_id (this.xid);
    this.src.set_state (Gst.State.PLAYING);
#endif
  }
}
