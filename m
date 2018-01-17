From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and SIGFPE, SIGTRAP, SIGBUS
Date: Wed, 17 Jan 2018 11:24:06 -0600
Message-ID: <87h8rkflft.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-7-ebiederm@xmission.com>
        <20180115163028.GU22781@e103592.cambridge.arm.com>
        <87h8rnox3c.fsf@xmission.com>
        <20180117171729.GJ22781@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117171729.GJ22781@e103592.cambridge.arm.com> (Dave Martin's
        message of "Wed, 17 Jan 2018 17:17:29 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Mon, Jan 15, 2018 at 11:23:03AM -0600, Eric W. Biederman wrote:
>> Dave Martin <Dave.Martin@arm.com> writes:
>> 
>> > On Thu, Jan 11, 2018 at 06:59:36PM -0600, Eric W. Biederman wrote:
>
> [...]
>
>> >> Possible ABI fixes include:
>> >> - Send the signal without siginfo
>> >> - Don't generate a signal
>
> [...]
>
>> >> - Possibly assign and use an appropriate si_code
>> >> - Don't handle cases which can't happen
>> >
>> > I think a mixture of these two is the best approach.
>> >
>> > In any case, si_code == 0 here doesn't seem to have any explicit meaning.
>> > I think we can translate all of the arm64 faults to proper si_codes --
>> > see my sketch below.  Probably means a bit more thought though.
>
> [...]
>
>> >> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>
> [...]
>
>> >> @@ -607,70 +607,70 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>> >>  }
>> >>  
>> >>  static const struct fault_info fault_info[] = {
>> >> -	{ do_bad,		SIGBUS,  0,		"ttbr address size fault"	},
>> >> -	{ do_bad,		SIGBUS,  0,		"level 1 address size fault"	},
>> >> -	{ do_bad,		SIGBUS,  0,		"level 2 address size fault"	},
>> >> -	{ do_bad,		SIGBUS,  0,		"level 3 address size fault"	},
>
> If I convert this kind of thing to SIGKILL there really is nothing
> sensible to put in si_code, except possibly SI_KERNEL (indicating that
> the kill did not come from userspace).  Even so, it hardly seems worth
> filling in fields like si_pid and si_uid just to make this "correct".
>
> In any case, if siginfo is never seen by userspace for SIGKILL this is
> moot.
>
> Obviously, siginfo is never copied to the user stack in that case, but
> is it also guaranteed not to be visible to userspace by other means?
> For ptrace I'm hoping not, since SIGKILL should nuke the tracee
> immediately instead of being reported to the tracer as a
> signal-delivery-stop -- so the tracer should get WIFSIGNALED() &&
> WTERMSIG() == SIGKILL.  A subsequent PTRACE_GETSIGINFO would fail with
> ESRCH.
>
> Does that match your understanding?
>
> If so, there is some merit in not pretending to pass a reall value
> for si_code.
>
> Should si_code simply be ignored for the SIGKILL case?

I know what x86 does in a similar case is it uses force_sig instead of
force_sig_info.  Then the generic code gets to worry about 

If the appropriate paths generic paths get to worry about what siginfo
to fill in in that case.  Which for SI_KERNEL is zero for everything
except the si_code and the si_signo.

That seems perfectly reasonable.

Eric
