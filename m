From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
Date: Mon, 15 Jan 2018 16:30:29 +0000
Message-ID: <20180115163028.GU22781@e103592.cambridge.arm.com>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966183AbeAOQae (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jan 2018 11:30:34 -0500
Content-Disposition: inline
In-Reply-To: <20180112005940.23279-7-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Jan 11, 2018 at 06:59:36PM -0600, Eric W. Biederman wrote:
> Setting si_code to 0 results in a userspace seeing an si_code of 0.
> This is the same si_code as SI_USER.  Posix and common sense requires
> that SI_USER not be a signal specific si_code.  As such this use of 0
> for the si_code is a pretty horribly broken ABI.

I think this situation may have come about because 0 is used as a
padding value for "impossible" cases -- i.e., things that can't happen
unless the kernel is broken, or things that are too unrecoverable for
clean error reporting to be helpful.

In general, I think these values are not expected to reach userspace in
practice.

This is not an excuse though -- and not 100% true -- so it's certainly
worthy of cleanup.


It would be good to approach this similarly for arm and arm64, since
the arm64 fault code is derived from arm.


> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
> value of __SI_KILL and now sees a value of SIL_KILL with the result
> that uid and pid fields are copied and which might copying the si_addr
> field by accident but certainly not by design.  Making this a very
> flakey implementation.
> 
> Utilizing FPE_FIXME, BUS_FIXME, TRAP_FIXME siginfo_layout will now return
> SIL_FAULT and the appropriate fields will be reliably copied.
> 
> But folks this is a new and unique kind of bad.  This is massively
> untested code bad.  This is inventing new and unique was to get
> siginfo wrong bad.  This is don't even think about Posix or what
> siginfo means bad.  This is lots of eyeballs all missing the fact
> that the code does the wrong thing bad.  This is getting stuck
> and keep making the same mistake bad.
> 
> I really hope we can find a non userspace breaking fix for this on a
> port as new as arm64.

> Possible ABI fixes include:
> - Send the signal without siginfo
> - Don't generate a signal

The above two sould like ABI breaks?

> - Possibly assign and use an appropriate si_code
> - Don't handle cases which can't happen

I think a mixture of these two is the best approach.

In any case, si_code == 0 here doesn't seem to have any explicit meaning.
I think we can translate all of the arm64 faults to proper si_codes --
see my sketch below.  Probably means a bit more thought though.



The only counterargument would be if there is software relying on
these bogus signal cases getting si_code == 0 for a useful purpose.

The main reason I see to check for SI_USER is to allow a process to
filter out spurious signals (say, an asynchronous I/O signal for
which si_value would be garbage), and to print out diagnostics
before (in the case of a well-behaved program) resetting the signal
to SIG_DFL and killing itself to report the signal to the waiter.

Daemons may be more discerning about who is allowed to signal them,
but overloading SIGBUS (say) as an IPC channel sounds like a very odd
thing to do.  The same probably applies to any signal that has
nontrivial metadata.


Have you found software that is impacted by this in practice?

[...]

> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -867,7 +867,7 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
>  asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>  {
>  	siginfo_t info;
> -	unsigned int si_code = 0;
> +	unsigned int si_code = FPE_FIXME;
>  
>  	if (esr & FPEXC_IOF)
>  		si_code = FPE_FLTINV;

This 0 can happen for vector operations where the implementation may
not be able to report exactly what happened, for example where
the implementer didn't want to pay the cost of tracking exactly
what went wrong in each lane.

However, the FPEXC_* bits can be garbage in such a case rather
than being all zero: we should be checking the TFV bit in the ESR here.
This may be a bug.

Perhaps FPE_FLTINV should be returned in si_code for such cases:  it's
not otherwise used on arm64 -- invalid instructions would be reported as
SIGILL/ILL_ILLOPC instead).

Otherwise, we might want to define a new code or arbitrarily pick
one of the existing FLT_* since this is really a more benign condition
than executing an illegal instruction.  Alternatively, treat the
fault as spurious and suppress it, but that doesn't feel right either.


> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9b7f89df49db..abe200587334 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -596,7 +596,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  
>  	info.si_signo = SIGBUS;
>  	info.si_errno = 0;
> -	info.si_code  = 0;
> +	info.si_code  = BUS_FIXME;

Probably BUS_OBJERR.

>  	if (esr & ESR_ELx_FnV)
>  		info.si_addr = NULL;
>  	else
> @@ -607,70 +607,70 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  }
>  
>  static const struct fault_info fault_info[] = {
> -	{ do_bad,		SIGBUS,  0,		"ttbr address size fault"	},
> -	{ do_bad,		SIGBUS,  0,		"level 1 address size fault"	},
> -	{ do_bad,		SIGBUS,  0,		"level 2 address size fault"	},
> -	{ do_bad,		SIGBUS,  0,		"level 3 address size fault"	},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"ttbr address size fault"	},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"level 1 address size fault"	},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"level 2 address size fault"	},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"level 3 address size fault"	},

