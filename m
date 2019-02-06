From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: linux-next: tracebacks in =?ISO-2022-JP?B?d29ya3F1ZXVlLmMvX19mbHVz?=
 =?ISO-2022-JP?B?aF93b3JrKCk=?=
Date: Wed, 06 Feb 2019 15:31:09 +0900
Message-ID: <201902060631.x166V9J8014750@www262.sakura.ne.jp>
References: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp> <87munc306z.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87munc306z.fsf@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Guenter Roeck <linux@roeck-us.net>, Chris Metcalf <chris.d.metcalf@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

(Adding linux-arch ML.)

Rusty Russell wrote:
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> > (Adding Chris Metcalf and Rusty Russell.)
> >
> > If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
> > evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
> > previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
> > commits listed below.
> >
> >   Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
> >   expects that has_work is evaluated by for_each_cpu().
> >
> >   Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
> >   assumes that for_each_cpu() does not need to evaluate has_work.
> >
> >   Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
> >   expects that has_work is evaluated by for_each_cpu().
> >
> > What should we do? Do we explicitly evaluate has_work if NR_CPUS == 1 ?
> 
> No, fix the API to be least-surprise.  Fix 2d3854a37e8b767a too.
> 
> Doing anything else would be horrible, IMHO.
> 

Fixing 2d3854a37e8b767a might involve subtle changes. If we do

----------
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec..1ec5321 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -129,7 +129,7 @@ static inline unsigned int cpumask_check(unsigned int cpu)
 	return cpu;
 }
 
-#if NR_CPUS == 1
+#if NR_CPUS == 1 && 0
 /* Uniprocessor.  Assume all masks are "1". */
 static inline unsigned int cpumask_first(const struct cpumask *srcp)
 {
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da..da6f99c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,7 +28,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
-lib-$(CONFIG_SMP) += cpumask.o
+lib-y += cpumask.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
----------

then we get e.g. a build failure like below.

----------
arch/x86/kernel/cpu/cacheinfo.o: In function `_populate_cache_leaves':
cacheinfo.c:(.text+0xb20): undefined reference to `cpu_llc_shared_map'
cacheinfo.c:(.text+0xb48): undefined reference to `cpu_llc_shared_map'
cacheinfo.c:(.text+0xb64): undefined reference to `cpu_llc_shared_map'
make: *** [vmlinux] Error 1
----------

This build failure is caused due to the

  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);

line which cpu_llc_shared_mask() depends on is in arch/x86/kernel/smpboot.c
and the

  obj-$(CONFIG_SMP)               += smpboot.o

line is in arch/x86/kernel/Makefile . We could try

----------
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c4d1023..bf95da3 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -23,6 +23,10 @@
 
 #include "cpu.h"
 
+#ifndef CONFIG_SMP
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+#endif
+
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
 #define LVL_2		3
----------

or

----------
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c4d1023..b8a22b6 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -886,6 +886,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 	 * to derive shared_cpu_map.
 	 */
 	if (index == 3) {
+#ifdef CONFIG_SMP
 		for_each_cpu(i, cpu_llc_shared_mask(cpu)) {
 			this_cpu_ci = get_cpu_cacheinfo(i);
 			if (!this_cpu_ci->info_list)
@@ -898,6 +899,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 						&this_leaf->shared_cpu_map);
 			}
 		}
+#endif
 	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		unsigned int apicid, nshared, first, last;
 
----------

but I don't know whether this is a correct fix, for for_each_cpu() currently
always executes the loop because for_each_cpu() does not evaluate
cpu_llc_shared_mask(cpu) argument. But if cpu_llc_shared_mask(cpu) argument
is evaluated by for_each_cpu(), and given that nobody updates cpu_llc_shared_map
if CONFIG_SMP=n, I guess that this for_each_cpu() becomes a no-op loop. I can't
evaluate whether this change is safe, and there might be similar code in other
architectures.
