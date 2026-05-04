Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E224304BA3
	for <linux-arch@vger.kernel.org>; Mon,  4 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880519; cv=none; b=idExOieEpVZ87t9pbaQfgsJdJmDADxjYoHTF2y2Y8NbgwEv0J8nyQO6EF5mekyjcslK2LUeUI3qAKLcjjDJNEffbqG8yfkrK3qWokYP9hNa2YgN3xTS7TeNAKdcC2BYDdUZ52mdlDe3hgwGPsdstC6Le5A9R9NtIhaSrW1KvFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880519; c=relaxed/simple;
	bh=GNdvAC8sHBx5/8S/Zejd93zYlV6/VkBsLGLLeTwRn2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fi0v9i7oRYgS841ubhjb4Bpwwp63X3VWuPt8Vpj6KiZUsNcYt4O3/1kmoai36xjnMz2hlkrd7Hh5+/lE+fHZbm8n6U+vrVtVWuUiIW9Wsi//UM2s6Oxt9rnpaonesZfmkwECG2ohmt4JC267O/xML2rnprLjkHD7HwgYxtVz0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1ugxktI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1ugxktI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777880516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SihS4JGcYsSmzE0brJNfGHdNWEU7ElGTdUVbaM8VyK0=;
	b=I1ugxktIlIZOc0EXvk3d7nlUFR7zsgpXhtU/+cnuN/eIZ2YkdWhCTGeXJBuk4jyAtwyeNX
	Ibdon83y+JzxiJwjLAZWv8z5xWdnLIq6jXQ/BsW94J7EACSQCHRVt5blIBsvI6n7LsLOqX
	QZb2+Rhl5ZLUuV1br5UPmPmtdbmQwJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-offhDADgPUiP1Zaj9PkHRg-1; Mon,
 04 May 2026 03:41:52 -0400
X-MC-Unique: offhDADgPUiP1Zaj9PkHRg-1
X-Mimecast-MFC-AGG-ID: offhDADgPUiP1Zaj9PkHRg_1777880509
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60108195608B;
	Mon,  4 May 2026 07:41:48 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66CC61955D84;
	Mon,  4 May 2026 07:41:40 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 04 May 2026 09:41:25 +0200
Subject: [PATCH v8 1/4] bug/kunit: Core support for suppressing warning
 backtraces
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-kunit_add_support-v8-1-3e5957cdd235@redhat.com>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
In-Reply-To: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777880489; l=18309;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=uN2I6Fp+4/YHL/oz10z31iz8wYI+THuQblw36b8ziNY=;
 b=FPH6CHtOk9//Vph8dml/BTJVFCUvNIPWO6dOpEmWF3MIdpOWF7KSeM9QnyTMoHc8/zhhP4gWB
 6LHRAVuQTYVCKQG4ofWYsOvPAbemtHmC1O14uPqPbi9VHm4MxaBnsd4
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

Solve the problem by providing a means to suppress warning backtraces
originating from the current kthread while executing test code. Since
each KUnit test runs in its own kthread, this effectively scopes
suppression to the test that enabled it. Limit changes to generic code
to the absolute minimum.

Implementation details:
Suppression is integrated into the existing KUnit hooks infrastructure
in test-bug.h, reusing the kunit_running static branch for zero
overhead when no tests are running.

Suppression is checked at three points in the warning path:
- In warn_slowpath_fmt(), the check runs before any output, fully
  suppressing both message and backtrace. This covers architectures
  without __WARN_FLAGS.
- In __warn_printk(), the check suppresses the warning message text.
  This covers architectures that define __WARN_FLAGS but not their own
  __WARN_printf (arm64, loongarch, parisc, powerpc, riscv, sh), where
  the message is printed before the trap enters __report_bug().
- In __report_bug(), the check runs before __warn() is called,
  suppressing the backtrace and stack dump.

To avoid double-counting on architectures where both __warn_printk()
and __report_bug() run for the same warning, kunit_is_suppressed_warning()
takes a bool parameter: true to increment the suppression counter
(used in warn_slowpath_fmt and __report_bug), false to check only
(used in __warn_printk).

The suppression state is dynamically allocated via kunit_kzalloc() and
tied to the KUnit test lifecycle via kunit_add_action(), ensuring
automatic cleanup at test exit. Writer-side access to the global
suppression list is serialized with a spinlock; readers use RCU.

Three API forms are provided:
- kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
  automatic teardown on scope exit, kunit_add_action() as safety net
  for abnormal exits (e.g. kthread_exit from failed assertions).
  Suppression handle is only accessible inside the block.
- KUNIT_START/END_SUPPRESSED_WARNING(test): manual macros for larger
  blocks or when warning counts need to be checked after suppression
  ends. Limited to one pair per scope.
