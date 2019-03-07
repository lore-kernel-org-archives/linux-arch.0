Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGQFo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 11:05:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] x86: vdso: fix compat_vdso build
Date: Thu,  7 Mar 2019 17:05:30 +0100
Message-Id: <20190307160532.3328288-3-arnd@arndb.de>
In-Reply-To: <20190307160532.3328288-1-arnd@arndb.de>
References: <20190307160532.3328288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

When we build the compat vdso, the kernel headers will be used
with a 32-bit compiler combined with configuration options
for the 64-bit kernel, which leads to many undesired effects
from header files that make assumptions about the configuration
options, such as:

In file included from include/linux/mm_types.h:15,
                 from include/asm-generic/fixmap.h:19,
                 from arch/x86/include/asm/fixmap.h:193,
                 from arch/x86/include/asm/apic.h:10,
                 from arch/x86/include/asm/smp.h:13,
                 from include/linux/smp.h:68,
                 from include/linux/percpu.h:7,
                 from include/linux/hrtimer.h:19,
                 from arch/x86/entry/vdso/vdso32/../../../../../lib/vdso/gettimeofday.c:9,
                 from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:13,
                 from arch/x86/entry/vdso/vdso32/vclock_gettime.c:31:
include/linux/page-flags-layout.h:95:2: error: #warning "KASAN: not enough bits in page flags for tag" [-Werror=cpp]
 #warning "KASAN: not enough bits in page flags for tag"
  ^~~~~~~

Limit the scope of the headers much more, by removing linux/hrtimer.h
and asm/mshyperv.h from the list of included files. Instead, the parts
we actually need are moved into separate headers that are included
by the normal ones.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/mshyperv-tsc.h      | 76 ++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h          | 70 +---------------------
 arch/x86/include/asm/pvclock.h           |  2 +-
 arch/x86/include/asm/vdso/gettimeofday.h |  2 +-
 arch/x86/include/asm/vgtod.h             |  2 +-
 arch/x86/kernel/pvclock.c                |  1 +
 include/linux/hrtimer.h                  | 15 +----
 include/linux/hrtimer_defs.h             | 25 ++++++++
 lib/vdso/gettimeofday.c                  |  3 +-
 9 files changed, 109 insertions(+), 87 deletions(-)
 create mode 100644 arch/x86/include/asm/mshyperv-tsc.h
 create mode 100644 include/linux/hrtimer_defs.h

diff --git a/arch/x86/include/asm/mshyperv-tsc.h b/arch/x86/include/asm/mshyperv-tsc.h
new file mode 100644
index 000000000000..99c98ccea0bf
--- /dev/null
+++ b/arch/x86/include/asm/mshyperv-tsc.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MSHYPER_TSCPAGE_H
+#define _ASM_X86_MSHYPER_TSCPAGE_H
+
+#include <asm/hyperv-tlfs.h>
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	u64 scale, offset;
+	u32 sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification ver. 3.0 and above. To get the
+	 * reference time we must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else. The currently published specification
+	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
+	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 * - ReferenceTime =
+	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			return U64_MAX;
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		*cur_tsc = rdtsc_ordered();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#else
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	BUG();
+	return U64_MAX;
+}
+#endif
+#endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..db095a992f3e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -7,6 +7,7 @@
 #include <linux/nmi.h>
 #include <asm/io.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv-tsc.h>
 #include <asm/nospec-branch.h>
 
 #define VP_INVAL	U32_MAX
@@ -387,73 +388,4 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 }
 #endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	u64 scale, offset;
-	u32 sequence;
-
-	/*
-	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
-	 * Top-Level Functional Specification ver. 3.0 and above. To get the
-	 * reference time we must do the following:
-	 * - READ ReferenceTscSequence
-	 *   A special '0' value indicates the time source is unreliable and we
-	 *   need to use something else. The currently published specification
-	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
-	 *   instead of '0' as the special value, see commit c35b82ef0294.
-	 * - ReferenceTime =
-	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
-	 * - READ ReferenceTscSequence again. In case its value has changed
-	 *   since our first reading we need to discard ReferenceTime and repeat
-	 *   the whole sequence as the hypervisor was updating the page in
-	 *   between.
-	 */
-	do {
-		sequence = READ_ONCE(tsc_pg->tsc_sequence);
-		if (!sequence)
-			return U64_MAX;
-		/*
-		 * Make sure we read sequence before we read other values from
-		 * TSC page.
-		 */
-		smp_rmb();
-
-		scale = READ_ONCE(tsc_pg->tsc_scale);
-		offset = READ_ONCE(tsc_pg->tsc_offset);
-		*cur_tsc = rdtsc_ordered();
-
-		/*
-		 * Make sure we read sequence after we read all other values
-		 * from TSC page.
-		 */
-		smp_rmb();
-
-	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
-
-	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
-}
-
-static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
-{
-	u64 cur_tsc;
-
-	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
-}
-
-#else
-static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return NULL;
-}
-
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	BUG();
-	return U64_MAX;
-}
-#endif
 #endif
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index b6033680d458..19b695ff2c68 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PVCLOCK_H
 #define _ASM_X86_PVCLOCK_H
 
-#include <linux/clocksource.h>
+#include <asm/clocksource.h>
 #include <asm/pvclock-abi.h>
 
 /* some helper functions for xen and kvm pv clock sources */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 510a0ebd5748..6b2d6ce26bcc 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -18,7 +18,7 @@
 #include <asm/unistd.h>
 #include <asm/msr.h>
 #include <asm/pvclock.h>
-#include <asm/mshyperv.h>
+#include <asm/mshyperv-tsc.h>
 
 #define _vdso_data (&VVAR(vdso_data))
 
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 0b4e343c62be..cd60f292c553 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_VGTOD_H
 
 #include <linux/compiler.h>
-#include <linux/clocksource.h>
+#include <asm/clocksource.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 9b158b4716d2..747264182df7 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -15,6 +15,7 @@
     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
 
+#include <linux/clocksource.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..c922ce02e2e6 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_HRTIMER_H
 #define _LINUX_HRTIMER_H
 
+#include <linux/hrtimer_defs.h>
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
 #include <linux/init.h>
@@ -298,26 +299,12 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-# define HIGH_RES_NSEC		1
-# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
-# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
-
 extern void clock_was_set_delayed(void);
 
 extern unsigned int hrtimer_resolution;
 
 #else
 
-# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
-
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
 static inline void clock_was_set_delayed(void) { }
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
new file mode 100644
index 000000000000..1f181d31e29c
--- /dev/null
+++ b/include/linux/hrtimer_defs.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _LINUX_HRTIMER_DEFS_H
+#define _LINUX_HRTIMER_DEFS_H
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+# define HIGH_RES_NSEC		1
+# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
+# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
+
+#else
+
+# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
+
+#endif
+
+#endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index f10e3703abaa..9b4944d2c2ed 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -6,7 +6,8 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
-#include <linux/hrtimer.h>
+#include <linux/ktime.h>
+#include <linux/hrtimer_defs.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
-- 
2.20.0
