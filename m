From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 19/44] metag: Signal handling
Date: Thu, 6 Dec 2012 11:17:34 +0000
Message-ID: <50C07ECE.9070602@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <1354723742-6195-20-git-send-email-james.hogan@imgtec.com> <20121205171609.GW4939@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55596 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965097Ab2LFLRo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Dec 2012 06:17:44 -0500
In-Reply-To: <20121205171609.GW4939@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Hi Al,

Thanks for reviewing.

On 05/12/12 17:16, Al Viro wrote:
>> +	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
>> +		goto badframe;
>> +	/* It is more difficult to avoid calling this function than to
>> +	   call it and ignore errors.  */
>> +	do_sigaltstack((__force const stack_t __user *)&st, NULL, regs->REG_SP);
> 
> "Dear sparse, please shut the fuck up.  This function might expect a userland
> pointer for some reason, but I've just copied the damn thing on stack and
> if I say that it's at userland address, at userland address it is".
> 
> 1) __force-cast will make sparse to STFU, indeed
> 2) address of local variable is not a userland pointer.  In particular,
> copy_from_user() will barf on it, unless you play with set_fs(), which
> you don't do.
> 3) do_sigaltstack() *does* copy_from_user(), so it'll simply fail and do
> nothing; adding set_fs() games would have prevented that, but why the hell
> bother creating a local copy in the first place?  Just give &frame->uc.uc_stack
> to do_sigaltstack() and check that it hasn't returned -EFAULT.

Agreed, it looks wrong. Looking at the sh version, is there a particular
reason to only check for -EFAULT and not the other errors that
do_sigaltstack can return (-EPERM, -EINVAL, and -ENOMEM)?

> 4) sh et.al. were broken in exactly the same way.  Fixed in mainline now.
> 5) if you need a force-cast, it might be worth figuring out what's going on.
> 
>> +static void do_signal(struct pt_regs *regs, int from_syscall,
>> +		      unsigned int orig_syscall)
>> +{
>> +	struct k_sigaction ka;
>> +	siginfo_t info;
>> +	int signr;
>> +
>> +	/*
>> +	 * We want the common case to go fast, which
>> +	 * is why we may in certain cases get here from
>> +	 * kernel mode. Just return without doing anything
>> +	 * if so.
>> +	 */
>> +	if (!user_mode(regs))
>> +		return;
> 
> Can you really get here with !user_mode(regs)?  If so, you are very likely
> screwed and badly.

Agreed, it's only called through do_notify_resume() from tail_end()
which already checks user_mode(regs), so it's no longer relevant. I'll
remove that check.

> 
>> +	if (from_syscall) {
>> +		/* Restart the system call - no handlers present */
>> +		switch (syscall_get_error(current, regs)) {
>> +		case -ERESTARTNOHAND:
>> +		case -ERESTARTSYS:
>> +		case -ERESTARTNOINTR:
>> +			regs->REG_SYSCALL = orig_syscall;
>> +			regs->REG_PC -= 4;
> 
> ... and what's to prevent getting here again?  Unless you only handle one
> signal and bugger off to userland immediately, which is also quite broken.

Yes, by the looks of it we only got away with this due to the lack of
the work loop, which as you say is a bit broken.

> BTW, what's to stop the syscall restart triggering if you catch a signal
> while in rt_sigreturn(2)?

I'm not sure I understand how that could cause a problem. Could you
elaborate the sequence of events?

The signal restart is triggered by the return value register, so
rt_sigreturn would have to return -ERESTART*. This could happen if the
signal handler overwrote the return value in the sigcontext (which as
far as I can tell could also happen on ARM), or if the syscall that was
originally interrupted by the signal has -ERESTARTNOINTR ||
(-ERESTARTSYS && SA_RESTART), but in that case rt_sigreturn has already
switched back to the context of the original syscall so that's the right
thing to do isn't it? I've probably missed something important :-)

Thanks for your time,

James