- kunit_start/end_suppress_warning(test): direct functions returning
  an explicit handle, for retaining the handle within the test,
  or for cross-function usage.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/kunit/test-bug.h |  25 +++++++++
 include/kunit/test.h     | 138 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/panic.c           |  15 +++++-
 lib/bug.c                |  10 ++++
 lib/kunit/Makefile       |   3 +-
 lib/kunit/bug.c          | 115 +++++++++++++++++++++++++++++++++++++++
 lib/kunit/hooks-impl.h   |   2 +
 7 files changed, 305 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 47aa8f21ccce8..6237e48ceadfd 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -23,6 +23,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 extern struct kunit_hooks_table {
 	__printf(3, 4) void (*fail_current_test)(const char*, int, const char*, ...);
 	void *(*get_static_stub_address)(struct kunit *test, void *real_fn_addr);
+	bool (*is_suppressed_warning)(bool count);
 } kunit_hooks;
 
 /**
@@ -60,9 +61,33 @@ static inline struct kunit *kunit_get_current_test(void)
 		}								\
 	} while (0)
 
+/**
+ * kunit_is_suppressed_warning() - Check if warnings are being suppressed
+ *                                 by the current KUnit test.
+ * @count: if true, increment the suppression counter on match.
+ *
+ * Returns true if the current task has active warning suppression.
+ * Uses the kunit_running static branch for zero overhead when no tests run.
+ *
+ * A single WARN*() may traverse multiple call sites in the warning path
+ * (e.g., __warn_printk() and __report_bug()). Pass @count = true at the
+ * primary suppression point to count each warning exactly once, and
+ * @count = false at secondary points to suppress output without
+ * inflating the count.
+ */
+static inline bool kunit_is_suppressed_warning(bool count)
+{
+	if (!static_branch_unlikely(&kunit_running))
+		return false;
+
+	return kunit_hooks.is_suppressed_warning &&
+	       kunit_hooks.is_suppressed_warning(count);
+}
+
 #else
 
 static inline struct kunit *kunit_get_current_test(void) { return NULL; }
