Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:4507 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377AbXJ0TVA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 27 Oct 2007 15:21:00 -0400
Date: Sat, 27 Oct 2007 21:20:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
In-Reply-To: <20071020235546.GB1825@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0710272114590.1818@scrub.home>
References: <20071020235546.GB1825@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Sun, 21 Oct 2007, Alexey Dobriyan wrote:

> So far remedies were:
> a) grep(1) -- obviously fragile. I tried at some point grepping for
>    spin_lock_irqsave(), found quite a few, but it became booooring quickly.
> b) BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long)) -- was tried,
>    brutally broke some arches, survived one commit before revert :^)
>    Doesn't work on i386 where sizeof(unsigned int) == sizeof(unsigned long).
> 
> So it would be nice to have something more robust.

If it's just about the type checking, something like below should pretty 
much do the same.

> * irq_flags_t allows arch maintainers to eventually switch to something
>   smaller than "unsigned long" if they want to.

Considering how painful this conversion could be, the question is whether 
this is really needed. Comments so far suggest some archs don't need all 
of it, but does someone need more?

bye, Roman

---
 include/linux/irqflags.h |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/irqflags.h
===================================================================
--- linux-2.6.orig/include/linux/irqflags.h
+++ linux-2.6/include/linux/irqflags.h
@@ -41,6 +41,10 @@
 # define INIT_TRACE_IRQFLAGS
 #endif
 
+static __always_inline void __irq_flags_check(unsigned long *flags)
+{
+}
+
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 
 #include <asm/irqflags.h>
@@ -50,10 +54,11 @@
 #define local_irq_disable() \
 	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
 #define local_irq_save(flags) \
-	do { raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
+	do { __irq_flags_check(&flags); raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
 
 #define local_irq_restore(flags)				\
 	do {							\
+		__irq_flags_check(&flags);			\
 		if (raw_irqs_disabled_flags(flags)) {		\
 			raw_local_irq_restore(flags);		\
 			trace_hardirqs_off();			\
@@ -69,8 +74,8 @@
  */
 # define raw_local_irq_disable()	local_irq_disable()
 # define raw_local_irq_enable()		local_irq_enable()
-# define raw_local_irq_save(flags)	local_irq_save(flags)
-# define raw_local_irq_restore(flags)	local_irq_restore(flags)
+# define raw_local_irq_save(flags)	({ __irq_flags_check(&flags); local_irq_save(flags); })
+# define raw_local_irq_restore(flags)	({ __irq_flags_check(&flags); local_irq_restore(flags); })
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
