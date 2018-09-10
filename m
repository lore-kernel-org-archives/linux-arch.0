From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][PATCH 8/8] really consolidate INIT_C_CC definitions
Date: Mon, 10 Sep 2018 15:45:25 +0100
Message-ID: <20180910144525.GL19965@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
 <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
 <CA+55aFyzNWJJfHRMiEF8=Nto=O=jF6iuFTQEzEqF7rr6v_j8oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyzNWJJfHRMiEF8=Nto=O=jF6iuFTQEzEqF7rr6v_j8oQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 10, 2018 at 03:33:45AM -1000, Linus Torvalds wrote:
> On Sun, Sep 9, 2018 at 6:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >  */
> > +#ifndef INIT_C_CC_VDISCARD
> > +#define INIT_C_CC_VDISCARD 'O'-0x40
> > +#endif
> 
> Just change everybody to do the same, nobody cares about VDISCARD.
> 
> We can change the value of VDISCARD because it doesn't actually have
> anything connected to it, so don't worry about "we used to have odd
> different values for it".

Point...  The following added and pushed:

commit 96202dddde4673cfd686b9812e5ab0790f907cd0
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Sep 10 10:42:59 2018 -0400

    ... and switch alpha/ppc/sparc to ^O for discard
    
    it's
            1) common for all other architectures
            2) historical default for that thing and
            3) ignored by the tty layer anyway.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/alpha/include/asm/termios_internal.h b/arch/alpha/include/asm/termios_internal.h
index 07d5c1a6cdf6..c73cc96f96a3 100644
--- a/arch/alpha/include/asm/termios_internal.h
+++ b/arch/alpha/include/asm/termios_internal.h
@@ -2,8 +2,6 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
-#define INIT_C_CC_VDISCARD 'U'-0x40
-
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b1402b1f1685..db0b6eebbfa5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,7 +223,6 @@ config PPC
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_RSEQ
-	select HAS_TERMIOS_INTERNAL
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/powerpc/include/asm/termios_internal.h b/arch/powerpc/include/asm/termios_internal.h
deleted file mode 100644
index 116b138ea232..000000000000
--- a/arch/powerpc/include/asm/termios_internal.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Liberally adapted from alpha/termios.h.  In particular, the c_cc[]
- * fields have been reordered so that termio & termios share the
- * common subset in the same order (for brain dead programs that don't
- * know or care about the differences).
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _ASM_POWERPC_TERMIOS_H
-#define _ASM_POWERPC_TERMIOS_H
-
-#define INIT_C_CC_VDISCARD 'U'-0x40
-
-#endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios_internal.h b/arch/sparc/include/asm/termios_internal.h
index 1649a0cecda9..9d14a4bc40cf 100644
--- a/arch/sparc/include/asm/termios_internal.h
+++ b/arch/sparc/include/asm/termios_internal.h
@@ -13,8 +13,6 @@
 #define _VMIN	4
 #define _VTIME	5
 
-#define INIT_C_CC_VDISCARD 'U'-0x40
-
 /*
  * Translate a "termios" structure into a "termio". Ugh.
  *
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 549715b18d22..f0bc26812548 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -11,14 +11,9 @@
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
+	reprint=^R	discard=^O	werase=^W	lnext=^V
 	eol2=\0
-	... except that discard is actually ^O on most of them.
 */
-#ifndef INIT_C_CC_VDISCARD
-#define INIT_C_CC_VDISCARD 'O'-0x40
-#endif
-
 #ifdef VDSUSP
 #define INIT_C_CC_VDSUSP_EXTRA [VDSUSP] = 'Y'-0x40,
 #else
@@ -36,7 +31,7 @@
 	[VSTOP] = 'S'-0x40,	\
 	[VSUSP] = 'Z'-0x40,	\
 	[VREPRINT] = 'R'-0x40,	\
-	[VDISCARD] = INIT_C_CC_VDISCARD,	\
+	[VDISCARD] = 'O'-0x40,	\
 	[VWERASE] = 'W'-0x40,	\
 	[VLNEXT] = 'V'-0x40,	\
 	INIT_C_CC_VDSUSP_EXTRA	\
