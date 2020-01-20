From: Marco Elver <elver@google.com>
Subject: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
Date: Mon, 20 Jan 2020 15:19:23 +0100
Message-ID: <20200120141927.114373-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f73.google.com ([209.85.221.73]:55712 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATOTo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:19:44 -0500
Received: by mail-wr1-f73.google.com with SMTP id b13so14127873wrx.22
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:19:41 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: paulmck@kernel.org, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org

This adds instrumented.h, which provides generic wrappers for memory
access instrumentation that the compiler cannot emit for various
sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
future this will also include KMSAN instrumentation.

Note that, copy_{to,from}_user require special instrumentation,
providing hooks before and after the access, since we may need to know
the actual bytes accessed (currently this is relevant for KCSAN, and is
also relevant in future for KMSAN).

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 include/linux/instrumented.h

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
new file mode 100644
index 000000000000..9f83c8520223
--- /dev/null
+++ b/include/linux/instrumented.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This header provides generic wrappers for memory access instrumentation that
+ * the compiler cannot emit for: KASAN, KCSAN.
+ */
+#ifndef _LINUX_INSTRUMENTED_H
+#define _LINUX_INSTRUMENTED_H
+
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+#include <linux/types.h>
+
+/**
+ * instrument_read - instrument regular read access
+ *
+ * Instrument a regular read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_read(v, size);
+}
+
+/**
+ * instrument_write - instrument regular write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_write(v, size);
+}
+
+/**
+ * instrument_atomic_read - instrument atomic read access
+ *
+ * Instrument an atomic read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_atomic_read(v, size);
+}
+
+/**
+ * instrument_atomic_write - instrument atomic write access
+ *
+ * Instrument an atomic write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_write(v, size);
+}
+
+/**
+ * instrument_copy_to_user_pre - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted before the accesses. At this point the
+ * actual number of bytes accessed is not yet known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ */
+static __always_inline void
+instrument_copy_to_user_pre(const volatile void *src, size_t size)
+{
+	/* Check before, to warn before potential memory corruption. */
+	kasan_check_read(src, size);
+}
+
+/**
+ * instrument_copy_to_user_post - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted after the accesses. At this point the
+ * actual number of bytes accessed should be known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ * @left number of bytes left that were not copied
+ */
+static __always_inline void
+instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
+{
+	/* Check after, to avoid false positive if memory was not accessed. */
+	kcsan_check_read(src, size - left);
+}
+
+/**
+ * instrument_copy_from_user_pre - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted before the accesses. At this point the
+ * actual number of bytes accessed is not yet known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ */
+static __always_inline void
+instrument_copy_from_user_pre(const volatile void *dst, size_t size)
+{
+	/* Check before, to warn before potential memory corruption. */
+	kasan_check_write(dst, size);
+}
+
+/**
+ * instrument_copy_from_user_post - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted after the accesses. At this point the
+ * actual number of bytes accessed should be known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ * @left number of bytes left that were not copied
+ */
+static __always_inline void
+instrument_copy_from_user_post(const volatile void *dst, size_t size, size_t left)
+{
+	/* Check after, to avoid false positive if memory was not accessed. */
+	kcsan_check_write(dst, size - left);
+}
+
+#endif /* _LINUX_INSTRUMENTED_H */
-- 
2.25.0.341.g760bfbb309-goog
