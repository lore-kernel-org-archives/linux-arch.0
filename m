From: Roland McGrath <roland@redhat.com>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 16:57:42 -0700 (PDT)
Message-ID: <20080912235742.C8FA915420D@magilla.localdomain>
References: <20080912134011.GA7385@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <utrace-devel-bounces@redhat.com>
In-Reply-To: Russell King's message of  Friday,
	12 September 2008 14:40:11 +0100
	<20080912134011.GA7385@flint.arm.linux.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/utrace-devel>,
	<mailto:utrace-devel-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/utrace-devel>
List-Post: <mailto:utrace-devel@redhat.com>
List-Help: <mailto:utrace-devel-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/utrace-devel>,
	<mailto:utrace-devel-request@redhat.com?subject=subscribe>
Sender: utrace-devel-bounces@redhat.com
Errors-To: utrace-devel-bounces@redhat.com
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> ptrace_report_syscall
> ---------------------
> 
> What's the purpose of the PT_PTRACED check in there?  [...]

The short answer is that tracehook_report_syscall_* is just about moving
the current ptrace logic into the shared inline, not changing that logic.
So it's a separate issue.  The current logic (in arch/arm/kernel/ptrace.c
too) has the check, I didn't change that.

In fact, I think it's not entirely redundant.  When the tracer exits
suddenly without doing PTRACE_DETACH (kill -9 gdb or whatnot), then
->ptrace gets cleared but TIF_SYSCALL_TRACE never gets reset.  
(That very arguably should be fixed, but it's not anything new.)

But all that's entirely orthogonal to consolidating each arch's copy of the
code into ptrace_report_syscall, which is the only change to this area of
ptrace that the tracehook migration itself does.

> Also, shouldn't ptrace_report_syscall() be in linux/ptrace.h, since it's
> just the guts of the existing syscall tracing hook irrespective of the
> tracehook stuff?

I have no objection.

> So, in order to know which register argument N is in, you need to know
> all the types of the arguments which come before it.  That means
> creating and maintaining a table of syscall arguments which sounds
> really sucky.

I certainly don't propose that you do any of that.  I think this is just a
documentation issue.  Instead of "syscall arguments", read "syscall
argument registers, in the most naturally useful order for your arch".

Everything about these values, and the syscall # value (when != -1L), is
entirely arch-specific.  The asm/syscall.h interfaces aren't meant to make
the meaning of those bits generic.

For example, on all 32-bit machines, __NR_pread64 logically takes 4
arguments but that's in 5 argument registers.  In the syscall.h calls,
args[3] means only the 4th argument register, not the whole "4th argument"
(which is (args[3] | (args[4] << 32)) on LE-32).

Indeed, we do expect userland to know exactly which registers, in which
order, we mean by "the 6 syscall arg registers" on the particular arch/ABI.
It may be handy for userland that on some arch's or for many syscalls on
most arch's, this happens to correspond with one argument per register in
the natural order of syscall arguments at source level.  But it's
userland's problem to grok the ABI enough to know what these 6 registers
plus the syscall # mean.

The reason we need syscall_get_arguments is that it can be used in places
that the full user_regset calls can't be, such as in task_current_syscall.
It's deep knowledge of the internals of the kernel's entry paths to know
which user registers can and can't be found correctly in pt_regs when
inside a fast-path system call entry.  Nothing in userland knows that, nor
should it.  (And anyway, the user_regset calls are only kosher to call at
"safe spots" like ptrace/signal stops--so that the arch's regset code is
not obliged to carefully slice and dice for partially-available regsets.)
When inside a syscall, the argument registers were certainly copied in, so
we specify syscall_get_arguments assuming that these can always be got.


Thanks,
Roland
