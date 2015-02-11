Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.arm.com ([217.140.108.86]:43193 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbBKPlL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Feb 2015 10:41:11 -0500
Date: Wed, 11 Feb 2015 15:40:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
Message-ID: <20150211154054.GD9058@e104818-lin.cambridge.arm.com>
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com>
 <20150210122718.GC32052@e104818-lin.cambridge.arm.com>
 <54DB3B60.4050100@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54DB3B60.4050100@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Cc: linux-arch@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lizefan@huawei.com" <lizefan@huawei.com>, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150211154054.M8TUoL1XU4-jrNXT6TOy6ThlmV8v5RQuMprahFUIPKA@z>

On Wed, Feb 11, 2015 at 07:22:08PM +0800, Bamvor Jian Zhang wrote:
> On 2015/2/10 20:27, Catalin Marinas wrote:
> > On Tue, Feb 10, 2015 at 10:10:11AM +0000, Zhang Jian(Bamvor) wrote:
> >> In 64bit architecture, sigval_int is the high 32bit of sigval_ptr in
> >> big endian kernel compare with low 32bit of sigval_ptr in little
> >> endian kernel. reference:
> >>
> >>     typedef union sigval {
> >>         int sival_int;
> >>         void *sival_ptr;
> >>     } sigval_t;
> >>
> >> During compat_mq_notify or compat_timer_create, kernel get sigval
> >> from user space by reading sigval.sival_int. This is correct in 32 bit
> >> kernel and in 64bit little endian kernel. And It is wrong in 64bit big
> >> endian kernel:
> >> It get the high 32bit of sigval_ptr and put it to low 32bit of
> >> sigval_ptr. And the high 32bit sigval_ptr in empty in arm 32bit user
> >> space struct. So, kernel lost the value of sigval_ptr.
> >>
> >> The following patch get the sigval_ptr in stead of sigval_int in order
> >> to avoid endian issue.
> >> Test pass in arm64 big endian and little endian kernel.
> >>
> >> Signed-off-by: Zhang Jian(Bamvor) <bamvor.zhangjian@huawei.com>
> >> ---
> >>  ipc/compat_mq.c | 7 ++-----
> >>  kernel/compat.c | 6 ++----
> >>  2 files changed, 4 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/ipc/compat_mq.c b/ipc/compat_mq.c
> >> index ef6f91c..2e07343 100644
> >> --- a/ipc/compat_mq.c
> >> +++ b/ipc/compat_mq.c
> >> @@ -99,11 +99,8 @@ COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
> >>  	if (u_notification) {
> >>  		struct sigevent n;
> >>  		p = compat_alloc_user_space(sizeof(*p));
> >> -		if (get_compat_sigevent(&n, u_notification))
> >> -			return -EFAULT;
> >> -		if (n.sigev_notify == SIGEV_THREAD)
> >> -			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
> >> -		if (copy_to_user(p, &n, sizeof(*p)))
> >> +		if (get_compat_sigevent(&n, u_notification) ||
> >> +		    copy_to_user(p, &n, sizeof(*p)))
> >>  			return -EFAULT;
> > 
> > The kernel doesn't need to interpret the sival_ptr value, it's something
> > to be passed to the notifier function as an argument.

Actually I was wrong here. The kernel _does_ interpret the sival_ptr to
read a cookie in sys_mq_notify() for PF_NETLINK sockets. So this code is
correct.

> >>  	}
> >>  	return sys_mq_notify(mqdes, p);
> >> diff --git a/kernel/compat.c b/kernel/compat.c
> >> index ebb3c36..13a0e5d 100644
> >> --- a/kernel/compat.c
> >> +++ b/kernel/compat.c
> >> @@ -871,16 +871,14 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
> >>   * We currently only need the following fields from the sigevent
> >>   * structure: sigev_value, sigev_signo, sig_notify and (sometimes
> >>   * sigev_notify_thread_id).  The others are handled in user mode.
> >> - * We also assume that copying sigev_value.sival_int is sufficient
> >> - * to keep all the bits of sigev_value.sival_ptr intact.
> >>   */
> >>  int get_compat_sigevent(struct sigevent *event,
> >>  		const struct compat_sigevent __user *u_event)
> >>  {
> >>  	memset(event, 0, sizeof(*event));
> >>  	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
> >> -		__get_user(event->sigev_value.sival_int,
> >> -			&u_event->sigev_value.sival_int) ||
> >> +		__get_user(*(long long*)event->sigev_value.sival_ptr,
> 
> should be:
> 		__get_user(event->sigev_value.sival_ptr,
> 
> > > +         &u_event->sigev_value.sival_ptr) ||
> >
> > I don't think this is correct because some (most) architectures use
> > sival_int here when copying to user and for a big endian compat they
> > would get 0 for sival_int (mips, powerpc).
> 
> Sorry, I am lost here. As we mentioned above, sival_ptr and sival_int
> is union, so, copy sival_ptr should include sival_int.

The user access size in your patch is the size of sival_ptr which is
32-bit for compat, same as sival_int; so far, so good. However, when you
store it to the native sival_ptr, you perform a conversion to long long
(shouldn't it be unsigned long long, or just unsigned long?).

The native sigval_t is also a union but on 64-bit big endian, the
sival_int overlaps with the most significant 32-bit of the sival_ptr.
So reading sival_int would always be 0. When the compat siginfo is
copied to user, arm64 reads the native sival_ptr (si_ptr) and converts
it to the compat one, getting the correct 32-bit value. However, other
architectures access sival_int (si_int) instead which breaks with your
get_compat_sigevent() changes.

> > I think the correct fix is in the arm64 code:
> 
> The following code could fix my issue.

Without any parts of your patch?

I think that's correct fix since in the SIGEV_THREAD mq_notify case, we
would not deliver a signal as notification, so the sival_int value is
irrelevant (it would be 0 for big-endian compat tasks because of the
sigval_t union on 64-bit).

Your patch would work as well but you have to change all the other
architectures to use si_ptr when copying to a compat siginfo.

> > diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> > index e299de396e9b..32601939a3c8 100644
> > --- a/arch/arm64/kernel/signal32.c
> > +++ b/arch/arm64/kernel/signal32.c
> > @@ -154,8 +154,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
> >  	case __SI_TIMER:
> >  		 err |= __put_user(from->si_tid, &to->si_tid);
> >  		 err |= __put_user(from->si_overrun, &to->si_overrun);
> > -		 err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
> > -				   &to->si_ptr);
> > +		 err |= __put_user(from->si_int, &to->si_int);
> >  		break;
> >  	case __SI_POLL:
> >  		err |= __put_user(from->si_band, &to->si_band);
> > @@ -184,7 +183,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
> >  	case __SI_MESGQ: /* But this is */
> >  		err |= __put_user(from->si_pid, &to->si_pid);
> >  		err |= __put_user(from->si_uid, &to->si_uid);
> > -		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
> > +		err |= __put_user(from->si_int, &to->si_int);
> >  		break;
> >  	case __SI_SYS:
> >  		err |= __put_user((compat_uptr_t)(unsigned long)

-- 
Catalin
