From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/2] compiler-gcc: Allow arch-specific override of unreachable
Date: Fri, 27 May 2016 16:35:49 +0100
Message-ID: <20160527153550.27303-1-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Include an arch-specific asm/compiler-gcc.h and allow for it to define a
custom version of unreachable(), which is needed to workaround a bug in
current versions of GCC for the MIPS architecture. This patch includes
an effectively empty asm-generic implementation of asm/compiler-gcc.h &
leaves the architecture specifics to a further patch.

Marked for stable as far back as v4.4 such that the MIPS patch depending
upon it can be backported too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.4+
---
 include/asm-generic/compiler-gcc.h | 8 ++++++++
 include/linux/compiler-gcc.h       | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/compiler-gcc.h

diff --git a/include/asm-generic/compiler-gcc.h b/include/asm-generic/compiler-gcc.h
new file mode 100644
index 0000000..e8ba230
--- /dev/null
+++ b/include/asm-generic/compiler-gcc.h
@@ -0,0 +1,8 @@
+#ifndef __LINUX_COMPILER_H
+#error "Please don't include <asm/compiler.gcc.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/*
+ * We have nothing architecture-specific to do here, simply leave everything to
+ * the generic linux/compiler-gcc.h.
+ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3d5202e..e556cb8 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -9,6 +9,9 @@
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
 
+/* Allow architectures to override some definitions where necessary */
+#include <asm/compiler-gcc.h>
+
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
@@ -196,7 +199,9 @@
  * this in the preprocessor, but we can live with this because they're
  * unreleased.  Really, we need to have autoconf for the kernel.
  */
-#define unreachable() __builtin_unreachable()
+#ifndef unreachable
+# define unreachable() __builtin_unreachable()
+#endif
 
 /* Mark a function definition as prohibited from being cloned. */
 #define __noclone	__attribute__((__noclone__, __optimize__("no-tracer")))
-- 
2.8.3
