Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0239EF2E
	for <linux-arch@vger.kernel.org>; Mon, 20 Apr 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688146; cv=none; b=lCWHwhe6ho9PnMpyeRtB4QeuxVDCGyFzjUvQ48oqcFm/0AebMw8ViR45mw8vLpoghikLx07cjm+UTS+2KPzwJmppVVTlUr6uLR8cxeg4RROvRVL6OLnwXzCgeAIYdKnq82R19JQqZNHtiFwytNQUljwtGrElQT1hp+mqnOUfh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688146; c=relaxed/simple;
	bh=4JF8gOEh/HS+eUiXFDV8H5Abhszo/6+xEqvSdS9CeHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1mdYC4QL6eHBVPAE8oJjbe+tpZrL374N+YnpBZ4CnBE+kWJg8gbIDe2/5ruCGP60xgPAlwTVXfHoq/MSUfWlIRKEIL8nMq2VJEzuHMpGKX5NMNWNOJNnEnG/GagdzrYO/KHqRt6vAecGGIyfLU4hYe9Guqg8J1khwnR3glI3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i60gYP1x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i60gYP1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776688143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N4SvvqpPGCuU/adH/G6UTKOPrktX0llzktW7X+FgjU=;
	b=i60gYP1xOd0WAy4S1FJfaQdtC+SFh1kynTSSDPS/zAsfg8jYVXq1YkvUQlzMXseQuiwvUF
	6YwFwgQvntLUdFjGzq8WIo0/QXkGoElqX8P8PyMoOhdqRxDvaocGXFDJaHZfhr6fD96mPK
	1uu4dibgW0QJ2tDO94fs0JglcauR1AE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-0ey2KhuUN9mfzBGbMlVSJA-1; Mon,
 20 Apr 2026 08:28:58 -0400
X-MC-Unique: 0ey2KhuUN9mfzBGbMlVSJA-1
X-Mimecast-MFC-AGG-ID: 0ey2KhuUN9mfzBGbMlVSJA_1776688135
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB2941955DE7;
	Mon, 20 Apr 2026 12:28:54 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4BF01956095;
	Mon, 20 Apr 2026 12:28:48 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 20 Apr 2026 14:28:03 +0200
Subject: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
In-Reply-To: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, peterz@infradead.org, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776688120; l=9766;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=cU5oxy+g0dVHWrerOQavnsmQiSz63wvfOWBi6ZWSwKQ=;
 b=9JWW2WOxVcp5V6/9UiYZcoM7smEZ5323qcNeaChqmmbB0TJUJWZz0RFJ2ug5UJUnLHmbsxQOg
 Hozfkn9+8lNAwI33hN9e738JCMQPmtcyFAnmzV+P7Mwg9lYXXKBXecV
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
Suppression is checked at two points in the warning path:
- In warn_slowpath_fmt(), the check runs before any output, fully
  suppressing both message and backtrace.
- In __report_bug(), the check runs before __warn() is called,
  suppressing the backtrace and stack dump. Note that on this path,
  the WARN() format message may still appear in the kernel log since
  __warn_printk() runs before the trap that enters __report_bug().

A helper function, `__kunit_is_suppressed_warning()`, walks an
RCU-protected list of active suppressions, matching by current task.
The suppression state is tied to the KUnit test lifecycle via
kunit_add_action(), ensuring automatic cleanup at test exit.

The list of suppressed warnings is protected with RCU to allow
concurrent read access without locks.

The implementation is deliberately simple and avoids architecture-specific
optimizations to preserve portability.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/kunit/bug.h  | 56 +++++++++++++++++++++++++++++++++++
 include/kunit/test.h |  1 +
 kernel/panic.c       |  8 ++++-
 lib/bug.c            |  8 +++++
 lib/kunit/Kconfig    |  9 ++++++
 lib/kunit/Makefile   |  6 ++--
 lib/kunit/bug.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 169 insertions(+), 3 deletions(-)

