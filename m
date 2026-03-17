Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE060396D2A
	for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739511; cv=none; b=LVR2EXZhZ1ZNNs/io/wXKI//S++nS+u2KhQg39/VeglxmG9Pinc5Fdz3eS60wEVxRhGOxDd7JdQ2p51hfBXzqxuYe1pX5N0DEZZJG5Repm8oiu7leB7U1w8iBEmMsPBEOMl9FD1nYJjCKOj0tQ22emXOIC0Ec+BO9uPvoZfSNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739511; c=relaxed/simple;
	bh=CmX/LqdIOJS1Ct1RBcik9DLTDYba7/p3qMd9LakEEKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGFKd63L23+o898uZzH6pg+SUvhmfX9sI6ctq0pYgA/pYw+5D3B1A87LfsJszk5tm3QkKCoe9GLqfbtpKTBeA7Kc9bCetpVsq9DWKgOaTsCMVb9HIapJ4ZMPJvpYEOffvzH1JJvlXOLTl2wwpzEQhiMF6MU0JqZvlgl2T9GMoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Myrm/579; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Myrm/579"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773739508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vl38m1bfQraLOcvKSMlDF9R7LfHO8MoiUxQ5e03K4cE=;
	b=Myrm/579n8ubx+a+nz1Vv9J6FjLJ2O5w2ZjdUoSPlgeqj4lMl4IZtNb/qYzreXkg1kLlDs
	fFOOk8XS3oUfpefUY+n8luN2YXPV1WQ8Re7ItmRFQxfPXPp/Q9NlQ7eAwO41eAaiMYDjzU
	XKyvfoZg49DgUhfdVAUPronk67fv6Vg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-UMz29TRVM6qwxuPwb0y7-A-1; Tue,
 17 Mar 2026 05:25:07 -0400
X-MC-Unique: UMz29TRVM6qwxuPwb0y7-A-1
X-Mimecast-MFC-AGG-ID: UMz29TRVM6qwxuPwb0y7-A_1773739504
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED05018002DD;
	Tue, 17 Mar 2026 09:25:03 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95F621800576;
	Tue, 17 Mar 2026 09:24:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Mar 2026 10:24:41 +0100
Subject: [PATCH v6 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-kunit_add_support-v6-1-dd22aeb3fe5d@redhat.com>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
In-Reply-To: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773739485; l=10954;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=9HDzKd2Q+voitfuDwnjvb0TVH3+Mu4gPG+q0/QE7BAQ=;
 b=upqDoz1QY8TvBDSLFwGn2/f4tjZfHSWNQJI8mG6XunJuXaMDpwmkOShrxyt1Qx8LKUAREE/xV
 7+94VvRYSS4D3cBQZaa+Poe5o1PhH9yy2A2PN4ZRqFwMDRK0vc6j6Vs
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Alessandro Carminati <acarmina@redhat.com>

Some unit tests intentionally trigger warning backtraces by passing bad
parameters to kernel API functions. Such unit tests typically check the
return value from such calls, not the existence of the warning backtrace.

Such intentionally generated warning backtraces are neither desirable
nor useful for a number of reasons:
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

Solve the problem by providing a means to identify and suppress specific
warning backtraces while executing test code. Support suppressing multiple
backtraces while at the same time limiting changes to generic code to the
absolute minimum.

Implementation details:
Check suppression directly in the `WARN()` Macros.
This avoids the need for function symbol resolution or ELF section
modification.
Use unlikely() with KUNIT_IS_SUPPRESSED_WARNING() in the Macros
so the common case (no suppression) stays on the hot path,
improving performance and keeping the critical path smaller.

A helper function, `__kunit_is_suppressed_warning()`, is used to determine
whether suppression applies. It is marked as `noinstr`, since some
`WARN*()` sites reside in non-instrumentable sections. As it uses `strcmp`,
which is not `noinstr`-safe, its use is wrapped within
`__kunit_check_suppress()` and surounded by instrumentation_begin()/end()
calls.

The list of supressed warnings includes RCU protection.

The implementation is deliberately simple and avoids architecture-specific
optimizations to preserve portability.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/asm-generic/bug.h | 44 ++++++++++++++++++++++------------
 include/kunit/bug.h       | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 include/kunit/test.h      |  1 +
 lib/kunit/Kconfig         |  9 +++++++
 lib/kunit/Makefile        |  6 +++--
 lib/kunit/bug.c           | 59 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 163 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 09e8eccee8ed9..7c766fde49a90 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -27,6 +27,7 @@
 #endif /* WARN_CONDITION_STR */
 
 #ifndef __ASSEMBLY__
+#include <kunit/bug.h>
 #include <linux/panic.h>
 #include <linux/printk.h>
 
@@ -71,9 +72,13 @@ struct bug_entry {
  */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
-	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
-	barrier_before_unreachable(); \
-	panic("BUG!"); \
+	if (!unlikely(KUNIT_IS_SUPPRESSED_WARNING(__func__))) {		\
+		printk("BUG: failure at %s:%d/%s()!\n", __FILE__,	\
+			__LINE__, __func__);				\
+		barrier_before_unreachable();				\
+		panic("BUG!");						\
+	}								\
+	__builtin_unreachable();					\
 } while (0)
 #endif
 
@@ -129,18 +134,23 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #if defined(__WARN_FLAGS) && !defined(__WARN_printf)
 #define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
-		__warn_printk(arg);					\
-		__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
-		instrumentation_end();					\
+		if (!unlikely(KUNIT_IS_SUPPRESSED_WARNING(__func__))) {	\
+			instrumentation_begin();			\
+			__warn_printk(arg);				\
+			__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE |		\
+				     BUGFLAG_TAINT(taint));		\
+			instrumentation_end();				\
+		}							\
 	} while (0)
 #endif
 
 #ifndef __WARN_printf
