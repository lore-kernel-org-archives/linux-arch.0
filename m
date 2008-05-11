From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [PATCH] Make for_each_cpu_mask a bit smaller
Date: Sun, 11 May 2008 15:50:39 +0200
Message-ID: <20080511135039.GA3286@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755747AbYEKNvu@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Paul Jackson <pj@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, heukelum@fastmail.fm
List-Id: linux-arch.vger.kernel.org

The for_each_cpu_mask loop is used quite often in the kernel. It
makes use of two functions: first_cpu and next_cpu. This patch
changes for_each_cpu_mask to use only one function: a newly
introduced find_next_cpu. Each use of the for_each_cpu_mask
constuct then becomes a few bytes smaller. An x86_64 defconfig
kernel is about 2000 bytes smaller with this patch applied:

   text	   data	    bss	    dec	    hex	filename
5395732	 976736	 734280	7106748	 6c70bc	vmlinux.orig
5393639	 976736	 734280	7104655	 6c688f	vmlinux

Runs fine on qemu UP/SMP x86_64/i386.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>

---

Hello Andrew,

Could you add this patch to -mm?

Greetings,
	Alexander

 include/linux/cpumask.h |   14 ++++++++------
 lib/cpumask.c           |    6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 9650806..a760e29 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -221,9 +221,11 @@ int __first_cpu(const cpumask_t *srcp);
 #define first_cpu(src) __first_cpu(&(src))
 int __next_cpu(int n, const cpumask_t *srcp);
 #define next_cpu(n, src) __next_cpu((n), &(src))
+int find_next_cpu_mask(int n, const cpumask_t *srcp);
 #else
-#define first_cpu(src)		({ (void)(src); 0; })
-#define next_cpu(n, src)	({ (void)(src); 1; })
+#define first_cpu(src)			({ (void)(src); 0; })
+#define next_cpu(n, src)		({ (void)(src); 1; })
+#define find_next_cpu_mask(n, src)	({ (void)(src); n; })
 #endif
 
 #ifdef CONFIG_HAVE_CPUMASK_OF_CPU_MAP
@@ -351,10 +353,10 @@ static inline void __cpus_fold(cpumask_t *dstp, const cpumask_t *origp,
 }
 
 #if NR_CPUS > 1
-#define for_each_cpu_mask(cpu, mask)		\
-	for ((cpu) = first_cpu(mask);		\
-		(cpu) < NR_CPUS;		\
-		(cpu) = next_cpu((cpu), (mask)))
+#define for_each_cpu_mask(cpu, mask)				\
+	for ((cpu) = 0;						\
+		(cpu) = find_next_cpu_mask((cpu), &(mask)),	\
+		(cpu) < NR_CPUS; (cpu)++)
 #else /* NR_CPUS == 1 */
 #define for_each_cpu_mask(cpu, mask)		\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
diff --git a/lib/cpumask.c b/lib/cpumask.c
index bb4f76d..93dd6ca 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -15,6 +15,12 @@ int __next_cpu(int n, const cpumask_t *srcp)
 }
 EXPORT_SYMBOL(__next_cpu);
 
+int find_next_cpu_mask(int n, const cpumask_t *srcp)
+{
+	return find_next_bit(srcp->bits, NR_CPUS, n);
+}
+EXPORT_SYMBOL(find_next_cpu_mask);
+
 int __any_online_cpu(const cpumask_t *mask)
 {
 	int cpu;
