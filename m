Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755668AbcHSVl0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Aug 2016 17:41:26 -0400
From: mcgrof@kernel.org
Subject: [PATCH v1 1/7] tools: add a userspace tools bug.h
Date: Fri, 19 Aug 2016 14:41:09 -0700
Message-ID: <1471642875-5957-2-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-ID: <20160819214109.HqdngmX8XRx2MJXhGiIQ6pW2L3t3FJLOP58gXgLvQuo@z>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

This will be used later by the userspace linker-tables sandbox.
As a convenience, include bug.h on kernel.h -- this is not done
on upstream kernel.h, however most header files do include bug.h
eventually, if we were to only add the ones that need it we'd
need to copy a lot of headers to tools for the ony purpose of
includeing bug.h. This simplifies that.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/include/asm-generic/bug.h | 24 ++++++++++++++++++++++++
 tools/include/linux/bug.h       |  6 ++++++
 tools/include/linux/kernel.h    |  2 ++
 3 files changed, 32 insertions(+)
 create mode 100644 tools/include/asm-generic/bug.h
 create mode 100644 tools/include/linux/bug.h

diff --git a/tools/include/asm-generic/bug.h b/tools/include/asm-generic/bug.h
new file mode 100644
index 000000000000..7b0f48b60dbe
--- /dev/null
+++ b/tools/include/asm-generic/bug.h
@@ -0,0 +1,24 @@
+#ifndef __TOOLS_ASM_GENERIC_BUG
+#define __TOOLS_ASM_GENERIC_BUG
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#define BUG() do {										\
+	fprintf(stderr, "----------------------------------------------------------\n");	\
+	fprintf (stderr, "BUG on %s at %s: %i\n", __func__, __FILE__, __LINE__);		\
+	abort();										\
+}												\
+while (0)
+
+#define BUG_ON(cond) do { if (cond) BUG(); } while (0)
+
+#define WARN_ON(__test) do {									\
+	if (__test) {										\
+		fprintf(stderr, "----------------------------------------------------------\n");\
+		fprintf (stderr, "WARN_ON on %s at %s: %i\n", __func__, __FILE__, __LINE__);	\
+	}											\
+}												\
+while (0)
+
+#endif /* __TOOLS_ASM_GENERIC_BUG */
diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
new file mode 100644
index 000000000000..9be515b40b5c
--- /dev/null
+++ b/tools/include/linux/bug.h
@@ -0,0 +1,6 @@
+#ifndef _TOOLS_LINUX_BUG_H
+#define _TOOLS_LINUX_BUG_H
+
+#include <asm-generic/bug.h>
+
+#endif /* _TOOLS_LINUX_BUG_H */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 28607db02bd3..3d385a6d4fc1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -5,6 +5,8 @@
 #include <stddef.h>
 #include <assert.h>
 
+#include <linux/bug.h>
+
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
-- 
2.9.2

