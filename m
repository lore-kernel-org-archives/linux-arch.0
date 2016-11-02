From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] kbuild: provide include/asm/asm-prototypes.h for x86
Date: Wed,  2 Nov 2016 13:14:27 +0100
Message-ID: <20161102121427.10103-1-kilobyte@angband.pl>
References: <20161102121103.GA1879@angband.pl>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161102121103.GA1879@angband.pl>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar@umbar.angband.pl, Sandoval@umbar.angband.pl, osandov@osandov.com, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>
List-Id: linux-arch.vger.kernel.org

Nicholas Piggin wrote:
> Architectures will need to have an include/asm/asm-prototypes.h that
> defines or #include<>s C-style prototypes for exported asm functions.
> We can do an asm-generic version for the common ones like memset so
> there's not a lot of pointless duplication there.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/x86/include/asm/asm-prototypes.h | 12 ++++++++++++
 include/asm-generic/asm-prototypes.h  |  7 +++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/x86/include/asm/asm-prototypes.h
 create mode 100644 include/asm-generic/asm-prototypes.h

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
new file mode 100644
index 0000000..ae87224
--- /dev/null
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -0,0 +1,12 @@
+#include <asm/ftrace.h>
+#include <asm/uaccess.h>
+#include <asm/string.h>
+#include <asm/page.h>
+#include <asm/checksum.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/special_insns.h>
+#include <asm/preempt.h>
diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
new file mode 100644
index 0000000..df13637
--- /dev/null
+++ b/include/asm-generic/asm-prototypes.h
@@ -0,0 +1,7 @@
+#include <linux/bitops.h>
+extern void *__memset(void *, int, __kernel_size_t);
+extern void *__memcpy(void *, const void *, __kernel_size_t);
+extern void *__memmove(void *, const void *, __kernel_size_t);
+extern void *memset(void *, int, __kernel_size_t);
+extern void *memcpy(void *, const void *, __kernel_size_t);
+extern void *memmove(void *, const void *, __kernel_size_t);
-- 
2.10.2

