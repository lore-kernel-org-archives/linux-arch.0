From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 06/18] thread: move thread bits accessors to separated file
Date: Wed, 17 Aug 2016 14:46:31 +0300
Message-ID: <1471434403-25291-7-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-72564-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
List-Id: linux-arch.vger.kernel.org

They may be accessed from low-level code, so isolating is a measure to
avoid circular dependencies in header files.

The exact reason for circular dependency is WARN_ON() macro added by Al
Viro in patch [edd63a27] "set_restore_sigmask() is never called without
SIGPENDING (and never should be)"

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/thread_bits.h | 55 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h | 44 +-----------------------------------
 2 files changed, 56 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/thread_bits.h

diff --git a/include/linux/thread_bits.h b/include/linux/thread_bits.h
new file mode 100644
index 0000000..0d05d16
--- /dev/null
+++ b/include/linux/thread_bits.h
@@ -0,0 +1,55 @@
+
+/* thread_bits.h: common low-level thread bits accessors */
+
+#ifndef _LINUX_THREAD_BITS_H
+#define _LINUX_THREAD_BITS_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bitops.h>
+#include <asm/thread_info.h>
+
+/*
+ * flag set/clear/test wrappers
+ * - pass TIF_xxxx constants to these functions
+ */
+
+static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	set_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	clear_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_bit(flag, (unsigned long *)&ti->flags);
+}
+
+#define set_thread_flag(flag) \
+	set_ti_thread_flag(current_thread_info(), flag)
+#define clear_thread_flag(flag) \
+	clear_ti_thread_flag(current_thread_info(), flag)
+#define test_and_set_thread_flag(flag) \
+	test_and_set_ti_thread_flag(current_thread_info(), flag)
+#define test_and_clear_thread_flag(flag) \
+	test_and_clear_ti_thread_flag(current_thread_info(), flag)
+#define test_thread_flag(flag) \
+	test_ti_thread_flag(current_thread_info(), flag)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _LINUX_THREAD_BITS_H */
+
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index cbd8990..c778121 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -50,8 +50,7 @@ struct restart_block {
 
 extern long do_no_restart_syscall(struct restart_block *parm);
 
-#include <linux/bitops.h>
-#include <asm/thread_info.h>
+#include <linux/thread_bits.h>
 
 #ifdef __KERNEL__
 
@@ -62,47 +61,6 @@ extern long do_no_restart_syscall(struct restart_block *parm);
 # define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_NOTRACK)
 #endif
 
-/*
- * flag set/clear/test wrappers
- * - pass TIF_xxxx constants to these functions
- */
-
-static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	set_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	clear_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_bit(flag, (unsigned long *)&ti->flags);
-}
-
-#define set_thread_flag(flag) \
-	set_ti_thread_flag(current_thread_info(), flag)
-#define clear_thread_flag(flag) \
-	clear_ti_thread_flag(current_thread_info(), flag)
-#define test_and_set_thread_flag(flag) \
-	test_and_set_ti_thread_flag(current_thread_info(), flag)
-#define test_and_clear_thread_flag(flag) \
-	test_and_clear_ti_thread_flag(current_thread_info(), flag)
-#define test_thread_flag(flag) \
-	test_ti_thread_flag(current_thread_info(), flag)
-
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
-- 
2.7.4
