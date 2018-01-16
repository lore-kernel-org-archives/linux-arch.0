From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and SIGFPE, SIGTRAP, SIGBUS
Date: Tue, 16 Jan 2018 16:28:50 -0600
Message-ID: <871sipl9p9.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-7-ebiederm@xmission.com>
        <20180115163028.GU22781@e103592.cambridge.arm.com>
        <87h8rnox3c.fsf@xmission.com>
        <20180116172407.GA22781@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:60493 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeAPW3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jan 2018 17:29:47 -0500
In-Reply-To: <20180116172407.GA22781@e103592.cambridge.arm.com> (Dave Martin's
        message of "Tue, 16 Jan 2018 17:24:07 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Mon, Jan 15, 2018 at 11:23:03AM -0600, Eric W. Biederman wrote:
>> Dave Martin <Dave.Martin@arm.com> writes:
>> 
>> > On Thu, Jan 11, 2018 at 06:59:36PM -0600, Eric W. Biederman wrote:
>> >> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>> >> This is the same si_code as SI_USER.  Posix and common sense requires
>> >> that SI_USER not be a signal specific si_code.  As such this use of 0
>> >> for the si_code is a pretty horribly broken ABI.
>> >
>> > I think this situation may have come about because 0 is used as a
>> > padding value for "impossible" cases -- i.e., things that can't happen
>> > unless the kernel is broken, or things that are too unrecoverable for
>> > clean error reporting to be helpful.
>> >
>> > In general, I think these values are not expected to reach userspace in
>> > practice.
>> >
>> > This is not an excuse though -- and not 100% true -- so it's certainly
>> > worthy of cleanup.
>> >
>> >
>> > It would be good to approach this similarly for arm and arm64, since
>> > the arm64 fault code is derived from arm.
>> 
>> In this case the fault_info is something I have only seen on arm64.
>> I have been approaching all architectures the same way.
>
> Bad guess on my part; this table-driven approach seems to be new for
> arm64.
>
>> If there is insufficient information without architecture expertise
>> to fix this class of error I have been ading FPE_FIXME to them.
>
> Fair enough.
>
>> >> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>> >> value of __SI_KILL and now sees a value of SIL_KILL with the result
>> >> that uid and pid fields are copied and which might copying the si_addr
>> >> field by accident but certainly not by design.  Making this a very
>> >> flakey implementation.
>> >> 
>> >> Utilizing FPE_FIXME, BUS_FIXME, TRAP_FIXME siginfo_layout will now return
>> >> SIL_FAULT and the appropriate fields will be reliably copied.
>> >> 
>> >> But folks this is a new and unique kind of bad.  This is massively
>> >> untested code bad.  This is inventing new and unique was to get
>> >> siginfo wrong bad.  This is don't even think about Posix or what
>> >> siginfo means bad.  This is lots of eyeballs all missing the fact
>> >> that the code does the wrong thing bad.  This is getting stuck
>> >> and keep making the same mistake bad.
>> >> 
>> >> I really hope we can find a non userspace breaking fix for this on a
>> >> port as new as arm64.
>> >
>> >> Possible ABI fixes include:
>> >> - Send the signal without siginfo
>> >> - Don't generate a signal
>> >
>> > The above two sould like ABI breaks?
>> 
>> They are ways I have seen code on other platforms deal with
>> not information to generate siginfo.  Sending the signal without siginfo
>> is roughly equivalent to your send SIGKILL suggestion below.
>> 
>> A good example of that is code that calls force_sigsegv.
>> 
>> Calling "force_sig(SIGBUS, current);" is perfectly valid.
>> And then the parent when it reaped the process would have
>> a little more information to go on when guessing what happened
>> to the process.
>> 
>> >> - Possibly assign and use an appropriate si_code
>> >> - Don't handle cases which can't happen
>> >
>> > I think a mixture of these two is the best approach.
>> >
>> > In any case, si_code == 0 here doesn't seem to have any explicit meaning.
>> > I think we can translate all of the arm64 faults to proper si_codes --
>> > see my sketch below.  Probably means a bit more thought though.
>> 
>> Yes I would be very happy to see that.
>> 
>> > The only counterargument would be if there is software relying on
>> > these bogus signal cases getting si_code == 0 for a useful purpose.
>> >
>> > The main reason I see to check for SI_USER is to allow a process to
>> > filter out spurious signals (say, an asynchronous I/O signal for
>> > which si_value would be garbage), and to print out diagnostics
>> > before (in the case of a well-behaved program) resetting the signal
>> > to SIG_DFL and killing itself to report the signal to the waiter.
>> >
>> > Daemons may be more discerning about who is allowed to signal them,
>> > but overloading SIGBUS (say) as an IPC channel sounds like a very odd
>> > thing to do.  The same probably applies to any signal that has
>> > nontrivial metadata.
>> 
>> Agreed.  Although I have seen ltp test cases that do crazy things like
>> that.
>> 
>> > Have you found software that is impacted by this in practice?
>> 
>> No.
>
> Searching for si_code on codesearch.debian.net, I looked at a few
> random hits.  Although this is far from exhaustive, I saw no instance
> of code that assumes some arch-specific meaning for SI_USER (or 0).
>
> Most code seems to check for signal-specific si_code values before
> assuming that signal-specific signifo fields are valid; or for
> SI_USER (or si_code <= 0) before assuming that si_uid and si_pid
> are valid.
>
> Returning proper values for si_code values in place of "0" would fix
> rather than break such cases.
>
>
>> I don't expect many userspace applications look at siginfo and
>> everything I have found is some rare hard to trigger non-x86 case which
>> limits the exposure to userspace applications tremendously.
>> 
>> The angle I am coming at all of this from is that the linux kernel code
>> that filled out out struct siginfo was not comprehensible or correct.
>
> I think "not comprehensible or correct" is a pretty good summary of
> all signal-related code...
>
>> Internal to the kernel it was using a magic value (not exportable to
>> userspace) in the upper bits of si_code.  That was causing problems for
>> signal injection and converting signals from 32bit to 64bit, and from
>> 64bit to 32bit.
>> 
>> So I wrote kernel/signal.c:siginfo_layout() to figure out which fields
>> of struct siginfo should be sent to userspace.  In doing so I discovered
>> that using 0 in si_code (aka SI_USER) is ambiguous, and problematic.
>> 
>> Unfortuantely in most of the cases I have spotted using 0 in the si_code
>> requires architectural knowledge that I don't currently have to sort
>> out.  So the best I can do is change si_code from 0 to
>> FPE_FIXME/BUS_FIXME/TRAP_FIXME and bring the architecture maintainers
>> attention to this area.
>> 
>> One of the problems that results from all of this is that we copy
>> unitialized data to userspace.   I am slowly unifying and cleaning the
>> code up so that the code is simple enough we can be certain we are
>> not copying unitialized data to userspace.
>> 
>> With si_coes of FPE_FIXME/BUS_FIXME/TRAP_FIXME I can at least attempt to
>> keep the craziness from happening.
>> 
>> My next step is to unify struct siginfo and struct compat_siginfo
>> and the functions that copy them to userspace because there are very
>> siginficant problems there.
>
> All of which sounds valuable.
>
>> All of that said I like the way you are thinking about fixing these
>> issues.
>
> Is it feasible to have a different internal constant for SI_USER?
> Then the generic could warn if it sees si_code == 0.  If the
> special nonzero KERNEL_SI_USER is seen instead, it is silently
> translated to SI_USER (0) for userspace.  This might help us
> track down cases where 0 is passed by accident.
>
> It may not be worth it though: if the affected cases are ones
> that happen never or almost never, a runtime BUG_ON() may not be
> helpful for tracking them down.
>
> Also, I'm making an assumption that si_code always flows through
> some generic code before reaching userspace (maybe untrue).

The code does flow through a generic path, and I am in the middle of
tightening that up right now.  As filling out siginfo is error prone,
and I need a guarantee that all of struct siginfo is initialized.
Adding a warning if a arch fault hander uses si_code == 0 aka SI_USER
would not be hard.

Given what you have found.  Given that it seems to match my experience
we can almost certainly change the code to just warn when the 0 is
passed in for the si_code for fault handlers.

I want to ensure that all of the fields are filled in before I do that
or else I risk passing unitialized values to userspace.  But I like that
as the long term goal for this code.

>> >> +++ b/arch/arm64/kernel/fpsimd.c
>> >> @@ -867,7 +867,7 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
>> >>  asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>> >>  {
>> >>  	siginfo_t info;
>> >> -	unsigned int si_code = 0;
>> >> +	unsigned int si_code = FPE_FIXME;
>> >>  
>> >>  	if (esr & FPEXC_IOF)
>> >>  		si_code = FPE_FLTINV;
>> >
>> > This 0 can happen for vector operations where the implementation may
>> > not be able to report exactly what happened, for example where
>> > the implementer didn't want to pay the cost of tracking exactly
>> > what went wrong in each lane.
>> >
>> > However, the FPEXC_* bits can be garbage in such a case rather
>> > than being all zero: we should be checking the TFV bit in the ESR here.
>> > This may be a bug.
>> >
>> > Perhaps FPE_FLTINV should be returned in si_code for such cases:  it's
>> > not otherwise used on arm64 -- invalid instructions would be reported as
>> > SIGILL/ILL_ILLOPC instead).
>> >
>> > Otherwise, we might want to define a new code or arbitrarily pick
>> > one of the existing FLT_* since this is really a more benign condition
>> > than executing an illegal instruction.  Alternatively, treat the
>> > fault as spurious and suppress it, but that doesn't feel right either.
>> 
>> I would love to see this sorted out.  There is a very similar pattern
>> on several different architectures.  I suspect if we have a clean
>> solution on one architecture the other architectures will be able to use
>> that solution as well.
>
> Since user code that relies on checking si_code for fp exceptions will
> probably already break in these cases, we can probably fudge things a
> bit here.
>
> I'll have a think.  IEEE may also define some rules that are relevant
> here...
>
> For the proposed conversion of the si_code==0 cases for arm64, I'll
> draft an RFC for discussion (hopefully sometime this week).

Sounds good.

I will keep FPE_FIXME as a place holder until this gets sorted out.

There is a second issue I am looking at in this location,
and maybe I don't have to address it now.  But it looks like the code is
calling send_sig_info instead of force_sig_info for a synchronous
exception.  Am I reading that correctly?

Eric
