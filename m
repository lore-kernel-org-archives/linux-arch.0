Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266657AbUIUDsk@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:44444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266526AbUIUDsk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Sep 2004 23:48:40 -0400
Date: Mon, 20 Sep 2004 20:46:37 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: x86-64-waitid-compat-fix
Message-Id: <20040920204637.441097b6.akpm@osdl.org>
In-Reply-To: <20040920204055.577976a9.akpm@osdl.org>
References: <20040920204055.577976a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@osdl.org> wrote:
>
> I guess I'll merge this into Linus's tree this evening.  It breaks sparc64
>  and probably other architectures.  The fix will be simple; probably the
>  same as x86_64..

This sparc64 fix compiles.

All (or most of) those casts in the sys_waitid() call seem to be unneeded -
we have a prototype in scope...


--- 25-sparc64/arch/sparc64/kernel/sys_sparc32.c~sparc64-waitid-compat-fix	2004-09-20 20:41:25.867863424 -0700
+++ 25-sparc64-akpm/arch/sparc64/kernel/sys_sparc32.c	2004-09-20 20:44:59.847333600 -0700
@@ -1737,21 +1737,28 @@ sys32_timer_create(u32 clock, struct sig
 }
 
 asmlinkage long compat_sys_waitid(u32 which, u32 pid,
-				  struct siginfo32 __user *uinfo, u32 options)
+			struct siginfo32 __user *uinfo, int options,
+			struct compat_rusage __user *uru)
 {
 	siginfo_t info;
+	struct rusage ru;
 	long ret;
 	mm_segment_t old_fs = get_fs();
 
 	memset(&info, 0, sizeof(info));
 
-	set_fs (KERNEL_DS);
-	ret = sys_waitid((int)which, (compat_pid_t) pid,
-			 (siginfo_t __user *) &info, (int) options);
-	set_fs (old_fs);
+	set_fs(KERNEL_DS);
+	ret = sys_waitid((int)which, (compat_pid_t)pid,
+			(siginfo_t __user *)&info, (int)options,
+			uru ? &ru : NULL);
+
+	set_fs(old_fs);
 
 	if (ret < 0 || info.si_signo == 0)
 		return ret;
+	if (uru && (ret = put_compat_rusage(&ru, uru)))
+		return ret;
+
 	BUG_ON(info.si_code & __SI_MASK);
 	info.si_code |= __SI_CHLD;
 	return copy_siginfo_to_user32(uinfo, &info);
_