+static inline bool kunit_is_suppressed_warning(bool count) { return false; }
 
 #define kunit_fail_current_test(fmt, ...) do {} while (0)
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9cd1594ab697d..f278ec028019c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1795,4 +1795,142 @@ do {									       \
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
 
+/*
+ * Warning backtrace suppression API.
+ *
+ * Suppresses WARN*() backtraces on the current task while active. Three forms
+ * are provided, in order of convenience:
+ *
+ * - Scoped: kunit_warning_suppress(test) { ... }
+ *   Suppression is active for the duration of the block. On normal exit,
+ *   the for-loop increment deactivates suppression. On early exit (break,
+ *   return, goto), the __cleanup attribute fires. On kthread_exit() (e.g.,
+ *   a failed KUnit assertion), kunit_add_action() cleans up at test
+ *   teardown. The suppression handle is only accessible inside the block,
+ *   so warning counts must be checked before the block exits.
+ *
+ * - Manual macros: KUNIT_[START|END]_SUPPRESSED_WARNING(test)
+ *   Suppression spans an explicit range in the same scope. kunit_add_action()
+ *   guarantees cleanup even if KUNIT_END_SUPPRESSED_WARNING() is not reached.
+ *   Prefer this form when suppressing warnings across a large block where
+ *   extra indentation is undesirable, or when the warning count needs to be
+ *   checked after suppression ends. Limited to one pair per scope.
+ *
+ * - Direct: kunit_start_suppress_warning() / kunit_end_suppress_warning()
+ *   The underlying functions, returning an explicit handle pointer. Use
+ *   when the handle needs to be retained (e.g., for post-suppression
+ *   count checks) or passed across helper functions.
+ */
+struct kunit_suppressed_warning;
+
+struct kunit_suppressed_warning *
+kunit_start_suppress_warning(struct kunit *test);
+void kunit_end_suppress_warning(struct kunit *test,
+				struct kunit_suppressed_warning *w);
+int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w);
+void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **wp);
+bool kunit_has_active_suppress_warning(void);
+
+/**
+ * kunit_warning_suppress() - Suppress WARN*() backtraces for the duration
+ *                            of a block.
+ * @test: The test context object.
+ *
+ * Scoped form of the suppression API. Suppression starts when the block is
+ * entered and ends automatically when the block exits through any path. See
+ * the section comment above for the cleanup guarantees on each exit path.
+ * Fails the test if suppression is already active; nesting is not supported.
+ *
+ * The warning count can be checked inside the block via
+ * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(). The handle is not accessible
+ * after the block exits.
+ *
+ * Example::
+ *
+ *   kunit_warning_suppress(test) {
+ *       trigger_warning();
+ *       KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+ *   }
+ */
+#define kunit_warning_suppress(test)					\
+	for (struct kunit_suppressed_warning *__kunit_suppress		\
+	     __cleanup(__kunit_suppress_auto_cleanup) =			\
+	     kunit_start_suppress_warning(test);			\
+	     __kunit_suppress;						\
+	     kunit_end_suppress_warning(test, __kunit_suppress),	\
+	     __kunit_suppress = NULL)
+
+/**
+ * KUNIT_START_SUPPRESSED_WARNING() - Begin suppressing WARN*() backtraces.
+ * @test: The test context object.
+ *
+ * Manual form of the suppression API. Must be paired with
+ * KUNIT_END_SUPPRESSED_WARNING() in the same scope. See the section comment
+ * above for cleanup guarantees. Fails the test if suppression is already
+ * active; nesting is not supported. Limited to one pair per scope; use
+ * sequential kunit_warning_suppress() blocks or the direct function API
+ * when more than one suppression region is needed.
+ *
+ * Example::
+ *
+ *   KUNIT_START_SUPPRESSED_WARNING(test);
+ *   trigger_code_that_should_warn_once();
+ *   KUNIT_END_SUPPRESSED_WARNING(test);
+ *   KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+ */
+#define KUNIT_START_SUPPRESSED_WARNING(test)				\
+	struct kunit_suppressed_warning *__kunit_suppress =		\
+		kunit_start_suppress_warning(test)
+
+/**
+ * KUNIT_END_SUPPRESSED_WARNING() - End suppressing WARN*() backtraces.
+ * @test: The test context object.
+ *
+ * Deactivates suppression started by KUNIT_START_SUPPRESSED_WARNING().
+ * The warning count remains readable via KUNIT_SUPPRESSED_WARNING_COUNT()
+ * after this call.
+ */
+#define KUNIT_END_SUPPRESSED_WARNING(test)				\
+	kunit_end_suppress_warning(test, __kunit_suppress)
+
+/**
+ * KUNIT_SUPPRESSED_WARNING_COUNT() - Returns the suppressed warning count.
+ *
+ * Returns the number of WARN*() calls suppressed since the current
+ * suppression block started, or 0 if the handle is NULL. Usable inside a
+ * kunit_warning_suppress() block or after KUNIT_END_SUPPRESSED_WARNING().
+ */
+#define KUNIT_SUPPRESSED_WARNING_COUNT() \
+	kunit_suppressed_warning_count(__kunit_suppress)
+
+/**
+ * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT() - Sets an expectation that the
+ *                                           suppressed warning count equals
+ *                                           @expected.
+ * @test: The test context object.
+ * @expected: an expression that evaluates to the expected warning count.
+ *
+ * Sets an expectation that the number of suppressed WARN*() calls equals
+ * @expected. This is semantically equivalent to
+ * KUNIT_EXPECT_EQ(@test, KUNIT_SUPPRESSED_WARNING_COUNT(), @expected).
+ * See KUNIT_EXPECT_EQ() for more information.
+ */
+#define KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected) \
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
+
+/**
+ * KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT() - Sets an assertion that the
+ *                                           suppressed warning count equals
+ *                                           @expected.
+ * @test: The test context object.
+ * @expected: an expression that evaluates to the expected warning count.
+ *
+ * Sets an assertion that the number of suppressed WARN*() calls equals
+ * @expected. This is the same as KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(),
+ * except it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the
+ * assertion is not met.
+ */
+#define KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT(test, expected) \
+	KUNIT_ASSERT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index c78600212b6c1..697d8ca054bef 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <kunit/test-bug.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
-	bool rcu = warn_rcu_enter();
+	bool rcu;
 	struct warn_args args;
 