diff --git a/include/kunit/bug.h b/include/kunit/bug.h
new file mode 100644
index 0000000000000..e52c9d21d9fe6
--- /dev/null
+++ b/include/kunit/bug.h
@@ -0,0 +1,56 @@
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
+struct kunit;
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+
+#include <linux/types.h>
+
+struct task_struct;
+
+struct __suppressed_warning {
+	struct list_head node;
+	struct task_struct *task;
+	int counter;
+};
+
+struct __suppressed_warning *
+__kunit_start_suppress_warning(struct kunit *test);
+void __kunit_end_suppress_warning(struct kunit *test,
+				  struct __suppressed_warning *warning);
+int __kunit_suppressed_warning_count(struct __suppressed_warning *warning);
+bool __kunit_is_suppressed_warning(void);
+
+#define KUNIT_START_SUPPRESSED_WARNING(test) \
+	struct __suppressed_warning *__kunit_suppress =	\
+		__kunit_start_suppress_warning(test)
+
+#define KUNIT_END_SUPPRESSED_WARNING(test) \
+	__kunit_end_suppress_warning(test, __kunit_suppress)
+
+#define KUNIT_SUPPRESSED_WARNING_COUNT() \
+	__kunit_suppressed_warning_count(__kunit_suppress)
+
+#else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
+#define KUNIT_START_SUPPRESSED_WARNING(test)
+#define KUNIT_END_SUPPRESSED_WARNING(test)
+#define KUNIT_SUPPRESSED_WARNING_COUNT() 0
+static inline bool __kunit_is_suppressed_warning(void) { return false; }
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
diff --git a/kernel/panic.c b/kernel/panic.c
index c78600212b6c1..d7a7a679f56c4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <kunit/bug.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
-	bool rcu = warn_rcu_enter();
+	bool rcu;
 	struct warn_args args;
 
+	if (__kunit_is_suppressed_warning())
+		return;
+
+	rcu = warn_rcu_enter();
+
 	pr_warn(CUT_HERE);
 
 	if (!fmt) {
diff --git a/lib/bug.c b/lib/bug.c
index 623c467a8b76c..606205c8c302f 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -48,6 +48,7 @@
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
 #include <linux/context_tracking.h>
+#include <kunit/bug.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -223,6 +224,13 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args = bug->flags & BUGFLAG_ARGS;
 
+	/*
+	 * Before the once logic so suppressed warnings do not consume
+	 * the single-fire budget of WARN_ON_ONCE().
+	 */
+	if (warning && __kunit_is_suppressed_warning())
+		return BUG_TRAP_TYPE_WARN;
+
 	if (warning && once) {
 		if (done)
 			return BUG_TRAP_TYPE_WARN;
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
index 0000000000000..356c8a5928828
--- /dev/null
+++ b/lib/kunit/bug.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/bug.h>
+#include <kunit/resource.h>
+#include <linux/export.h>
+#include <linux/rculist.h>
+#include <linux/sched.h>
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+
+static LIST_HEAD(suppressed_warnings);
+
+static void __kunit_suppress_warning_remove(struct __suppressed_warning *warning)
+{
+	list_del_rcu(&warning->node);
+	synchronize_rcu(); /* Wait for readers to finish */
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(__kunit_suppress_warning_cleanup,
+			    __kunit_suppress_warning_remove,
+			    struct __suppressed_warning *);
+
+struct __suppressed_warning *
+__kunit_start_suppress_warning(struct kunit *test)
+{
+	struct __suppressed_warning *warning;
+	int ret;
+
+	warning = kunit_kzalloc(test, sizeof(*warning), GFP_KERNEL);
+	if (!warning)
+		return NULL;
+
+	warning->task = current;
+	list_add_rcu(&warning->node, &suppressed_warnings);
+
+	ret = kunit_add_action_or_reset(test,
+					__kunit_suppress_warning_cleanup,
+					warning);
+	if (ret)
+		return NULL;
+
+	return warning;
+}
+EXPORT_SYMBOL_GPL(__kunit_start_suppress_warning);
+
+void __kunit_end_suppress_warning(struct kunit *test,
+				  struct __suppressed_warning *warning)
+{
+	if (!warning)
+		return;
+	kunit_release_action(test, __kunit_suppress_warning_cleanup, warning);
+}
+EXPORT_SYMBOL_GPL(__kunit_end_suppress_warning);
+
+int __kunit_suppressed_warning_count(struct __suppressed_warning *warning)
+{
+	return warning ? warning->counter : 0;
+}
+EXPORT_SYMBOL_GPL(__kunit_suppressed_warning_count);
+
+bool __kunit_is_suppressed_warning(void)
+{
+	struct __suppressed_warning *warning;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
+		if (warning->task == current) {
+			warning->counter++;
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */

-- 
2.52.0

