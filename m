From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 16:17:09 +0300
Message-ID: <20080815131708.GO16231@frodo>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org> <20080815085247.GK16231@frodo> <20080815021131.dfab416a.akpm@linux-foundation.org> <20080815115308.GA24513@flint.arm.linux.org.uk> <20080815123848.GN16231@frodo>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080815123848.GN16231@frodo>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 15, 2008 at 03:38:49PM +0300, Felipe Balbi wrote:
> So I think until we have a better solution we'll need the attached patch
> to musb_io.h

Another possible solution would be the attached. I think this new
version is a bit better since we won't have to keep adding other
architectures when we find out they provide read/write friends.

=== cut here ===

From ee8f7e4150e54139613208043561be557f35e3b3 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Date: Fri, 15 Aug 2008 10:51:56 +0300
Subject: [PATCH] musb: io: only define read/write stubs if they're not defined yet

For those archs which don't provide read/write friends we
provide our own implementation so musb driver won't break
compilation.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_io.h |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 6bbedae..222f5ab 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -37,21 +37,30 @@
 
 #include <linux/io.h>
 
-#ifndef	CONFIG_ARM
+#ifndef readsl
 static inline void readsl(const void __iomem *addr, void *buf, int len)
 	{ insl((unsigned long)addr, buf, len); }
+#endif
+#ifndef readsw
 static inline void readsw(const void __iomem *addr, void *buf, int len)
 	{ insw((unsigned long)addr, buf, len); }
+#endif
+#ifndef readsb
 static inline void readsb(const void __iomem *addr, void *buf, int len)
 	{ insb((unsigned long)addr, buf, len); }
+#endif
 
+#ifndef writesl
 static inline void writesl(const void __iomem *addr, const void *buf, int len)
 	{ outsl((unsigned long)addr, buf, len); }
+#endif
+#ifndef writesw
 static inline void writesw(const void __iomem *addr, const void *buf, int len)
 	{ outsw((unsigned long)addr, buf, len); }
+#endif
+#ifndef writesb
 static inline void writesb(const void __iomem *addr, const void *buf, int len)
 	{ outsb((unsigned long)addr, buf, len); }
