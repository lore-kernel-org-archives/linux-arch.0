Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:57800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751128AbWCYU1s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 Mar 2006 15:27:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PKRlDZ029106
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-arch@vger.kernel.org>; Sat, 25 Mar 2006 12:27:47 -0800
Message-Id: <200603252027.k2PKRkpP011257@shell0.pdx.osdl.net>
Subject: [patch 1/1] remove fixup_cpu_present_map()
From: akpm@osdl.org
Date: Sat, 25 Mar 2006 12:24:11 -0800
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>


From: Andrew Morton <akpm@osdl.org>

Since the addition of boot_cpu_init(), fixup_cpu_present_map() has been a
no-op.  That's because fixup_cpu_present_map() won't touch cpu_present_map if
it has any bits set, and boot_cpu_init() sets a bit.

So remove fixup_cpu_present_map().

A consequence of this (actually of the boot_cpu_init() change) is that the
architecture _must_ populate cpu_present_map itself (probably in
smp_prepare_cpus()).  fixup_cpu_present_map() won't do it any more.

If the architecture doesn't do this, it'll only bring up a single CPU.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 init/main.c |   19 -------------------
 1 files changed, 19 deletions(-)

diff -puN init/main.c~remove-fixup_cpu_present_map init/main.c
--- devel/init/main.c~remove-fixup_cpu_present_map	2006-03-25 12:23:36.000000000 -0800
+++ devel-akpm/init/main.c	2006-03-25 12:23:36.000000000 -0800
@@ -645,24 +645,6 @@ static void run_init_process(char *init_
 	execve(init_filename, argv_init, envp_init);
 }
 
-static inline void fixup_cpu_present_map(void)
-{
-#ifdef CONFIG_SMP
-	int i;
-
-	/*
-	 * If arch is not hotplug ready and did not populate
-	 * cpu_present_map, just make cpu_present_map same as cpu_possible_map
-	 * for other cpu bringup code to function as normal. e.g smp_init() etc.
-	 */
-	if (cpus_empty(cpu_present_map)) {
-		for_each_cpu(i) {
-			cpu_set(i, cpu_present_map);
-		}
-	}
-#endif
-}
-
 static int init(void * unused)
 {
 	lock_kernel();
@@ -684,7 +666,6 @@ static int init(void * unused)
 
 	do_pre_smp_initcalls();
 
-	fixup_cpu_present_map();
 	smp_init();
 	sched_init_smp();
 
_
