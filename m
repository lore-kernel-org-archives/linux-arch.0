Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B741C31C
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835215; cv=none; b=h6AheWX9Pe5BioNYBKseeK+A36mP3WGqX7SjKKLxxA/5+M4YsdK/1hywWc6tGD1bjOFYrX7Ru1KVzu6wpPEt8KEMwHUY1ImbKVJCapjX/Z5ckPRxZp9aj0/SHlmYKHNw8idWo3k1W1Yc60PtC2wVw/AYBWXrFaIOA5JCuC5gqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835215; c=relaxed/simple;
	bh=siPvvxSDR9D/nD+L/VuujMsjeVg62NnDkOzfBieUJ38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfAlm1dWQUldSYhRrJe1Oj+DrRGcAtJJOHmAAUyeNW9FWCvAX+N4ksjZVtF08LYyo4C4HGP538CDH6mdjBjutxHLbiCAVTcZPcPIj3D0ykhZzFsl4LdetajRPayJ8UqNN3pOnaksFR+50jUMw7tWgeHkbeczJqZz+5B4SxJ2CCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4Ong0zi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4Ong0zi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778835212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbQpMKcevS++aTCfiq6LCpCT2Etcw0pMnz1eArG6sPw=;
	b=h4Ong0zi6HZs3Mqrv+l/O0Ios/3gYqS7+Tentdaec3S8amRGhMyQuSsngxTBPBNbzVEU5p
	al9MrQx2Hj71K5bPv91RmcSz430y2hjSdfBHNYbQw3bvYsH7f0qUsVSzlYJd3FXPM+85rZ
	vGUKpPKwpve+F0zbfa+JnCIccagm7B4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-JBzra1UNM3ii7Sgm1uAPLQ-1; Fri,
 15 May 2026 04:53:28 -0400
X-MC-Unique: JBzra1UNM3ii7Sgm1uAPLQ-1
X-Mimecast-MFC-AGG-ID: JBzra1UNM3ii7Sgm1uAPLQ_1778835204
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9D2E18005B3;
	Fri, 15 May 2026 08:53:23 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E3091956053;
	Fri, 15 May 2026 08:53:15 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 10:52:51 +0200
Subject: [PATCH v12 2/4] kunit: Add backtrace suppression self-tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-kunit_add_support-v12-2-a216dc228be8@redhat.com>
References: <20260515-kunit_add_support-v12-0-a216dc228be8@redhat.com>
In-Reply-To: <20260515-kunit_add_support-v12-0-a216dc228be8@redhat.com>
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
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Dan Carpenter <error27@gmail.com>, 
 Kees Cook <kees@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835177; l=7437;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=fXyWbZzlWoIL12G+585gezsNpwYj6kS7sHf+I+BjxB8=;
 b=iBIb1SqBIMjQALBFLF0YLTfxD5qV8e6Gf+3Iz33GHBrXwKwHaeOTPOGiGkj5jJReSCRSZbCx/
 acQbgSVIW90DzirXwiHSxXXyy7Ahw1AxbVxBAc3rGLC3Q8GxPxMbzQA
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Guenter Roeck <linux@roeck-us.net>

Add unit tests to verify that warning backtrace suppression works.

Tests cover both API forms:
- Scoped: kunit_warning_suppress() with in-block count verification
  and post-block inactivity check.
- Direct functions: kunit_start/end_suppress_warning() with
  sequential independent suppression blocks and per-block counts.

Furthermore, tests verify incremental warning counting, that
kunit_has_active_suppress_warning() transitions correctly around
suppression boundaries, and that suppression active in the test
kthread does not leak to a separate kthread.

If backtrace suppression does _not_ work, the unit tests will likely
trigger unsuppressed backtraces, which should actually help to get
the affected architectures / platforms fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 lib/kunit/Makefile                     |   1 +
 lib/kunit/backtrace-suppression-test.c | 192 +++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 4592f9d0aa8dd..2e8a6b71a2ab0 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -22,6 +22,7 @@ obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
