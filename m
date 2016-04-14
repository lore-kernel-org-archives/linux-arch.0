From: zengzhaoxiu@163.com
Subject: [PATCH V3 01/29] bitops: add parity functions
Date: Thu, 14 Apr 2016 10:41:24 +0800
Message-ID: <1460601694-4056-1-git-send-email-zengzhaoxiu@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@kernel.org>, Sasha Levin <sasha.levin@oracle.com>, Denys Vlasenko <dvlasenk@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Add generic odd parity functions, adapted from
"https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel"

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 include/asm-generic/bitops.h              |  1 +
 include/asm-generic/bitops/arch_parity.h  | 39 +++++++++++++++++++++++++++++++
 include/asm-generic/bitops/const_parity.h | 36 ++++++++++++++++++++++++++++
 include/asm-generic/bitops/parity.h       |  7 ++++++
 include/asm-generic/bitops/popc-parity.h  | 32 +++++++++++++++++++++++++
 include/linux/bitops.h                    | 10 ++++++++
 6 files changed, 125 insertions(+)
 create mode 100644 include/asm-generic/bitops/arch_parity.h
 create mode 100644 include/asm-generic/bitops/const_parity.h
 create mode 100644 include/asm-generic/bitops/parity.h
 create mode 100644 include/asm-generic/bitops/popc-parity.h

diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index dcdcacf..d85722f 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -27,6 +27,7 @@
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/atomic.h>
diff --git a/include/asm-generic/bitops/arch_parity.h b/include/asm-generic/bitops/arch_parity.h
new file mode 100644
index 0000000..813e152
--- /dev/null
+++ b/include/asm-generic/bitops/arch_parity.h
@@ -0,0 +1,39 @@
+#ifndef _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
+#define _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
+
+#include <asm/types.h>
+
+/*
+ * Refrence to 'https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel'.
+ */
+
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	w &= 0xf;
+	return ((PARITY_MAGIC) >> w) & 1;
+}
+
+static inline unsigned int __arch_parity8(unsigned int w)
+{
+	w ^= w >> 4;
+	return __arch_parity4(w);
+}
+
+static inline unsigned int __arch_parity16(unsigned int w)
+{
+	w ^= w >> 8;
+	return __arch_parity8(w);
+}
+
+static inline unsigned int __arch_parity32(unsigned int w)
+{
+	w ^= w >> 16;
+	return __arch_parity16(w);
+}
+
+static inline unsigned int __arch_parity64(__u64 w)
+{
+	return __arch_parity32((unsigned int)(w >> 32) ^ (unsigned int)w);
+}
+
+#endif /* _ASM_GENERIC_BITOPS_ARCH_PARITY_H_ */
diff --git a/include/asm-generic/bitops/const_parity.h b/include/asm-generic/bitops/const_parity.h
new file mode 100644
index 0000000..3970546
--- /dev/null
+++ b/include/asm-generic/bitops/const_parity.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BITOPS_CONST_PARITY_H_
+#define _ASM_GENERIC_BITOPS_CONST_PARITY_H_
+
+/*
+ * Compile time versions of __arch_parityN()
+ */
+#define __const_parity4(w)   (((PARITY_MAGIC) >> ((w) & 0xf)) & 1)
+#define __const_parity8(w)   (__const_parity4((w) ^ ((w) >> 4)))
+#define __const_parity16(w)  (__const_parity8((w) ^ ((w) >> 8)))
+#define __const_parity32(w)  (__const_parity16((w) ^ ((w) >> 16)))
+#define __const_parity64(w)  (__const_parity32((w) ^ ((w) >> 32)))
+
+/*
+ * Generic interface.
+ */
+#define parity4(w)   (__builtin_constant_p(w) ? __const_parity4(w)  : __arch_parity4(w))
+#define parity8(w)   (__builtin_constant_p(w) ? __const_parity8(w)  : __arch_parity8(w))
+#define parity16(w)  (__builtin_constant_p(w) ? __const_parity16(w) : __arch_parity16(w))
+#define parity32(w)  (__builtin_constant_p(w) ? __const_parity32(w) : __arch_parity32(w))
+#define parity64(w)  (__builtin_constant_p(w) ? __const_parity64(w) : __arch_parity64(w))
+
+/*
+ * Interface for known constant arguments
+ */
+#define PARITY4(w)   (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_parity4(w))
+#define PARITY8(w)   (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_parity8(w))
+#define PARITY16(w)  (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_parity16(w))
+#define PARITY32(w)  (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_parity32(w))
+#define PARITY64(w)  (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_parity64(w))
+
+/*
+ * Type invariant interface to the compile time constant parity functions.
+ */
+#define PARITY(w)    PARITY64((u64)(w))
+
+#endif /* _ASM_GENERIC_BITOPS_CONST_PARITY_H_ */
diff --git a/include/asm-generic/bitops/parity.h b/include/asm-generic/bitops/parity.h
new file mode 100644
index 0000000..a91dce7
--- /dev/null
+++ b/include/asm-generic/bitops/parity.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_GENERIC_BITOPS_PARITY_H_
+#define _ASM_GENERIC_BITOPS_PARITY_H_
+
+#include <asm-generic/bitops/arch_parity.h>
+#include <asm-generic/bitops/const_parity.h>
+
+#endif /* _ASM_GENERIC_BITOPS_PARITY_H_ */
diff --git a/include/asm-generic/bitops/popc-parity.h b/include/asm-generic/bitops/popc-parity.h
new file mode 100644
index 0000000..bf05999
--- /dev/null
+++ b/include/asm-generic/bitops/popc-parity.h
@@ -0,0 +1,32 @@
+#ifndef _ASM_GENERIC_BITOPS_POPC_PARITY_H_
+#define _ASM_GENERIC_BITOPS_POPC_PARITY_H_
+
+#include <asm/types.h>
+
+static inline unsigned int __arch_parity32(unsigned int w)
+{
+	return __builtin_popcount(w) & 1;
+}
+
+static inline unsigned int __arch_parity16(unsigned int w)
+{
+	return __arch_parity32(w & 0xffff);
+}
+
+static inline unsigned int __arch_parity8(unsigned int w)
+{
+	return __arch_parity32(w & 0xff);
+}
+
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	return __arch_parity32(w & 0xf);
+}
+
+static inline unsigned int __arch_parity64(__u64 w)
+{
+	return (unsigned int)__builtin_popcountll(w) & 1;
+}
+
+#endif
+
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index defeaac..c3ea19e 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -30,6 +30,11 @@ extern unsigned int __sw_hweight32(unsigned int w);
 extern unsigned long __sw_hweight64(__u64 w);
 
 /*
+ * a miniature 16-bit parity-table of 4-bit numbers
+ */
+#define	PARITY_MAGIC	0x6996
+
+/*
  * Include this here because some architectures need generic_ffs/fls in
  * scope
  */
@@ -80,6 +85,11 @@ static __always_inline unsigned long hweight_long(unsigned long w)
 	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
 }
 
+static __always_inline unsigned int parity_long(unsigned long w)
+{
+	return sizeof(w) == 4 ? parity32(w) : parity64(w);
+}
+
 /**
  * rol64 - rotate a 64-bit value left
  * @word: value to rotate
-- 
2.5.0
