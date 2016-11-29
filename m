From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Tue, 29 Nov 2016 14:51:17 +0100
Message-ID: <20161129135118.24696-1-kilobyte@angband.pl>
References: <20161129131922.GA31466@angband.pl>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161129131922.GA31466@angband.pl>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>
Cc: Adam Borowski <kilobyte@angband.pl>
List-Id: linux-arch.vger.kernel.org

Commit 4efca4ed ("kbuild: modversions for EXPORT_SYMBOL() for asm") adds
modversion support for symbols exported from asm files. Architectures
must include C-style declarations for those symbols in asm/asm-prototypes.h
in order for them to be versioned.

Add these declarations for x86, and an architecture-independent file that
can be used for common symbols.

User impact: kernels may fail to load modules at all when
CONFIG_MODVERSIONS=y.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Tested-by: Kalle Valo <kvalo@codeaurora.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Peter Wu <peter@lekensteyn.nl>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

> So somebody send me a minimal patch that is
>
>  (a) tested

By many people.

>  (b) explains it

The actual logic is in 4efca4ed0.  It wants C prototypes defined in
asm/asm-prototypes.h that lists symbols defined in assembly -- genksyms
knows only how to read C code.

>  (c) obvious

To be honest I don't quite understand what's the real gain over code that
was removed by 784d5699eddc, this mostly brings the symbols back.  But
that's for people wiser than me to explain.

> and I'll happily re-enable modversions.


The powerpc counterpart to this patch is in mainline as 9e5f688, although a
file by that name already existed.

As for arm, it looks like it was handled the other way by 8478132.


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