new file mode 100644
index 0000000000000..59a038b2739f5
--- /dev/null
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for suppressing warning tracebacks.
+ *
+ * Copyright (C) 2024, Guenter Roeck
+ * Author: Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/bug.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+
+static void backtrace_suppression_test_warn_direct(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		WARN(1, "This backtrace should be suppressed");
+		/*
+		 * Count must be checked inside the scope; the handle
+		 * is not accessible after the block exits.
+		 */
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
+}
+
+static noinline void trigger_backtrace_warn(void)
+{
+	WARN(1, "This backtrace should be suppressed");
+}
+
+static void backtrace_suppression_test_warn_indirect(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		trigger_backtrace_warn();
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+static void backtrace_suppression_test_warn_multi(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		WARN(1, "This backtrace should be suppressed");
+		trigger_backtrace_warn();
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
+	}
+}
+
+static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		WARN_ON(1);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+static noinline void trigger_backtrace_warn_on(void)
+{
+	WARN_ON(1);
+}
+
+static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		trigger_backtrace_warn_on();
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+static void backtrace_suppression_test_count(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+
+		WARN(1, "suppressed");
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+
+		WARN(1, "suppressed again");
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
+	}
+}
+
+static void backtrace_suppression_test_active_state(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
+
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_TRUE(test, kunit_has_active_suppress_warning());
+	}
+
+	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
+
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_TRUE(test, kunit_has_active_suppress_warning());
+	}
+
+	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
+}
+
+static void backtrace_suppression_test_multi_scope(struct kunit *test)
+{
+	struct kunit_suppressed_warning *sw1, *sw2;
+
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	sw1 = kunit_start_suppress_warning(test);
+	trigger_backtrace_warn_on();
+	WARN(1, "suppressed by sw1");
+	kunit_end_suppress_warning(test, sw1);
+
+	sw2 = kunit_start_suppress_warning(test);
+	WARN(1, "suppressed by sw2");
+	kunit_end_suppress_warning(test, sw2);
+
+	KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(sw1), 2);
+	KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(sw2), 1);
+}
+
+struct cross_kthread_data {
+	bool was_active;
+	struct completion done;
+};
+
+static int cross_kthread_fn(void *data)
+{
+	struct cross_kthread_data *d = data;
+
+	d->was_active = kunit_has_active_suppress_warning();
+	complete(&d->done);
+	while (!kthread_should_stop())
+		schedule();
+	return 0;
+}
+
+static void backtrace_suppression_test_cross_kthread(struct kunit *test)
+{
+	struct cross_kthread_data data;
+	struct task_struct *task;
+
+	data.was_active = false;
+	init_completion(&data.done);
+
+	kunit_warning_suppress(test) {
+		task = kthread_run(cross_kthread_fn, &data, "kunit-cross-test");
+		KUNIT_ASSERT_FALSE(test, IS_ERR(task));
+		wait_for_completion(&data.done);
+		kthread_stop(task);
+	}
+
+	KUNIT_EXPECT_FALSE(test, data.was_active);
+}
+
+static struct kunit_case backtrace_suppression_test_cases[] = {
+	KUNIT_CASE(backtrace_suppression_test_warn_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
+	KUNIT_CASE(backtrace_suppression_test_warn_multi),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
+	KUNIT_CASE(backtrace_suppression_test_count),
+	KUNIT_CASE(backtrace_suppression_test_active_state),
+	KUNIT_CASE(backtrace_suppression_test_multi_scope),
+	KUNIT_CASE(backtrace_suppression_test_cross_kthread),
+	{}
+};
+
+static struct kunit_suite backtrace_suppression_test_suite = {
+	.name = "backtrace-suppression-test",
+	.test_cases = backtrace_suppression_test_cases,
+};
+kunit_test_suites(&backtrace_suppression_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression");

-- 
2.53.0

