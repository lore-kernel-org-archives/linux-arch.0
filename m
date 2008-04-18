From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: [PATCH 1/3] Add thread_info_cache_init() weak hook
Date: Fri, 18 Apr 2008 16:56:15 +1000
Message-ID: <20080418065726.C466EDE246@ozlabs.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Some architecture need to maintain a kmem cache for thread info
structures. (next patch adds that to powerpc to fix an alignment
problem).

There is no good arch callback to use to initialize that cache
that I can find, so this adds a new one in the form of a weak
function whose default is empty.

Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---

 include/linux/sched.h |    2 ++
 init/main.c           |    5 +++++
 2 files changed, 7 insertions(+)

--- linux-work.orig/init/main.c	2008-03-26 10:39:25.000000000 +1100
+++ linux-work/init/main.c	2008-04-18 16:43:53.000000000 +1000
@@ -504,6 +504,10 @@ void __init __attribute__((weak)) smp_se
 {
 }
 
+void __init __weak thread_info_cache_init(void)
+{
+}
+
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
@@ -623,6 +627,7 @@ asmlinkage void __init start_kernel(void
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
+	thread_info_cache_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
Index: linux-work/include/linux/sched.h
===================================================================
--- linux-work.orig/include/linux/sched.h	2008-04-02 09:47:56.000000000 +1100
+++ linux-work/include/linux/sched.h	2008-04-18 13:11:10.000000000 +1000
@@ -1893,6 +1893,8 @@ static inline unsigned long *end_of_stac
 
 #endif
 
+extern void thread_info_cache_init(void);
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