Pagetable screwup or kernel/system/CPU bug -> SIGKILL, or panic().

[...]

> -	{ do_bad,		SIGBUS,  0,		"unknown 8"			},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 8"			},

[...]

> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 12"			},

Not architected, so they could mean absolutely anything.  If they
can happen at all, they are probably unsafe to ignore.

 -> SIGKILL, or panic().

Similary for all the "unknown" codes in the table, which I omit for
brevity.

> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"synchronous external abort"	},

This si_code seems to be a fallback for if ACPI is absent or doesn't
know what to do with this error.

-> SIGBUS/BUS_OBJERR?

Can probably legitimately happen for userspace for suitable MMIO mappings.

Perhaps it's more serious though in the presence of ACPI.  Do we expect
that ACPI can diagnose all localisable errors?

> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 0 (translation table walk)"	},
> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 1 (translation table walk)"	},
> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 2 (translation table walk)"	},
> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 3 (translation table walk)"	},

Pagetable screwup or kernel/system/CPU bug -> SIGKILL, or panic().

> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"synchronous parity or ECC error" },	// Reserved when RAS is implemented

Possibly SIGBUS/BUS_MCEERR_AR (though I don't know exactly what
userspace is supposed to do with this or whether this implies the
existence or certain kernel features for managing the error that
may not be present on arm64...)

Otherwise, SIGKILL.

> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 0 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 1 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 2 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
> +	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 3 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented

Process page tables corrupt: if the kernel couldn't fix this, the
process can't reasonably fix it -> SIGKILL

Since this is a RAS-type error it could be triggered by a cosmic ray
rather than requiring a kernel or system bug or other major failure, so
we probably shouldn't panic the system if the error is localisable to a
particular process.

>  	{ do_alignment_fault,	SIGBUS,  BUS_ADRALN,	"alignment fault"		},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"TLB conflict abort"		},

Broken kernel, kernel memory corruption, CPU/system bug etc.:
SIGKILL or panic().

> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"Unsupported atomic hardware update fault"	},

Broken kernel, kernel memory corruption, CPU/system bug etc.:
SIGKILL or panic().

> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"implementation fault (lockdown abort)" },

Userspace shouldn't have access to lockdown: kernel/system bug
-> SIGKILL or panic().

> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"implementation fault (unsupported exclusive)" },

If running on an implementation where this fault can happen in response to an exclusive load/store issued by userspace may fail somewhere in the memory system, this should probably be SIGBUS/BUS_OBJERR (or possibly a new BUS_* code).

This one may need to be hardware-dependent, if this fault can mean
something different depending on the hardware (I'm gussing this
possibility from "implementation" -- I've not checked the docs.)

> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"section domain fault"		},
> +	{ do_bad,		SIGBUS,  BUS_FIXME,	"page domain fault"		},

Broken kernel, kernel memory corruption, CPU/system bug etc.:
SIGKILL or panic().

>  };
>  
>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
> @@ -739,11 +739,11 @@ static struct fault_info __refdata debug_fault_info[] = {
> +	{ do_bad,	SIGBUS,		BUS_FIXME,	"unknown 3"		},
> +	{ do_bad,	SIGTRAP,	TRAP_FIXME,	"aarch32 vector catch"	},
> +	{ do_bad,	SIGBUS,		BUS_FIXME,	"unknown 7"		},
>  };

Impossible (?), or meaning unknown.
SIGKILL/panic() for these?  Or possibly (since these are probably well
localised errors) SIGILL/ILL_ILLOPC.

Cheers
---Dave
