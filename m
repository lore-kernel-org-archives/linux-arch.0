From: Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC v1 4/6] init: main: add KUnit to kernel init
Date: Mon, 16 Dec 2019 14:05:53 -0800
Message-ID: <20191216220555.245089-5-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c070798ebb765..9da4f2cc1a3fc 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -196,6 +196,15 @@ void kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int kunit_executor_init(void);
+#else
+static inline int kunit_executor_init(void)
+{
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
  *
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef04..b299396a5466b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1190,6 +1192,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_executor_init();
+
 	/* Open the /dev/console on the rootfs, this should never fail */
 	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 978086cfd257d..ca880224c0bab 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
 	return !has_test_failed;
 }
 
-static int kunit_executor_init(void)
+int kunit_executor_init(void)
 {
 	if (kunit_run_all_tests())
 		return 0;
 	else
 		return -EFAULT;
 }
-
-late_initcall(kunit_executor_init);
-- 
2.24.1.735.g03f4e72817-goog
