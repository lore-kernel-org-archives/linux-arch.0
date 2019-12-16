From: Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC v1 3/6] kunit: test: create a single centralized executor for
 all tests
Date: Mon, 16 Dec 2019 14:05:52 -0800
Message-ID: <20191216220555.245089-4-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

Add a centralized executor to dispatch tests rather than relying on
late_initcall to schedule each test suite separately.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 include/kunit/test.h |  7 ++-----
 lib/kunit/Makefile   |  3 ++-
 lib/kunit/executor.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 6 deletions(-)
 create mode 100644 lib/kunit/executor.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba48304b3bd3..c070798ebb765 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -217,11 +217,8 @@ int kunit_run_tests(struct kunit_suite *suite);
  * everything else is definitely initialized.
  */
 #define kunit_test_suite(suite)						       \
-	static int kunit_suite_init##suite(void)			       \
-	{								       \
-		return kunit_run_tests(&suite);				       \
-	}								       \
-	late_initcall(kunit_suite_init##suite)
+	static struct kunit_suite *__kunit_suite_##suite		       \
+	__used __aligned(8) __section(.kunit_test_suites) = &suite
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 769d9402b5d3a..893df8a685880 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,7 +1,8 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					assert.o \
-					try-catch.o
+					try-catch.o \
+					executor.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
 					string-stream-test.o
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
new file mode 100644
index 0000000000000..978086cfd257d
--- /dev/null
+++ b/lib/kunit/executor.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <kunit/test.h>
+
+/*
+ * These symbols point to the .kunit_test_suites section and are defined in
+ * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
+ */
+extern struct kunit_suite *__kunit_suites_start[];
+extern struct kunit_suite *__kunit_suites_end[];
+
+static bool kunit_run_all_tests(void)
+{
+	struct kunit_suite **suite;
+	bool has_test_failed = false;
+
+	for (suite = __kunit_suites_start;
+	     suite < __kunit_suites_end;
+	     ++suite) {
+		if (kunit_run_tests(*suite))
+			has_test_failed = true;
+	}
+
+	return !has_test_failed;
+}
+
+static int kunit_executor_init(void)
+{
+	if (kunit_run_all_tests())
+		return 0;
+	else
+		return -EFAULT;
+}
+
+late_initcall(kunit_executor_init);
-- 
2.24.1.735.g03f4e72817-goog