-#define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
-		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
-		instrumentation_end();					\
+#define __WARN_printf(taint, arg...) do {					\
+		if (!unlikely(KUNIT_IS_SUPPRESSED_WARNING(__func__))) {		\
+			instrumentation_begin();				\
+			warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
+			instrumentation_end();					\
+		}								\
 	} while (0)
 #endif
 
@@ -153,7 +163,8 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #ifndef WARN_ON
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on) &&					\
+	    !unlikely(KUNIT_IS_SUPPRESSED_WARNING(__func__)))		\
 		__WARN();						\
 	unlikely(__ret_warn_on);					\
 })
@@ -170,7 +181,8 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #define WARN_TAINT(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
-	if (unlikely(__ret_warn_on))					\
+	if (unlikely(__ret_warn_on) &&					\
+	    !unlikely(KUNIT_IS_SUPPRESSED_WARNING(__func__)))		\
 		__WARN_printf(taint, format);				\
 	unlikely(__ret_warn_on);					\
 })
@@ -191,8 +203,10 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do {		\
-	do {} while (1);	\
-	unreachable();		\
+	if (!unlikely(KUNIT_IS_SUPPRESSED_WARNING(__func__))) {	\
+		do {} while (1);				\
+	}							\
+	unreachable();						\
 } while (0)
 #endif
 
