Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:33408 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262451AbUGABDz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jun 2004 21:03:55 -0400
Message-ID: <40E362D6.7010908@intel.com>
Date: Wed, 30 Jun 2004 18:03:18 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: compat_sys_adjtimex
References: <40E30E8F.3000601@intel.com>	<20040630135342.01eaea83.davem@redhat.com> <16611.20590.297525.314297@cargo.ozlabs.ibm.com>
In-Reply-To: <16611.20590.297525.314297@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000300040503080002060507"
To: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000300040503080002060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/2004 4:44 PM, Paul Mackerras wrote:

> David S. Miller writes:
>> On Wed, 30 Jun 2004 12:03:43 -0700
>> Arun Sharma <arun.sharma@intel.com> wrote:
>> 
>> > This system call seems to be duplicated in many architectures. Here's
>> > a patch which moves it to kernel/compat.c
>> > 
>> > We didn't touch ppc64, because it seems to be different. We've tested
>> > this on ia64 with LTP.
>> 
>> PPC64 just wants some kind of callback invoked right after the
>> do_adjtimex() call, it should be possible to provide a "do-nothing"
>> macro in linux/compat.h that ppc can override in asm/compat.h
> 
> That code we have in ppc64 is about 10 times too clever to be allowed
> to live.  It was basically trying to avoid the overhead of the rwlock
> back in the days when xtime was protected by an rwlock.  Now that we
> have seqlocks we could (and should :) get rid of it.

ok, the function has been eliminated from ppc64 as well.

	-Arun


--------------000300040503080002060507
Content-Type: text/plain;
 name="compat_sys_adjtimex.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compat_sys_adjtimex.2.patch"

This patch moves sys32_adjtimex in 7 archs up to kernel/compat.c.

Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Signed-off-by: Arun Sharma <arun.sharma@intel.com>

---
 arch/ia64/ia32/ia32_entry.S        |    2 
 arch/ia64/ia32/sys_ia32.c          |   74 -----------------------------------
 arch/mips/kernel/linux32.c         |   73 -----------------------------------
 arch/mips/kernel/scall64-n32.S     |    2 
 arch/mips/kernel/scall64-o32.S     |    2 
 arch/parisc/kernel/sys_parisc32.c  |   58 ---------------------------
 arch/parisc/kernel/syscall_table.S |    2 
 arch/ppc64/kernel/misc.S           |    2 
 arch/ppc64/kernel/sys_ppc32.c      |   77 -------------------------------------
 arch/s390/kernel/compat_linux.c    |   73 -----------------------------------
 arch/s390/kernel/compat_wrapper.S  |    8 +--
 arch/s390/kernel/syscalls.S        |    2 
 arch/sparc64/kernel/sys_sparc32.c  |   73 -----------------------------------
 arch/sparc64/kernel/systbls.S      |    2 
 arch/x86_64/ia32/ia32entry.S       |    2 
 arch/x86_64/ia32/sys_ia32.c        |   76 ------------------------------------
 include/linux/compat.h             |   15 +++++++
 kernel/compat.c                    |   58 +++++++++++++++++++++++++++
 18 files changed, 85 insertions(+), 516 deletions(-)

diff -purN linux-2.6.7/arch/ia64/ia32/ia32_entry.S linux-2.6.7-adjtimex/arch/ia64/ia32/ia32_entry.S
--- linux-2.6.7/arch/ia64/ia32/ia32_entry.S	2004-06-23 17:29:15.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/ia64/ia32/ia32_entry.S	2004-06-30 09:26:24.000000000 +0800
@@ -332,7 +332,7 @@ ia32_syscall_table:
 	data8 sys_setdomainname
 	data8 sys32_newuname
 	data8 sys32_modify_ldt
-	data8 sys_ni_syscall	/* adjtimex */
+	data8 compat_sys_adjtimex
 	data8 sys32_mprotect	  /* 125 */
 	data8 compat_sys_sigprocmask
 	data8 sys_ni_syscall	/* create_module */
