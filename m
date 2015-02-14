Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50386 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753853AbbBNLcK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 14 Feb 2015 06:32:10 -0500
Date: Sat, 14 Feb 2015 11:22:23 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
Message-ID: <20150214112220.GB10246@MBP.local>
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com>
 <20150210122718.GC32052@e104818-lin.cambridge.arm.com>
 <54DB3B60.4050100@huawei.com>
 <20150211154054.GD9058@e104818-lin.cambridge.arm.com>
 <54DDAF2B.2070707@huawei.com>
 <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
 <54DE730D.3090100@ezchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54DE730D.3090100@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>, linux-arch@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org, deller@gmx.de, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, heiko.carstens@de.ibm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, jejb@parisc-linux.org, "lizefan@huawei.com" <lizefan@huawei.com>, paulus@samba.org, ralf@linux-mips.org, hpa@zytor.com, schwidefsky@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, davem@davemloft.net, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150214112223.CLHoLOV4tBrU1VFtnX3pyNvOS0GmgsGR72qWCzcxFK0@z>

On Fri, Feb 13, 2015 at 04:56:29PM -0500, Chris Metcalf wrote:
> On 2/13/2015 5:44 AM, Catalin Marinas wrote:
> >On Fri, Feb 13, 2015 at 04:00:43PM +0800, Bamvor Jian Zhang wrote:
> >>diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> >>index e299de396e9b..32601939a3c8 100644
> >>--- a/arch/arm64/kernel/signal32.c
> >>+++ b/arch/arm64/kernel/signal32.c
> >>@@ -154,8 +154,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
> >>  	case __SI_TIMER:
> >>  		 err |= __put_user(from->si_tid, &to->si_tid);
> >>  		 err |= __put_user(from->si_overrun, &to->si_overrun);
> >>-		 err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
> >>-				   &to->si_ptr);
> >>+		 err |= __put_user(from->si_int, &to->si_int);
> >>  		break;
> >>  	case __SI_POLL:
> >>  		err |= __put_user(from->si_band, &to->si_band);
> >>@@ -184,7 +183,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
> >>  	case __SI_MESGQ: /* But this is */
> >>  		err |= __put_user(from->si_pid, &to->si_pid);
> >>  		err |= __put_user(from->si_uid, &to->si_uid);
> >>-		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
> >>+		err |= __put_user(from->si_int, &to->si_int);
> >>  		break;
> >>  	case __SI_SYS:
> >>  		err |= __put_user((compat_uptr_t)(unsigned long)
> 
> I must be confused here, but I don't see that these do anything different.
> 
> If we are writing 32 bits to to->si_ptr or to->si_int, either way the high 32 bits
> are irrelevant.  So whether we read it from from->si_ptr and massage the high bits,
> or just read it from from->si_int as a straight-up 32-bit quantity, either way it
> seems we should end up writing the same bits to userspace.
> 
> I would understand the argument if we were overlaying the si_ptr/si_int union
> from a kernel-side siginfo_t where si_ptr and si_int are different sizes
> onto userspace, but it doesn't seem we ever do that.

That's the problem, "from" above is a kernel siginfo_t while "to" is a
compat_siginfo_t. The call paths go something like:

1. user populates sival_int compat_sigevent and invokes
   compat_sys_mq_notify()
2. kernel get_compat_sigevent() copies compat_sigevent into the native
   sigevent. compat and native sival_int are the same, no problem so
   far. The other half of 64-bit sival_ptr is zeroed by a memset in this
   function (this other half can be top or bottom, depending on
   endianness)
3. signal is about to be delivered to user via arch code. The
   compat_ptr(from->si_ptr) conversion always takes the least
   significant part of the native si_ptr. On big endian 64-bit, this is
   zero because get_compat_sigevent() populated the top part of si_ptr
   with si_int.

So delivering such signals to compat user always sets si_int to 0.
Little endian is fine.

A similar example is sys_timer_create() which takes a sigevent argument.
Maybe Bamvor has a test case.

(btw, I'm off for a week, I'll follow up when I get back)

-- 
Catalin
