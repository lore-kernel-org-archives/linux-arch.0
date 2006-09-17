Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:24547 "EHLO
	hoboe2bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964814AbWIQJwx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 05:52:53 -0400
Date: Sun, 17 Sep 2006 11:52:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: All arch maintainers: 'make headers_check' fails on most
 architectures.
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0609171149210.5726@anakin>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 12 Sep 2006, David Woodhouse wrote:
> This is just a basic check that the headers which _are_ exported don't
> try to include other headers which aren't. This can happen either
> because the former should not, or the latter _should_ be exported.
> Mostly, however, the solution is just to make sure the latter is
> included only within #ifdef __KERNEL__, because it's only needed within
> that ifdef anyway.
> 
> Admittedly, much of the time this is only seen in files like asm/page.h
> or asm/elf.h which we really don't expect anyone in userspace to be
> using anyway -- but it would be good to fix them anyway.

> asm-m68k/page.h requires asm-generic/page.h, which does not exist

Like this?

--- linux-2.6.18-rc7/include/asm-m68k/page.h.orig	2006-09-04 11:03:01.000000000 +0200
+++ linux-2.6.18-rc7/include/asm-m68k/page.h	2006-09-17 11:44:09.000000000 +0200
@@ -2,6 +2,8 @@
 #define _M68K_PAGE_H
 
 
+#ifdef __KERNEL__
+
 /* PAGE_SHIFT determines the page size */
 #ifndef CONFIG_SUN3
 #define PAGE_SHIFT	(12)
@@ -15,8 +17,6 @@
 #endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 #include <asm/setup.h>
 
 #if PAGE_SHIFT < 13
@@ -175,8 +175,8 @@ static inline void *__va(unsigned long x
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
+
 #endif /* _M68K_PAGE_H */

BTW, what about adding headers_check to `make help'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
