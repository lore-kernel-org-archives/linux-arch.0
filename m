From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 15:38:49 +0300
Message-ID: <20080815123848.GN16231@frodo>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org> <20080815085247.GK16231@frodo> <20080815021131.dfab416a.akpm@linux-foundation.org> <20080815115308.GA24513@flint.arm.linux.org.uk>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080815115308.GA24513-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2008 at 12:53:08PM +0100, Russell King wrote:
> Shrug.  Everything is not a PC.  I don't see anything odd about the above.
> 
> We basically implement a standard set of IO macros (the __raw_*) stuff
> which is used to implement the standard set of IO support (inl, insl)
> and provide a set of extensions for our platforms (readsl to complement
> insl - named precisely the same way because that's what they are) because
> the generic stuff doesn't cover all our needs.
> 
> > I assume that "bytelen" should have been "bytecount" or similar.
> 
> bytelen and bytecount mean the same thing to me.

Thanks Russel for the clarification.

So I think until we have a better solution we'll need the attached patch
to musb_io.h

Paul, is it ok for you ?

-- 
balbi

--eHhjakXzOLJAF9wJ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-musb-superh-also-provides-read-write-friends.diff"

From f3cba688c0447504f3812c570cf37732e1f9493b Mon Sep 17 00:00:00 2001
From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Date: Fri, 15 Aug 2008 10:51:56 +0300
Subject: [PATCH] musb: superh also provides read/write friends

do not redefine them unless we're not building for
scuch archs.

Signed-off-by: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 6bbedae..d0f812a 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -37,7 +37,7 @@
 
 #include <linux/io.h>
 
-#ifndef	CONFIG_ARM
+#if !defined(CONFIG_ARM) && !defined(CONFIG_SUPERH)
 static inline void readsl(const void __iomem *addr, void *buf, int len)
 	{ insl((unsigned long)addr, buf, len); }
 static inline void readsw(const void __iomem *addr, void *buf, int len)
-- 
1.6.0.rc3.6.ga0653


--eHhjakXzOLJAF9wJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
