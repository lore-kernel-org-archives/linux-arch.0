From: Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] Add thread_info_cache_init() to all archs
Date: Thu, 10 Apr 2008 13:22:56 +1000
Message-ID: <20080410032354.90CB1DDF0F@ozlabs.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org, linux-m32r-rQhvJZKUsGBRYuoOT4C5/9i2O/JbrIOy@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Some architecture need to maintain a kmem cache for thread info
structures. (next patch adds that to powerpc to fix an alignment
problem).

There is no good arch callback to use to initialize that cache
that I can find, so this adds a new one and adds an empty macro
for when it's not implemented.

Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---

So we have the choice here between:

 - the ifdef on the func name that I did, consistent with what
I did before for iomap, which iirc Linus liked

 - add some more ARCH_HAS_* or HAVE_* (yuck)

 - add an empty definition to all archs .h (pain in the neck but I
can do it, though it will be an annoying patch to keep around)

 - do a weak function (will slightly bloat everybody for no good reason)

So unless there is strong complaints, I'd like to stick to my
current approach.

 include/linux/sched.h |    4 ++++
 init/main.c           |    1 +
 2 files changed, 5 insertions(+)

--- linux-work.orig/init/main.c	2008-04-10 13:11:06.000000000 +1000
+++ linux-work/init/main.c	2008-04-10 13:11:19.000000000 +1000
@@ -623,6 +623,7 @@ asmlinkage void __init start_kernel(void
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
+	thread_info_cache_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
Index: linux-work/include/linux/sched.h
===================================================================
--- linux-work.orig/include/linux/sched.h	2008-04-10 13:11:44.000000000 +1000
+++ linux-work/include/linux/sched.h	2008-04-10 13:12:05.000000000 +1000
@@ -1893,6 +1893,10 @@ static inline unsigned long *end_of_stac
 
 #endif
 
+#ifndef thread_info_cache_init
+#define thread_info_cache_init	do { } while(0)
+#endif
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