diff --git a/include/kunit/bug.h b/include/kunit/bug.h
new file mode 100644
index 0000000000000..9a5cd226c2139
--- /dev/null
+++ b/include/kunit/bug.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#ifndef _KUNIT_BUG_H
+#define _KUNIT_BUG_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/kconfig.h>
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+
+#include <linux/stringify.h>
+#include <linux/types.h>
+
+struct __suppressed_warning {
+	struct list_head node;
+	const char *function;
+	int counter;
+};
+
+void __kunit_start_suppress_warning(struct __suppressed_warning *warning);
+void __kunit_end_suppress_warning(struct __suppressed_warning *warning);
+bool __kunit_is_suppressed_warning(const char *function);
+
+#define KUNIT_DEFINE_SUPPRESSED_WARNING(func)	\
+	struct __suppressed_warning __kunit_suppress_##func = \
+		{ .function = __stringify(func), .counter = 0 }
+
+#define KUNIT_START_SUPPRESSED_WARNING(func) \
+	__kunit_start_suppress_warning(&__kunit_suppress_##func)
+
+#define KUNIT_END_SUPPRESSED_WARNING(func) \
+	__kunit_end_suppress_warning(&__kunit_suppress_##func)
+
+#define KUNIT_IS_SUPPRESSED_WARNING(func) \
+	__kunit_is_suppressed_warning(func)
+
+#define KUNIT_SUPPRESSED_WARNING_COUNT(func) \
+	(__kunit_suppress_##func.counter)
+
+#define KUNIT_SUPPRESSED_WARNING_COUNT_RESET(func) \
+	__kunit_suppress_##func.counter = 0
+
+#else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
+#define KUNIT_DEFINE_SUPPRESSED_WARNING(func)
+#define KUNIT_START_SUPPRESSED_WARNING(func)
+#define KUNIT_END_SUPPRESSED_WARNING(func)
+#define KUNIT_IS_SUPPRESSED_WARNING(func) ((void)(func), false)
+#define KUNIT_SUPPRESSED_WARNING_COUNT(func) ((void)(func), 0)
+#define KUNIT_SUPPRESSED_WARNING_COUNT_RESET(func)
+
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+#endif /* __ASSEMBLY__ */
+#endif /* _KUNIT_BUG_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9cd1594ab697d..4ec07b3fa0204 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -10,6 +10,7 @@
 #define _KUNIT_TEST_H
 
 #include <kunit/assert.h>
+#include <kunit/bug.h>
 #include <kunit/try-catch.h>
 
 #include <linux/args.h>
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 498cc51e493dc..57527418fcf09 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,6 +15,15 @@ menuconfig KUNIT
 
 if KUNIT
 
+config KUNIT_SUPPRESS_BACKTRACE
+	bool "KUnit - Enable backtrace suppression"
+	default y
+	help
+	  Enable backtrace suppression for KUnit. If enabled, backtraces
+	  generated intentionally by KUnit tests are suppressed. Disable
+	  to reduce kernel image size if image size is more important than
+	  suppression of backtraces generated by KUnit tests.
+
 config KUNIT_DEBUGFS
 	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abcc..fe177ff3ebdef 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -16,8 +16,10 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
 
-# KUnit 'hooks' are built-in even when KUnit is built as a module.
-obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
+# KUnit 'hooks' and bug handling are built-in even when KUnit is built
+# as a module.
+obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o \
+					bug.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
new file mode 100644
index 0000000000000..53c98e225a895
--- /dev/null
+++ b/lib/kunit/bug.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/bug.h>
+#include <linux/export.h>
+#include <linux/instrumentation.h>
+#include <linux/rculist.h>
+#include <linux/string.h>
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+
+static LIST_HEAD(suppressed_warnings);
+
+void __kunit_start_suppress_warning(struct __suppressed_warning *warning)
+{
+	list_add_rcu(&warning->node, &suppressed_warnings);
+}
+EXPORT_SYMBOL_GPL(__kunit_start_suppress_warning);
+
+void __kunit_end_suppress_warning(struct __suppressed_warning *warning)
+{
+	list_del_rcu(&warning->node);
+	synchronize_rcu(); /* Wait for readers to finish */
+}
+EXPORT_SYMBOL_GPL(__kunit_end_suppress_warning);
+
+static bool __kunit_check_suppress(const char *function)
+{
+	struct __suppressed_warning *warning;
+
+	if (!function)
+		return false;
+
+	list_for_each_entry(warning, &suppressed_warnings, node) {
+		if (!strcmp(function, warning->function)) {
+			warning->counter++;
+			return true;
+		}
+	}
+	return false;
+}
+
+noinstr bool __kunit_is_suppressed_warning(const char *function)
+{
+	bool ret;
+
+	instrumentation_begin();
+	ret = __kunit_check_suppress(function);
+	instrumentation_end();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning);
+
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */

-- 
2.52.0