+	if (kunit_is_suppressed_warning(true))
+		return;
+
+	rcu = warn_rcu_enter();
+
 	pr_warn(CUT_HERE);
 
 	if (!fmt) {
@@ -1102,9 +1108,14 @@ EXPORT_SYMBOL(warn_slowpath_fmt);
 #else
 void __warn_printk(const char *fmt, ...)
 {
-	bool rcu = warn_rcu_enter();
+	bool rcu;
 	va_list args;
 
+	if (kunit_is_suppressed_warning(false))
+		return;
+
+	rcu = warn_rcu_enter();
+
 	pr_warn(CUT_HERE);
 
 	va_start(args, fmt);
diff --git a/lib/bug.c b/lib/bug.c
index 623c467a8b76c..a5cebde554ed8 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -48,6 +48,7 @@
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
 #include <linux/context_tracking.h>
+#include <kunit/test-bug.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -223,6 +224,15 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args = bug->flags & BUGFLAG_ARGS;
 
+#ifdef CONFIG_KUNIT
+	/*
+	 * Before the once logic so suppressed warnings do not consume
+	 * the single-fire budget of WARN_ON_ONCE().
+	 */
+	if (warning && kunit_is_suppressed_warning(true))
+		return BUG_TRAP_TYPE_WARN;
+#endif
+
 	if (warning && once) {
 		if (done)
 			return BUG_TRAP_TYPE_WARN;
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abcc..4592f9d0aa8dd 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -10,7 +10,8 @@ kunit-objs +=				test.o \
 					executor.o \
 					attributes.o \
 					device.o \
-					platform.o
+					platform.o \
+					bug.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
new file mode 100644
index 0000000000000..b0b6778d7399a
--- /dev/null
+++ b/lib/kunit/bug.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/resource.h>
+#include <linux/export.h>
+#include <linux/rculist.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+
+#include "hooks-impl.h"
+
+struct kunit_suppressed_warning {
+	struct list_head node;
+	struct task_struct *task;
+	struct kunit *test;
+	int counter;
+};
+
+static LIST_HEAD(suppressed_warnings);
+static DEFINE_SPINLOCK(suppressed_warnings_lock);
+
+static void kunit_suppress_warning_remove(struct kunit_suppressed_warning *w)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&suppressed_warnings_lock, flags);
+	list_del_rcu(&w->node);
+	spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
+	synchronize_rcu(); /* Wait for readers to finish */
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_suppress_warning_cleanup,
+			    kunit_suppress_warning_remove,
+			    struct kunit_suppressed_warning *);
+
+bool kunit_has_active_suppress_warning(void)
+{
+	return __kunit_is_suppressed_warning_impl(false);
+}
+EXPORT_SYMBOL_GPL(kunit_has_active_suppress_warning);
+
+struct kunit_suppressed_warning *
+kunit_start_suppress_warning(struct kunit *test)
+{
+	struct kunit_suppressed_warning *w;
+	unsigned long flags;
+	int ret;
+
+	if (kunit_has_active_suppress_warning()) {
+		KUNIT_FAIL(test, "Another suppression block is already active");
+		return NULL;
+	}
+
+	w = kunit_kzalloc(test, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return NULL;
+
+	w->task = current;
+	w->test = test;
+
+	spin_lock_irqsave(&suppressed_warnings_lock, flags);
+	list_add_rcu(&w->node, &suppressed_warnings);
+	spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
+
+	ret = kunit_add_action_or_reset(test,
+					kunit_suppress_warning_cleanup, w);
+	if (ret)
+		return NULL;
+
+	return w;
+}
+EXPORT_SYMBOL_GPL(kunit_start_suppress_warning);
+
+void kunit_end_suppress_warning(struct kunit *test,
+				struct kunit_suppressed_warning *w)
+{
+	if (!w)
+		return;
+	kunit_release_action(test, kunit_suppress_warning_cleanup, w);
+}
+EXPORT_SYMBOL_GPL(kunit_end_suppress_warning);
+
+void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **wp)
+{
+	if (*wp)
+		kunit_end_suppress_warning((*wp)->test, *wp);
+}
+EXPORT_SYMBOL_GPL(__kunit_suppress_auto_cleanup);
+
+int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w)
+{
+	return w ? w->counter : 0;
+}
+EXPORT_SYMBOL_GPL(kunit_suppressed_warning_count);
+
+bool __kunit_is_suppressed_warning_impl(bool count)
+{
+	struct kunit_suppressed_warning *w;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(w, &suppressed_warnings, node) {
+		if (w->task == current) {
+			if (count)
+				w->counter++;
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
index 4e71b2d0143ba..d8720f2616925 100644
--- a/lib/kunit/hooks-impl.h
+++ b/lib/kunit/hooks-impl.h
@@ -19,6 +19,7 @@ void __printf(3, 4) __kunit_fail_current_test_impl(const char *file,
 						   int line,
 						   const char *fmt, ...);
 void *__kunit_get_static_stub_address_impl(struct kunit *test, void *real_fn_addr);
+bool __kunit_is_suppressed_warning_impl(bool count);
 
 /* Code to set all of the function pointers. */
 static inline void kunit_install_hooks(void)
@@ -26,6 +27,7 @@ static inline void kunit_install_hooks(void)
 	/* Install the KUnit hook functions. */
 	kunit_hooks.fail_current_test = __kunit_fail_current_test_impl;
 	kunit_hooks.get_static_stub_address = __kunit_get_static_stub_address_impl;
+	kunit_hooks.is_suppressed_warning = __kunit_is_suppressed_warning_impl;
 }
 
 #endif /* _KUNIT_HOOKS_IMPL_H */

-- 
2.53.0

