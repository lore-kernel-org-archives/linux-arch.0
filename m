From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Sun, 27 Mar 2016 11:33:36 +0800
Message-ID: <56F75490.9010608@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33319 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbcC0De3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Mar 2016 23:34:29 -0400
In-Reply-To: <56F3A77D.6060802@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 2016/3/24 16:38, Denys Vlasenko wrote:
> On 03/24/2016 04:03 AM, Zhaoxiu Zeng wrote:
>> +/*
>> + * Type invariant interface to the compile time constant parity functions.
>> + */
>> +#define PARITY(w)    PARITY64((u64)w)
> 
> Can result in incorrect expansion of w. Should be PARITY64((u64)(w))
> 
> .
> 
Thanks. The new version has been fixed.


Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 include/asm-generic/bitops.h              |  1 +
 include/asm-generic/bitops/arch_parity.h  | 39 +++++++++++++++++++++++++++++++
 include/asm-generic/bitops/const_parity.h | 36 ++++++++++++++++++++++++++++
 include/asm-generic/bitops/parity.h       |  7 ++++++
 include/linux/bitops.h                    |  5 ++++
 5 files changed, 88 insertions(+)
 create mode 100644 include/asm-generic/bitops/arch_parity.h
 create mode 100644 include/asm-generic/bitops/const_parity.h
 create mode 100644 include/asm-generic/bitops/parity.h

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
index 0000000..cddc555
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
+	return (0x6996 >> w) & 1;
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
index 0000000..6af7987
--- /dev/null
+++ b/include/asm-generic/bitops/const_parity.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BITOPS_CONST_PARITY_H_
+#define _ASM_GENERIC_BITOPS_CONST_PARITY_H_
+
+/*
+ * Compile time versions of __arch_parityN()
+ */
+#define __const_parity4(w)   ((0x6996 >> ((w) & 0xf)) & 1)
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
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index defeaac..8952f88 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,11 @@ static __always_inline unsigned long hweight_long(unsigned long w)
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
2.5.5
