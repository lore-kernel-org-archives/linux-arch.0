From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 05/15] Provide atomic64_t and atomic_long_t using ISO
 atomics
Date: Wed, 18 May 2016 16:11:15 +0100
Message-ID: <146358427535.8596.8108992009596880343.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Provide an implemention of atomic64_t and atomic_long_t using the ISO
atomic template previously added.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/iso-atomic-long.h |   32 ++++++++++++++++++++++++++++++++
 include/asm-generic/iso-atomic64.h    |   28 ++++++++++++++++++++++++++++
 include/linux/atomic.h                |   13 +++++++++++--
 3 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 include/asm-generic/iso-atomic-long.h
 create mode 100644 include/asm-generic/iso-atomic64.h

diff --git a/include/asm-generic/iso-atomic-long.h b/include/asm-generic/iso-atomic-long.h
new file mode 100644
index 000000000000..1340ae346e94
--- /dev/null
+++ b/include/asm-generic/iso-atomic-long.h
@@ -0,0 +1,32 @@
+/* Use ISO C++11 intrinsics to implement long atomic ops.
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _ASM_GENERIC_ISO_ATOMIC_LONG_H
+#define _ASM_GENERIC_ISO_ATOMIC_LONG_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+typedef struct {
+	long counter;
+} atomic_long_t;
+
+#define ATOMIC_LONG_INIT(i)	{ (i) }
+
+#define atomic_val long
+#define atomic_prefix(x) atomic_long##x
+#define __atomic_prefix(x) __atomic_long##x
+#include <asm-generic/iso-atomic-template.h>
+#undef atomic_val
+#undef atomic_prefix
+#undef __atomic_prefix
+
+#endif /* _ASM_GENERIC_ISO_ATOMIC_LONG_H */
diff --git a/include/asm-generic/iso-atomic64.h b/include/asm-generic/iso-atomic64.h
new file mode 100644
index 000000000000..6624a69e2bad
--- /dev/null
+++ b/include/asm-generic/iso-atomic64.h
@@ -0,0 +1,28 @@
+/* Use ISO C++11 intrinsics to implement 64-bit atomic ops.
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _ASM_GENERIC_ISO_ATOMIC64_H
+#define _ASM_GENERIC_ISO_ATOMIC64_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define ATOMIC64_INIT(i)	{ (i) }
+
+#define atomic_val long long
+#define atomic_prefix(x) atomic64##x
+#define __atomic_prefix(x) __atomic64##x
+#include <asm-generic/iso-atomic-template.h>
+#undef atomic_val
+#undef atomic_prefix
+#undef __atomic_prefix
+
+#endif /* _ASM_GENERIC_ISO_ATOMIC64_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 64d2b7492ad6..18709106065a 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -213,8 +213,9 @@
 #endif
 #endif /* atomic_cmpxchg_relaxed */
 
-#endif /* _ASM_GENERIC_ISO_ATOMIC_H */
+#endif /* !_ASM_GENERIC_ISO_ATOMIC_H */
 
+#ifndef _ASM_GENERIC_ISO_ATOMIC64_H
 
 #ifndef atomic64_read_acquire
 #define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
@@ -369,6 +370,8 @@
 #endif
 #endif /* atomic64_cmpxchg_relaxed */
 
+#endif /* !_ASM_GENERIC_ISO_ATOMIC64_H */
+
 /* cmpxchg_relaxed */
 #ifndef cmpxchg_relaxed
 #define  cmpxchg_relaxed		cmpxchg
@@ -587,7 +590,9 @@ static inline int atomic_fetch_or(atomic_t *p, int mask)
 }
 #endif
 
-#endif /* _ASM_GENERIC_ISO_ATOMIC_H */
+#endif /* !_ASM_GENERIC_ISO_ATOMIC_H */
+
+#ifndef _ASM_GENERIC_ISO_ATOMIC64_H
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
@@ -600,6 +605,10 @@ static inline void atomic64_andnot(long long i, atomic64_t *v)
 }
 #endif
 
+#endif /* !_ASM_GENERIC_ISO_ATOMIC64_H */
+
+#ifndef _ASM_GENERIC_ISO_ATOMIC_LONG_H
 #include <asm-generic/atomic-long.h>
+#endif /* !_ASM_GENERIC_ISO_ATOMIC_LONG_H */
 
 #endif /* _LINUX_ATOMIC_H */
