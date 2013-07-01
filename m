From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 00/16] Remove unused arch_*_relax operations from
 spinlocks
Date: Mon, 1 Jul 2013 09:53:09 +0100
Message-ID: <20130701085309.GB14027@mudshark.cambridge.arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
 <20130624115825.GJ23779@mudshark.cambridge.arm.com>
 <20130628093103.216d4d6e@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36321 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab3GAIxx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2013 04:53:53 -0400
Content-Disposition: inline
In-Reply-To: <20130628093103.216d4d6e@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "takata@linux-m32r.org" <takata@linux-m32r.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, "deller@gmx.de" <deller@gmx.de>

On Fri, Jun 28, 2013 at 08:31:03AM +0100, Martin Schwidefsky wrote:
> On Mon, 24 Jun 2013 12:58:25 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> > With GENERIC_LOCKBREAK (arm64, ia64, m32r, parisc, powerpc, s390, sh and
> > sparc), we can actually spit out arch_*_relax calls in kernel/spinlock.c
> > using some macro concatenation that defeated my grep-fu.
> > 
> > This only makes a difference on powerpc and s390, so we could either:
> > 
> >   (1) conditionally define the relax macros as cpu_relax in spinlock.c (so
> >       the two guys above can have their special versions)
> > 
> >   (2) Replace the calls with calls to cpu_relax() (although powerpc seems to
> >       want to know who owns the lock in order to relax)
> > 
> >   (3) Leave the current code alone for architectures that may select
> >       GENERIC_LOCKBREAK
> > 
> > Any other ideas/preferences?
> 
> Yeah, we never came around to implement arch_read/write_relax. We can remove
> the two defines for s390, if we want to add some logic there we can just re-add
> an appropriate definition. As powerpc is optimizing their read/write locks
> with GENERIC_LOCKBREAK=y we should leave the ability to override the relax
> function as it is, no?

Yes, I'll drop the powerpc patch and then add the following patch to the
start of the series for v2.

Cheers,

Will

--->8

From 87707347c9239b647c3b1dd57063eac08fdb1bf4 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Mon, 24 Jun 2013 19:06:51 +0100
Subject: [PATCH] locking: add default arch_*_relax definitions for
 GENERIC_LOCKBREAK

When running with GENERIC_LOCKBREAK=y, the locking implementations emit
calls to arch_{read,write,spin}_relax when spinning on a contended lock
in order to allow architectures to favour the CPU owning the lock if
possible.

In reality, everybody apart from PowerPC and S390 just does cpu_relax()
here, so make that the default behaviour and allow it to be overridden
if required.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/spinlock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index 5cdd806..4b082b5 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -34,6 +34,20 @@
 #else
 #define raw_read_can_lock(l)	read_can_lock(l)
 #define raw_write_can_lock(l)	write_can_lock(l)
+
+/*
+ * Some architectures can relax in favour of the CPU owning the lock.
+ */
+#ifndef arch_read_relax
+# define arch_read_relax(l)	cpu_relax()
+#endif
+#ifndef arch_write_relax
+# define arch_write_relax(l)	cpu_relax()
+#endif
+#ifndef arch_spin_relax
+# define arch_spin_relax(l)	cpu_relax()
+#endif
+
 /*
  * We build the __lock_function inlines here. They are too large for
  * inlining all over the place, but here is only one user per function
-- 
1.8.2.2
