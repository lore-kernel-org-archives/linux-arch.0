Return-Path: <torvalds@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:54952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261601AbUDCEVX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2004 23:21:23 -0500
Date: Fri, 2 Apr 2004 20:21:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: si_band
In-Reply-To: <Pine.LNX.4.58.0404021759430.1122@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0404022018430.1122@ppc970.osdl.org>
References: <20040402161321.2d4e754c.davem@redhat.com>
 <Pine.LNX.4.58.0404021759430.1122@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


David, 
 are you happy with this diff? I not only reverted the __ARCH_SI_BAND_T 
removal, I also added a comment on why it exists in the first place, and 
why the default changed to "long".

Architecture maintainers - what other 64-bit architectures will want to
add the __ARCH_SI_BAND_T define to "int"? ppc64 and x86-64 both want the
default "long", and I haven't checked the others.

		Linus

----
===== include/asm-generic/siginfo.h 1.12 vs edited =====
--- 1.12/include/asm-generic/siginfo.h	Thu Apr  1 11:46:43 2004
+++ edited/include/asm-generic/siginfo.h	Fri Apr  2 20:17:48 2004
@@ -26,6 +26,15 @@
 #define __ARCH_SI_UID_T	uid_t
 #endif
 
+/*
+ * The default "si_band" type is "long", as specified by POSIX.
+ * However, some architectures want to override this to "int"
+ * for historical compatibility reasons, so we allow that.
+ */
+#ifndef __ARCH_SI_BAND_T
+#define __ARCH_SI_BAND_T long
+#endif
+
 #ifndef HAVE_ARCH_SIGINFO_T
 
 typedef struct siginfo {
@@ -77,7 +86,7 @@
 
 		/* SIGPOLL */
 		struct {
-			long _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
 			int _fd;
 		} _sigpoll;
 	} _sifields;
===== include/asm-sparc64/siginfo.h 1.12 vs edited =====
--- 1.12/include/asm-sparc64/siginfo.h	Thu Aug 28 01:31:51 2003
+++ edited/include/asm-sparc64/siginfo.h	Fri Apr  2 20:16:14 2004
@@ -8,6 +8,7 @@
 
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #define __ARCH_SI_TRAPNO
+#define __ARCH_SI_BAND_T int
 
 #include <asm-generic/siginfo.h>
 
