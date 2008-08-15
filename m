Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52873 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbYHOMjE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Aug 2008 08:39:04 -0400
Date: Fri, 15 Aug 2008 15:38:49 +0300
From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: drivers/usb/musb/musb_io.h
Message-ID: <20080815123848.GN16231@frodo>
Reply-To: me@felipebalbi.com
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org> <20080815085247.GK16231@frodo> <20080815021131.dfab416a.akpm@linux-foundation.org> <20080815115308.GA24513@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20080815115308.GA24513@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>
Message-ID: <20080815123849.APdi5FFWUlkJbHCBwDF_h1Y7Ohx5u1QRWLvaABECSs0@z>


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
From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Aug 2008 10:51:56 +0300
Subject: [PATCH] musb: superh also provides read/write friends

do not redefine them unless we're not building for
scuch archs.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
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