diff -purN linux-2.6.7/arch/ia64/ia32/sys_ia32.c linux-2.6.7-adjtimex/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.7/arch/ia64/ia32/sys_ia32.c	2004-06-23 17:29:15.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/ia64/ia32/sys_ia32.c	2004-06-30 09:56:09.000000000 +0800
@@ -2199,78 +2199,4 @@ sys32_setresgid(compat_gid_t rgid, compa
 	ssgid = (sgid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)sgid);
 	return sys_setresgid(srgid, segid, ssgid);
 }
-
-/* Handle adjtimex compatibility. */
-
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long
-sys32_adjtimex(struct timex32 *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if(put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
 #endif /* NOTYET */
diff -purN linux-2.6.7/arch/mips/kernel/linux32.c linux-2.6.7-adjtimex/arch/mips/kernel/linux32.c
--- linux-2.6.7/arch/mips/kernel/linux32.c	2004-06-17 15:55:28.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/mips/kernel/linux32.c	2004-06-30 10:49:51.000000000 +0800
@@ -1257,79 +1257,6 @@ out:
 	return err;
 }
 
-/* Handle adjtimex compatibility. */
-
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage int sys32_adjtimex(struct timex32 *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if (get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if (put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset,
 	s32 count)
 {
diff -purN linux-2.6.7/arch/mips/kernel/scall64-n32.S linux-2.6.7-adjtimex/arch/mips/kernel/scall64-n32.S
--- linux-2.6.7/arch/mips/kernel/scall64-n32.S	2004-06-17 15:55:28.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/mips/kernel/scall64-n32.S	2004-06-30 10:50:59.000000000 +0800
@@ -271,7 +271,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_pivot_root
 	PTR	sys32_sysctl
 	PTR	sys_prctl
-	PTR	sys32_adjtimex
+	PTR	compat_sys_adjtimex
 	PTR	compat_sys_setrlimit		/* 6155 */
 	PTR	sys_chroot
 	PTR	sys_sync
diff -purN linux-2.6.7/arch/mips/kernel/scall64-o32.S linux-2.6.7-adjtimex/arch/mips/kernel/scall64-o32.S
--- linux-2.6.7/arch/mips/kernel/scall64-o32.S	2004-06-17 15:55:28.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/mips/kernel/scall64-o32.S	2004-06-30 10:51:51.000000000 +0800
@@ -382,7 +382,7 @@ out:	jr	ra
 	sys	sys_setdomainname 2
 	sys	sys32_newuname	1
 	sys	sys_ni_syscall	0	/* sys_modify_ldt */
-	sys	sys32_adjtimex	1
+	sys	compat_sys_adjtimex	1
 	sys	sys_mprotect	3			/* 4125 */
 	sys	compat_sys_sigprocmask	3
 	sys	sys_ni_syscall	0			/* was creat_module */
diff -purN linux-2.6.7/arch/parisc/kernel/syscall_table.S linux-2.6.7-adjtimex/arch/parisc/kernel/syscall_table.S
--- linux-2.6.7/arch/parisc/kernel/syscall_table.S	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/parisc/kernel/syscall_table.S	2004-06-30 10:59:10.000000000 +0800
@@ -207,7 +207,7 @@
 	/* struct sockaddr... */
 	ENTRY_SAME(recvfrom)
 	/* struct timex contains longs */
-	ENTRY_DIFF(adjtimex)
+	ENTRY_COMP(adjtimex)
 	ENTRY_SAME(mprotect)		/* 125 */
 	/* old_sigset_t forced to 32 bits.  Beware glibc sigset_t */
 	ENTRY_COMP(sigprocmask)
diff -purN linux-2.6.7/arch/parisc/kernel/sys_parisc32.c linux-2.6.7-adjtimex/arch/parisc/kernel/sys_parisc32.c
--- linux-2.6.7/arch/parisc/kernel/sys_parisc32.c	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/parisc/kernel/sys_parisc32.c	2004-06-30 10:58:14.000000000 +0800
@@ -585,64 +585,6 @@ asmlinkage int sys32_sendfile64(int out_
 	return ret;
 }
 
-
-struct timex32 {
-	unsigned int modes;	/* mode selector */
-	int offset;		/* time offset (usec) */
-	int freq;		/* frequency offset (scaled ppm) */
-	int maxerror;		/* maximum error (usec) */
-	int esterror;		/* estimated error (usec) */
-	int status;		/* clock command/status */
-	int constant;		/* pll time constant */
-	int precision;		/* clock precision (usec) (read only) */
-	int tolerance;		/* clock frequency tolerance (ppm)
-				 * (read only)
-				 */
-	struct compat_timeval time;	/* (read only) */
-	int tick;		/* (modified) usecs between clock ticks */
-
-	int ppsfreq;           /* pps frequency (scaled ppm) (ro) */
-	int jitter;            /* pps jitter (us) (ro) */
-	int shift;              /* interval duration (s) (shift) (ro) */
-	int stabil;            /* pps stability (scaled ppm) (ro) */
-	int jitcnt;            /* jitter limit exceeded (ro) */
-	int calcnt;            /* calibration intervals (ro) */
-	int errcnt;            /* calibration errors (ro) */
-	int stbcnt;            /* stability limit exceeded (ro) */
-
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
-};
-
-asmlinkage long sys32_adjtimex(struct timex32 *txc_p32)
-{
-	struct timex txc;
-	struct timex32 t32;
-	int ret;
-	extern int do_adjtimex(struct timex *txc);
-
-	if(copy_from_user(&t32, txc_p32, sizeof(struct timex32)))
-		return -EFAULT;
-#undef CP
-#define CP(x) txc.x = t32.x
-	CP(modes); CP(offset); CP(freq); CP(maxerror); CP(esterror);
-	CP(status); CP(constant); CP(precision); CP(tolerance);
-	CP(time.tv_sec); CP(time.tv_usec); CP(tick); CP(ppsfreq); CP(jitter);
-	CP(shift); CP(stabil); CP(jitcnt); CP(calcnt); CP(errcnt);
-	CP(stbcnt);
-	ret = do_adjtimex(&txc);
-#undef CP
-#define CP(x) t32.x = txc.x
-	CP(modes); CP(offset); CP(freq); CP(maxerror); CP(esterror);
-	CP(status); CP(constant); CP(precision); CP(tolerance);
-	CP(time.tv_sec); CP(time.tv_usec); CP(tick); CP(ppsfreq); CP(jitter);
-	CP(shift); CP(stabil); CP(jitcnt); CP(calcnt); CP(errcnt);
-	CP(stbcnt);
-	return copy_to_user(txc_p32, &t32, sizeof(struct timex32)) ? -EFAULT : ret;
-}
-
-
 struct sysinfo32 {
 	s32 uptime;
 	u32 loads[3];
diff -purN linux-2.6.7/arch/ppc64/kernel/misc.S linux-2.6.7-adjtimex/arch/ppc64/kernel/misc.S
--- linux-2.6.7/arch/ppc64/kernel/misc.S	2004-06-17 15:55:33.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/ppc64/kernel/misc.S	2004-07-01 08:38:53.050665105 +0800
@@ -730,7 +730,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys32_setdomainname
 	.llong .ppc64_newuname
 	.llong .sys_ni_syscall		/* old modify_ldt syscall */
-	.llong .sys32_adjtimex
+	.llong .compat_sys_adjtimex
 	.llong .sys_mprotect		/* 125 */
 	.llong .compat_sys_sigprocmask
 	.llong .sys_ni_syscall		/* old create_module syscall */
diff -purN linux-2.6.7/arch/ppc64/kernel/sys_ppc32.c linux-2.6.7-adjtimex/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.6.7/arch/ppc64/kernel/sys_ppc32.c	2004-06-17 15:55:33.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/ppc64/kernel/sys_ppc32.c	2004-07-01 08:37:23.925666197 +0800
@@ -274,83 +274,6 @@ asmlinkage long sys32_sysfs(u32 option, 
 	return sys_sysfs((int)option, arg1, arg2);
 }
 
-/* Handle adjtimex compatibility. */
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
-extern int do_adjtimex(struct timex *);
-extern void ppc_adjtimex(void);
-
-asmlinkage long sys32_adjtimex(struct timex32 __user *utp)
-{
-	struct timex txc;
-	int ret;
-	
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	/* adjust the conversion of TB to time of day to track adjtimex */
-	ppc_adjtimex();
-
-	if(put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
-
 /* These are here just in case some old sparc32 binary calls it. */
 asmlinkage long sys32_pause(void)
 {
diff -purN linux-2.6.7/arch/s390/kernel/compat_linux.c linux-2.6.7-adjtimex/arch/s390/kernel/compat_linux.c
--- linux-2.6.7/arch/s390/kernel/compat_linux.c	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/s390/kernel/compat_linux.c	2004-06-30 11:05:47.000000000 +0800
@@ -916,79 +916,6 @@ asmlinkage long sys32_sendfile64(int out
 	return ret;
 }
 
-/* Handle adjtimex compatibility. */
-
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long sys32_adjtimex(struct timex32 *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if(put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
diff -purN linux-2.6.7/arch/s390/kernel/compat_wrapper.S linux-2.6.7-adjtimex/arch/s390/kernel/compat_wrapper.S
--- linux-2.6.7/arch/s390/kernel/compat_wrapper.S	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/s390/kernel/compat_wrapper.S	2004-06-30 11:11:00.000000000 +0800
@@ -547,10 +547,10 @@ sys32_newuname_wrapper:
 	llgtr	%r2,%r2			# struct new_utsname *
 	jg	s390x_newuname		# branch to system call
 
-	.globl  sys32_adjtimex_wrapper 
-sys32_adjtimex_wrapper:
-	llgtr	%r2,%r2			# struct timex_emu31 *
-	jg	sys32_adjtimex		# branch to system call
+	.globl  compat_sys_adjtimex_wrapper
+compat_sys_adjtimex_wrapper:
+	llgtr	%r2,%r2			# struct compat_timex *
+	jg	compat_sys_adjtimex	# branch to system call
 
 	.globl  sys32_mprotect_wrapper 
 sys32_mprotect_wrapper:
diff -purN linux-2.6.7/arch/s390/kernel/syscalls.S linux-2.6.7-adjtimex/arch/s390/kernel/syscalls.S
--- linux-2.6.7/arch/s390/kernel/syscalls.S	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/s390/kernel/syscalls.S	2004-06-30 11:11:54.000000000 +0800
@@ -132,7 +132,7 @@ SYSCALL(sys_clone_glue,sys_clone_glue,sy
 SYSCALL(sys_setdomainname,sys_setdomainname,sys32_setdomainname_wrapper)
 SYSCALL(sys_newuname,s390x_newuname,sys32_newuname_wrapper)
 NI_SYSCALL							/* modify_ldt for i386 */
-SYSCALL(sys_adjtimex,sys_adjtimex,sys32_adjtimex_wrapper)
+SYSCALL(sys_adjtimex,sys_adjtimex,compat_sys_adjtimex_wrapper)
 SYSCALL(sys_mprotect,sys_mprotect,sys32_mprotect_wrapper)	/* 125 */
 SYSCALL(sys_sigprocmask,sys_sigprocmask,compat_sys_sigprocmask_wrapper)
 NI_SYSCALL							/* old "create module" */
diff -purN linux-2.6.7/arch/sparc64/kernel/sys_sparc32.c linux-2.6.7-adjtimex/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.6.7/arch/sparc64/kernel/sys_sparc32.c	2004-06-17 15:55:29.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/sparc64/kernel/sys_sparc32.c	2004-06-30 11:13:30.000000000 +0800
@@ -1607,79 +1607,6 @@ asmlinkage long compat_sys_sendfile64(in
 	return ret;
 }
 
-/* Handle adjtimex compatibility. */
-
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long sys32_adjtimex(struct timex32 __user *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if (get_user(txc.modes, &utp->modes) ||
-	    __get_user(txc.offset, &utp->offset) ||
-	    __get_user(txc.freq, &utp->freq) ||
-	    __get_user(txc.maxerror, &utp->maxerror) ||
-	    __get_user(txc.esterror, &utp->esterror) ||
-	    __get_user(txc.status, &utp->status) ||
-	    __get_user(txc.constant, &utp->constant) ||
-	    __get_user(txc.precision, &utp->precision) ||
-	    __get_user(txc.tolerance, &utp->tolerance) ||
-	    __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	    __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	    __get_user(txc.tick, &utp->tick) ||
-	    __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	    __get_user(txc.jitter, &utp->jitter) ||
-	    __get_user(txc.shift, &utp->shift) ||
-	    __get_user(txc.stabil, &utp->stabil) ||
-	    __get_user(txc.jitcnt, &utp->jitcnt) ||
-	    __get_user(txc.calcnt, &utp->calcnt) ||
-	    __get_user(txc.errcnt, &utp->errcnt) ||
-	    __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if (put_user(txc.modes, &utp->modes) ||
-	    __put_user(txc.offset, &utp->offset) ||
-	    __put_user(txc.freq, &utp->freq) ||
-	    __put_user(txc.maxerror, &utp->maxerror) ||
-	    __put_user(txc.esterror, &utp->esterror) ||
-	    __put_user(txc.status, &utp->status) ||
-	    __put_user(txc.constant, &utp->constant) ||
-	    __put_user(txc.precision, &utp->precision) ||
-	    __put_user(txc.tolerance, &utp->tolerance) ||
-	    __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	    __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	    __put_user(txc.tick, &utp->tick) ||
-	    __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	    __put_user(txc.jitter, &utp->jitter) ||
-	    __put_user(txc.shift, &utp->shift) ||
-	    __put_user(txc.stabil, &utp->stabil) ||
-	    __put_user(txc.jitcnt, &utp->jitcnt) ||
-	    __put_user(txc.calcnt, &utp->calcnt) ||
-	    __put_user(txc.errcnt, &utp->errcnt) ||
-	    __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 /* This is just a version for 32-bit applications which does
  * not force O_LARGEFILE on.
  */
diff -purN linux-2.6.7/arch/sparc64/kernel/systbls.S linux-2.6.7-adjtimex/arch/sparc64/kernel/systbls.S
--- linux-2.6.7/arch/sparc64/kernel/systbls.S	2004-06-17 15:55:29.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/sparc64/kernel/systbls.S	2004-06-30 11:16:41.000000000 +0800
@@ -62,7 +62,7 @@ sys_call_table32:
 /*200*/	.word sys32_ssetmask, sys_sigsuspend, compat_sys_newlstat, sys_uselib, old32_readdir
 	.word sys32_readahead, sys32_socketcall, sys32_syslog, sys32_lookup_dcookie, sys32_fadvise64
 /*210*/	.word sys32_fadvise64_64, sys32_tgkill, sys32_waitpid, sys_swapoff, sys32_sysinfo
-	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
+	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, compat_sys_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys32_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
 /*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
diff -purN linux-2.6.7/arch/x86_64/ia32/ia32entry.S linux-2.6.7-adjtimex/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.7/arch/x86_64/ia32/ia32entry.S	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/x86_64/ia32/ia32entry.S	2004-06-30 11:21:16.000000000 +0800
@@ -429,7 +429,7 @@ ia32_sys_call_table:
 	.quad sys_setdomainname
 	.quad sys_uname
 	.quad sys_modify_ldt
-	.quad sys32_adjtimex
+	.quad compat_sys_adjtimex
 	.quad sys32_mprotect		/* 125 */
 	.quad compat_sys_sigprocmask
 	.quad quiet_ni_syscall		/* create_module */
diff -purN linux-2.6.7/arch/x86_64/ia32/sys_ia32.c linux-2.6.7-adjtimex/arch/x86_64/ia32/sys_ia32.c
--- linux-2.6.7/arch/x86_64/ia32/sys_ia32.c	2004-06-17 15:55:37.000000000 +0800
+++ linux-2.6.7-adjtimex/arch/x86_64/ia32/sys_ia32.c	2004-06-30 11:21:40.000000000 +0800
@@ -953,82 +953,6 @@ sys32_sendfile(int out_fd, int in_fd, co
 	return ret;
 }
 
-/* Handle adjtimex compatibility. */
-
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long
-sys32_adjtimex(struct timex32 __user *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(verify_area(VERIFY_READ, utp, sizeof(struct timex32)) ||
-	   __get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if(verify_area(VERIFY_WRITE, utp, sizeof(struct timex32)) ||
-	   __put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
diff -purN linux-2.6.7/include/linux/compat.h linux-2.6.7-adjtimex/include/linux/compat.h
--- linux-2.6.7/include/linux/compat.h	2004-06-17 15:55:53.000000000 +0800
+++ linux-2.6.7-adjtimex/include/linux/compat.h	2004-06-30 15:15:53.000000000 +0800
@@ -40,6 +40,19 @@ struct compat_tms {
 	compat_clock_t		tms_cstime;
 };
 
+struct compat_timex {
+	u32 modes;
+	s32 offset, freq, maxerror, esterror;
+	s32 status, constant, precision, tolerance;
+	struct compat_timeval time;
+	s32 tick;
+	s32 ppsfreq, jitter, shift, stabil;
+	s32 jitcnt, calcnt, errcnt, stbcnt;
+	s32  :32; s32  :32; s32  :32; s32  :32;
+	s32  :32; s32  :32; s32  :32; s32  :32;
+	s32  :32; s32  :32; s32  :32; s32  :32;
+};
+
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
 typedef struct {
@@ -130,5 +143,7 @@ asmlinkage long compat_sys_select(int n,
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
 		struct compat_timeval __user *tvp);
 
+asmlinkage long compat_sys_adjtimex(struct compat_timex *utp)
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -purN linux-2.6.7/kernel/compat.c linux-2.6.7-adjtimex/kernel/compat.c
--- linux-2.6.7/kernel/compat.c	2004-06-17 15:56:05.000000000 +0800
+++ linux-2.6.7-adjtimex/kernel/compat.c	2004-06-30 15:13:38.000000000 +0800
@@ -170,6 +170,64 @@ asmlinkage long compat_sys_times(struct 
 	return compat_jiffies_to_clock_t(jiffies);
 }
 
+extern int do_adjtimex(struct timex *);
+
+asmlinkage long compat_sys_adjtimex(struct compat_timex *utp)
+{
+	struct timex txc;
+	int ret;
+
+	memset(&txc, 0, sizeof(struct timex));
+
+	if(get_user(txc.modes, &utp->modes) ||
+	   __get_user(txc.offset, &utp->offset) ||
+	   __get_user(txc.freq, &utp->freq) ||
+	   __get_user(txc.maxerror, &utp->maxerror) ||
+	   __get_user(txc.esterror, &utp->esterror) ||
+	   __get_user(txc.status, &utp->status) ||
+	   __get_user(txc.constant, &utp->constant) ||
+	   __get_user(txc.precision, &utp->precision) ||
+	   __get_user(txc.tolerance, &utp->tolerance) ||
+	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
+	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
+	   __get_user(txc.tick, &utp->tick) ||
+	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
+	   __get_user(txc.jitter, &utp->jitter) ||
+	   __get_user(txc.shift, &utp->shift) ||
+	   __get_user(txc.stabil, &utp->stabil) ||
+	   __get_user(txc.jitcnt, &utp->jitcnt) ||
+	   __get_user(txc.calcnt, &utp->calcnt) ||
+	   __get_user(txc.errcnt, &utp->errcnt) ||
+	   __get_user(txc.stbcnt, &utp->stbcnt))
+		return -EFAULT;
+
+	ret = do_adjtimex(&txc);
+
+	if(put_user(txc.modes, &utp->modes) ||
+	   __put_user(txc.offset, &utp->offset) ||
+	   __put_user(txc.freq, &utp->freq) ||
+	   __put_user(txc.maxerror, &utp->maxerror) ||
+	   __put_user(txc.esterror, &utp->esterror) ||
+	   __put_user(txc.status, &utp->status) ||
+	   __put_user(txc.constant, &utp->constant) ||
+	   __put_user(txc.precision, &utp->precision) ||
+	   __put_user(txc.tolerance, &utp->tolerance) ||
+	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
+	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
+	   __put_user(txc.tick, &utp->tick) ||
+	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
+	   __put_user(txc.jitter, &utp->jitter) ||
+	   __put_user(txc.shift, &utp->shift) ||
+	   __put_user(txc.stabil, &utp->stabil) ||
+	   __put_user(txc.jitcnt, &utp->jitcnt) ||
+	   __put_user(txc.calcnt, &utp->calcnt) ||
+	   __put_user(txc.errcnt, &utp->errcnt) ||
+	   __put_user(txc.stbcnt, &utp->stbcnt))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 /*
  * Assumption: old_sigset_t and compat_old_sigset_t are both
  * types that can be passed to put_user()/get_user().

--------------000300040503080002060507--
