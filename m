Return-Path: <arun.sharma@intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:50383 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263678AbUDMSqG
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Apr 2004 14:46:06 -0400
Message-ID: <407C355E.7040009@intel.com>
Date: Tue, 13 Apr 2004 11:45:50 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] Consolidate do_execve32
References: <200404040204.03594.arnd@arndb.de> <200404040222.35467.arnd@arndb.de>
In-Reply-To: <200404040222.35467.arnd@arndb.de>
Content-Type: multipart/mixed;
 boundary="------------070600090005080700010301"
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070600090005080700010301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/2004 4:22 PM, Arnd Bergmann wrote:

> The code for sys32_execve/do_execve32 in most of the seven versions
> was copied from fs/exec.c but not kept up-to-date. The new
> compat_do_execve() function is based on the mips code and has been
> resync'ed with do_execve().
> 
> IA64 has some special fixup code in sys32_execve, so I'm not touching
> that.
> 

Attached is a patch that takes care of ia64.

	-Arun

--------------070600090005080700010301
Content-Type: text/plain;
 name="compat_execve_ive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compat_execve_ive.patch"

diff -purN -X dontdiff linux-2.6.5-compat4/arch/ia64/ia32/sys_ia32.c linux-2.6.5-compat/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.5-compat4/arch/ia64/ia32/sys_ia32.c	2004-04-06 09:54:19.000000000 +0800
+++ linux-2.6.5-compat/arch/ia64/ia32/sys_ia32.c	2004-04-08 15:33:24.000000000 +0800
@@ -90,58 +90,17 @@ extern unsigned long arch_get_unmapped_a
 /* XXX make per-mm: */
 static DECLARE_MUTEX(ia32_mmap_sem);
 
-static int
-nargs (unsigned int arg, char **ap)
-{
-	unsigned int addr;
-	int n, err;
-
-	if (!arg)
-		return 0;
-
-	n = 0;
-	do {
-		err = get_user(addr, (unsigned int *)A(arg));
-		if (err)
-			return err;
-		if (ap)
-			*ap++ = (char *) A(addr);
-		arg += sizeof(unsigned int);
-		n++;
-	} while (addr);
-	return n - 1;
-}
-
 asmlinkage long
-sys32_execve (char *filename, unsigned int argv, unsigned int envp,
-	      struct pt_regs *regs)
+sys32_execve (char *name, compat_uptr_t __user *argv, compat_uptr_t __user *envp, struct pt_regs *regs)
 {
+	long error;
+	char *filename;
 	unsigned long old_map_base, old_task_size, tssd;
-	char **av, **ae;
-	int na, ne, len;
-	long r;
-
-	na = nargs(argv, NULL);
-	if (na < 0)
-		return na;
-	ne = nargs(envp, NULL);
-	if (ne < 0)
-		return ne;
-	len = (na + ne + 2) * sizeof(*av);
-	av = kmalloc(len, GFP_KERNEL);
-	if (!av)
-		return -ENOMEM;
-
-	ae = av + na + 1;
-	av[na] = NULL;
-	ae[ne] = NULL;
 
-	r = nargs(argv, av);
-	if (r < 0)
-		goto out;
-	r = nargs(envp, ae);
-	if (r < 0)
-		goto out;
+	filename = getname(name);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		return error;
 
 	old_map_base  = current->thread.map_base;
 	old_task_size = current->thread.task_size;
@@ -152,20 +111,19 @@ sys32_execve (char *filename, unsigned i
 	current->thread.task_size = DEFAULT_TASK_SIZE;
 	ia64_set_kr(IA64_KR_IO_BASE, current->thread.old_iob);
 	ia64_set_kr(IA64_KR_TSSD, current->thread.old_k1);
+
+	error = compat_do_execve(filename, argv, envp, regs);
+	putname(filename);
 
-	set_fs(KERNEL_DS);
-	r = sys_execve(filename, av, ae, regs);
-	if (r < 0) {
+	if (error < 0) {
 		/* oops, execve failed, switch back to old values... */
 		ia64_set_kr(IA64_KR_IO_BASE, IA32_IOBASE);
 		ia64_set_kr(IA64_KR_TSSD, tssd);
 		current->thread.map_base  = old_map_base;
 		current->thread.task_size = old_task_size;
-		set_fs(USER_DS);	/* establish new task-size as the address-limit */
 	}
-  out:
-	kfree(av);
-	return r;
+
+	return error;
 }
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat *ubuf)
diff -purN -X dontdiff linux-2.6.5-compat4/fs/compat.c linux-2.6.5-compat/fs/compat.c
--- linux-2.6.5-compat4/fs/compat.c	2004-04-06 09:54:19.000000000 +0800
+++ linux-2.6.5-compat/fs/compat.c	2004-04-08 18:21:51.000000000 +0800
@@ -981,7 +981,6 @@ out:
 	return ret;
 }
 
-#ifndef __ia64__ /* ia64 needs some extra tweaks */
 /*
  * compat_count() counts the number of arguments/envelopes. It is basically
  * a copy of count() from fs/exec.c, except that it works with 32 bit argv
@@ -1212,7 +1211,6 @@ out_file:
 
 	return retval;
 }
-#endif /* !__ia64__ */
 
 #define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
 

--------------070600090005080700010301--
