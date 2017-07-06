From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Thu, 6 Jul 2017 16:34:47 +0100
Message-ID: <20170706153446.GI3965@e103592.cambridge.arm.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-9-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdGFPe7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jul 2017 11:34:59 -0400
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-9-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

On Wed, Jul 05, 2017 at 09:49:36AM -0700, Palmer Dabbelt wrote:
> On Mon, 03 Jul 2017 16:06:39 PDT (-0700), james.hogan@imgtec.com wrote:
> > On Thu, Jun 29, 2017 at 02:42:38PM -0700, Palmer Dabbelt wrote:
> >> On Wed, 28 Jun 2017 15:42:37 PDT (-0700), james.hogan@imgtec.com wrote:
> >> > On Wed, Jun 28, 2017 at 11:55:37AM -0700, Palmer Dabbelt wrote:
> >> >> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
> >> >> new file mode 100644
> >> >> index 000000000000..52eff9febcfd
> >> >> --- /dev/null
> >> >> +++ b/arch/riscv/include/uapi/asm/ucontext.h
> >> > ...
> >> >> +struct ucontext {
> >> >> +	unsigned long	  uc_flags;
> >> >> +	struct ucontext	 *uc_link;
> >> >> +	stack_t		  uc_stack;
> >> >> +	sigset_t	  uc_sigmask;
> >> >> +	/* glibc uses a 1024-bit sigset_t */
> >> >> +	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> >> >> +	/* last for future expansion */
> >> >> +	struct sigcontext uc_mcontext;
> >> >> +};
> >> >
> >> > Any particular reason not to use the asm-generic ucontext?
> >>
> >> In the generic ucontext, 'uc_sigmask' is at the end of the structure so it can
> >> be expanded.  Since we want our mcontext to be expandable as well, we
> >> pre-allocate some expandable space for sigmask and then put mcontext at the
> >> end.
> >>
> >> We stole this idea from arm64.
> >
> > Curious. __unused seems like overkill to be honest given that expanding
> > the number of signals up to 128 causes other issues (as discovered on
> > MIPS e.g. the waitpid() status, with stopsig not fitting below the exit
> > code (shift 8) and core dump flag (bit 7)), but perhaps it could be
> > carefully expanded by splitting the stopsig field.
> 
> Sorry, I don't understand the intricacies of this in the slightest.  In general
> we try to avoid surprises in software land in RISC-V, so whenever we do
> something we go look at the most popular architectures (Intel and ARM) and try
> to ensure we don't paint ourselves into any corners that they didn't.

I think Catalin was concerned that putting uc_sigmask at the end breaks
extensibility of sigcontext.

[Catalin, please comment if I'm misquoting you ;) ]


Generic ucontext seems broken in any case, when kernel/user sigset_t
sizes differ:

sigset_t oldmask, newmask;

void handler(int n, siginfo_t *si, void *uc_)
{
	ucontext_t *uc = uc_;

	oldmask = uc->uc_sigmask; uc->uc_sigmask = newmask;
}

With generic ucontext, this can overrun and corrupt memory if the user/
kernel sigset_t sizes differ.  The only fix is to reserve space in
ucontext for the larger of the two sigset sizes, which generic ucontext
does not do.

There's also the problem you comment on where only 7 bits of signal
number are available in wait() status values: with 0x7f being magic and
0 not a valid signal number, that probably allows up to 126 signals.
An arch could possibly have its own definitions to get beyond this, but
it's all done by magic numbers and open-coding in core code today.

i.e., the "extensibility" in generic ucontext may be bogus.


So, you can commit to a sane maximum number of signals (say, 64) in
your ABI, but this means that your libc sigset_t size probably needs to
match and you can never grow beyond that without an ABI break.

Or you can reserve enough space in ucontext for the userspace sigset_t.
Using generic signal.h and ucontext.h effectively commits you to max 64
signals AFAICT.  The extra space may be permanently wasted, but that's
preferable to memory corruption.


(Note, I don't know myself where the "1024" comes from.  Are there any
POSIXish systems implementing anywhere near that number of signals?  Is
there a real usecase for it?  Maybe it's just overzealous
futureproofing?)

> > Looks harmless here I suppose so I defer to others. If it is the
> > preferred approach does it make sense to make it the "default" for new
> > architectures at some point?
> 
> Again, this isn't really my thing, but we chose this because we thought it was
> the sane way to do it.  Unless we're doing something silly, I don't see why it
> wouldn't be a reasonable default.  This is predicated on having expandable
> architectural state, otherwise putting sigmask at the end seems sane.

Note, the contents of sigcontext are nonportable but are nonetheless
ABI, and some userspace software does expect to be able to poke about in
there, modify the signal return state, etc.

Additionally the whole signal frame cannot safely exceed MINSIGSTKSZ in
size (which looks like 2K if you're relying on generic signal.h -- not
a big number when compared against upcoming vector architectures).

Going beyond MINSIGSTKSZ is a user ABI break, as is any non-probeable
change to the contents of struct sigcontext, including changes to its
size.


We are burned by this on arm64 with SVE: arm64 has its own MINSIGSTKSZ
(5K), which is not enough for the biggest possible SVE implemetations
(over 8K for the SVE state alone).  I have some proposals to mitigate
this [1], but a complete solution is not possible.

Without any flags, size or version field or some kind of extensible
list structure, you would likely have trouble extending your sigcontext
without ABI breaks.


The ucontext API is unfortunately fundamentally broken, especially with
regard to extensibility.  It's debatable whether the context argument
to sigaction handlers should have been ucontext_t, but we seem to be
stuck with it.  POSIX no longer attempts to specify most of the de
facto ucontext API behaviour, but it persists because there are things
that userspace can't do any other way.

In principle we could cook up a new signal interface, and a new arch
could avoid the current and legacy interfaces entirely.

For example, the signal context could be made properly extensible, and
a cookie could be registered for each handler so that libc can wrap
signal handlers without the need for runtime-generated trampolines.
Then a POSIX compatibilty interface could be implemented in libc.

Could be a tough sell though -- and there's a fair risk we'd come up
with something that is still broken.


Cheers
---Dave

[1] [RFC PATCH v2 0/6] Signal frame expansion support
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/501163.html

(Now merged, except for the AT_MINSIGSTKSZ auxv entry to report the
signal frame size -- since we won't need this until later and it could
benefit from more discussion and it would be good to build some
consensus around it if possible.  I plan to talk about this and
related topics at Plumbers.)
