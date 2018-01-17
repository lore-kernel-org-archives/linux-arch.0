From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and SIGFPE, SIGTRAP, SIGBUS
Date: Wed, 17 Jan 2018 10:45:10 -0600
Message-ID: <87y3kwh1t5.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-7-ebiederm@xmission.com>
        <20180115163028.GU22781@e103592.cambridge.arm.com>
        <87h8rnox3c.fsf@xmission.com>
        <20180116172407.GA22781@e103592.cambridge.arm.com>
        <871sipl9p9.fsf@xmission.com>
        <20180117115708.GM17719@n2100.armlinux.org.uk>
        <20180117121505.GD22781@e103592.cambridge.arm.com>
        <20180117123752.GN17719@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117123752.GN17719@n2100.armlinux.org.uk> (Russell King's
        message of "Wed, 17 Jan 2018 12:37:52 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Wed, Jan 17, 2018 at 12:15:05PM +0000, Dave Martin wrote:
>> On Wed, Jan 17, 2018 at 11:57:09AM +0000, Russell King - ARM Linux wrote:
>> > On Tue, Jan 16, 2018 at 04:28:50PM -0600, Eric W. Biederman wrote:
>> > > I will keep FPE_FIXME as a place holder until this gets sorted out.
>> > > 
>> > > There is a second issue I am looking at in this location,
>> > > and maybe I don't have to address it now.  But it looks like the code is
>> > > calling send_sig_info instead of force_sig_info for a synchronous
>> > > exception.  Am I reading that correctly?
>> > 
>> > VFP used to use force_sig_info(), but it seems to be really the wrong
>> > call to use.  force_sig_info() checks whether the program decided to
>> > ignore or block the signal, and if it did, replaces the signal handler
>> > with the default handler and unblocks the signal.

That ignored and blocked behavior is a very weird implementation,
but for a synchronous signal it amounts to enforcing coredump and
then exit behavior.  As the process does not continue past that
point the behavior is not observable by userspace.

>> > Are you really suggesting that FP all FP signals should get this
>> > treatment?

I am only suggesting that all synchronous signals, aka signals where
it helps to point at the instruction from the signal information
get that treatment.  As the vast majority are synchronous I was
asking about this one oddball case.

>> feenableexcept(FE_OVERFLOW) kind of means "I can't run safely past
>> an fp overflow exception, please signal me instead".
>> 
>> If the process also blocked SIGFPE, that could be taken to mean
>> "I can't run safely past an fp overflow exception _and_ I can't
>> take SIGFPE either" ... i.e., if an fp overflow happens there is
>> no way to proceed and it's really fatal.
>> 
>> What SIG_IGN ought to mean is rather more debatable, but again,
>> the process could be asking for two opposite things: guarantee a
>> SIGFPE is delivered instead of running past an fp exception, and
>> also guarantee that SIGFPE is _not_ delivered.
>> 
>> It looks like arm and arm64 are different from most other arches
>> (including x86) here, but I'm not sure what is considered correct, and
>> it looks like the answer is not standardised.  There's a possibility
>> that some software goes subtly wrong on arm/arm64 where on other arches
>> it would get terminated with SIGKILL.

I looked it up yesterday to be clear, and POSIX actually says the
behavior is implemenation dependent/undefined if you try to ignore
SIGFPE.

>> Whether this matters depends on how harmless the fp exception is to
>> the work of the program.  I think if an exception is set to trap
>> via feenableexcept() then that's a strong hint the programmer thinks
>> that exception is not harmless.  OTOH, trapping is not always
>> available anyway...
>
> Like many of these things, there is no clear answer.  It's a set of
> conflicting requirements, and as you point out, even if you've called
> feenableexcept(), you are not guaranteed to get a trap.
>
> However, do remember that FP exceptions on ARM hardware are already
> asynchronous - they get reported by the _next_ FP operation to the one
> that caused them, which means they could be raised by a library function
> sometime after it occured (when the library function decides to save the
> FP registers to the stack before it makes use of them.)  It's entirely
> possible that the library function has blocked FP signals temporarily
> (not explicitly, just decided to block all signals while it does
> something sensitive) and will unblock them again afterwards - at which
> point we get the SIGFPE, and it would be quite right to deliver that
> signal to the user SIGFPE handler, rather than forcing it onto the
> program mid-library function.
>
> It's also possible that SIGFPE could be blocked by another signal handler
> having been invoked, and it triggers the latent generation of the SIGFPE.
>
> I'd be more inclined to agree with you if VFP exceptions were synchronous
> but they aren't.

From your description there still seems to be an association with an
instruction so I don't know if I would really call the signal
asynchronous.  It sounds like the exception is delayed and not
asynchronous.

>> Was there some particular program being broken by the force_sig_info()
>> here?
>
> I don't recall.

> commit da41119af78864d27ccbf505949df788d5e8aaf5
> Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date:   Wed Jun 29 23:02:02 2005 +0100
> 
>     [PATCH] ARM: Don't force SIGFPE
>     
>     We were forcing SIGFPE on to a user program for no good reason.
>     Use send_sig_info() instead.
>     
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The commit looks like it was a case of the code not looking right
and you just switching to send_sig_info.

force_sig_info really out to be called something like synchronous_sig.

I am looking at sorting that out as part of cleaning up the signal
handling.  There is currently a small bug where under the right
circumstances these synchronous signals might be improperly delivered
after a thread specific signal.  To make that very unlikely there is a
special case in dequeue_signal for synchronous signals but it is
imperfect and slower than necessary.

The function really ought to look something like:

void synch_sig(struct siginfo *info)
{
	struct task_struct *tsk = current;
        int sig = info->si_signo;
        struct ksignal ksig;
	struct k_sigaction *ka;
        bool blocked, ignored;
        unsigned long flags;

        WARN_ON(!siginmask(sig, SYNCHRONOUS_MASK));

	copy_siginfo(info, &ksig.info);
	spin_lock_irqsave(&tsk->sighand->siglock, flags);
	ka = &tsk->sighand->action[sig - 1];
	ignored = ka->sa.sa_handler == SIG_IGN;
	blocked = sigismember(&tsk->blocked, sig);
	ksig.ka = *ka;
	if (blocked || ignored) {
		ksig.ka.sa.sa_handler = SIG_DFL;
	} else if (ka->sa.sa_flags & SA_ONESHOT) {
		ka->sa.sa_handler = SIG_DFL;
	}
	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);

	if (ksig.ka.sa.sa_handler == SIG_DFL) {
		do_coredump(&ksig->info);
		do_group_exit(sig);
		/* NOTREACHED */
	}

	handle_signal(&ksig, signal_pt_regs());
}

Which is both clearer and faster and less buggy than the current
implementation as it delivers the signal immediately with no chance
of the signal queue to reorder things.

But it is going to take a little bit to get there as there are a number
of implementations of handle_signal like the ones on arm and arm64 that
perform needed register adjustments outside of handle_signal.

Eric
