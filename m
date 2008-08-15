From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 01:31:48 -0700
Message-ID: <20080815013148.b9dfc7ad.akpm@linux-foundation.org>
References: <20080814215200.27f79a59.akpm@linux-foundation.org>
	<20080815073750.GG16231@frodo>
	<20080815074318.GH16231@frodo>
	<20080815010227.121e5e4b.akpm@linux-foundation.org>
	<20080815081154.GJ16231@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33084 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753237AbYHOIb7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Aug 2008 04:31:59 -0400
In-Reply-To: <20080815081154.GJ16231@frodo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org

(cc linux-arch)

On Fri, 15 Aug 2008 11:11:55 +0300 Felipe Balbi <me@felipebalbi.com> wrote:

> On Fri, Aug 15, 2008 at 01:02:27AM -0700, Andrew Morton wrote:
> > > SH also defines read/write friends.
> > 
> > That's an unilluminating changelog.
> > What's actually going on in here?
> 
> Those functions are used for fifo reading/writing operations. Some
> architectures provide them and some don't. For those who don't, we add
> the definition to the driver.
> 
> > Why is a driver implementing what appear to be core architecture helper
> > functions?
> 
> Just because the core architecture doesn't provide them.
> 
> > What is a proper fix?
> 
> The proper fix is that we always have, at least, stubs for read/write
> friends even if the arch doesn't provide them.

That is absolutely not the proper fix.  Far from it.  This way we end
up with multiple (and of course, different) implementations of these
things in an arbitrary number of drivers.

A proper fix would be to a) define the semantics of these operations,
b) document them then c) implement them on each architecture.

One possible implementation might be


--- a/include/linux/io.h~a
+++ a/include/linux/io.h
@@ -67,4 +67,41 @@ int check_signature(const volatile void 
 			const unsigned char *signature, int length);
 void devm_ioremap_release(struct device *dev, void *res);
 
+#ifndef readsl
+
+/*
+ * description goes here
+ */
+static inline void readsl(const void __iomem *addr, void *buf, int len)
+{
+	insl((unsigned long)addr, buf, len);
+}
+
+static inline void readsw(const void __iomem *addr, void *buf, int len)
+{
+	insw((unsigned long)addr, buf, len);
+}
+
+static inline void readsb(const void __iomem *addr, void *buf, int len)
+{
+	insb((unsigned long)addr, buf, len);
+}
+
+static inline void writesl(const void __iomem *addr, const void *buf, int len)
+{
+	outsl((unsigned long)addr, buf, len);
+}
+
+static inline void writesw(const void __iomem *addr, const void *buf, int len)
+{
+	outsw((unsigned long)addr, buf, len);
+}
+
+static inline void writesb(const void __iomem *addr, const void *buf, int len)
+{
+	outsb((unsigned long)addr, buf, len);
+}
+
+#endif		/* readsl */
+
 #endif /* _LINUX_IO_H */


But just saying "oh look, the arch layer is all screwed up, let's hack
around it in our driver" is plain irresponsible.

> > avr32 and powerpc might also have conflicts.  Now, or in the future.

Did you review these architectures?
