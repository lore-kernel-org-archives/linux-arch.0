From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
Date: Mon, 27 Jul 2020 15:28:40 -0700
Message-ID: <CALCETrW_CrpYnBWipDQkznRakbb2FnayiN4PLWH7Mid5-ryBYw@mail.gmail.com>
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200716185424.011950288@linutronix.de>
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2020 at 12:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> On syscall entry certain work needs to be done:
>
>    - Establish state (lockdep, context tracking, tracing)
>    - Conditional work (ptrace, seccomp, audit...)
>
> This code is needlessly duplicated and  different in all
> architectures.
>
> +
> +/**
> + * arch_syscall_enter_seccomp - Architecture specific seccomp invocation
> + * @regs:      Pointer to currents pt_regs
> + *
> + * Returns: The original or a modified syscall number
> + *
> + * Invoked from syscall_enter_from_user_mode(). Can be replaced by
> + * architecture specific code.
> + */
> +static inline long arch_syscall_enter_seccomp(struct pt_regs *regs);

Ick.  I'd rather see arch_populate_seccomp_data() and kill this hook.
But we can clean this up later.

> +/**
> + * arch_syscall_enter_audit - Architecture specific audit invocation
> + * @regs:      Pointer to currents pt_regs
> + *
> + * Invoked from syscall_enter_from_user_mode(). Must be replaced by
> + * architecture specific code if the architecture supports audit.
> + */
> +static inline void arch_syscall_enter_audit(struct pt_regs *regs);
> +

Let's pass u32 arch here.

> +/**
> + * syscall_enter_from_user_mode - Check and handle work before invoking
> + *                              a syscall
> + * @regs:      Pointer to currents pt_regs
> + * @syscall:   The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the
> + * function returns all state is correct and the subsequent functions can be
> + * instrumented.
> + *
> + * Returns: The original or a modified syscall number
> + *
> + * If the returned syscall number is -1 then the syscall should be
> + * skipped. In this case the caller may invoke syscall_set_error() or
> + * syscall_set_return_value() first.  If neither of those are called and -1
> + * is returned, then the syscall will fail with ENOSYS.
> + *
> + * The following functionality is handled here:
> + *
> + *  1) Establish state (lockdep, RCU (context tracking), tracing)
> + *  2) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
> + *     arch_syscall_enter_seccomp(), trace_sys_enter()
> + *  3) Invocation of arch_syscall_enter_audit()
> + */
> +long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);

This should IMO also take u32 arch.

I'm also uneasy about having this do the idtentry/irqentry stuff as
well as the syscall stuff.  Is there a particular reason you did it
this way instead of having callers do:

idtentry_enter();
instrumentation_begin();
syscall_enter_from_user_mode();

FWIW, I think we could make this even better -- couldn't this get
folded together with syscall *exit* and become:

idtentry_enter();
instrumentation_begin();
generic_syscall();
instrumentation_end();
idtentry_exit();

and generic_syscall() would call arch_dispatch_syscall(regs, arch, syscall_nr);



> +
> +/**
> + * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
> + * @regs:      Pointer to currents pt_regs
> + *
> + * Invoked from architecture specific entry code with interrupts disabled.
> + * Can only be called when the interrupt entry came from user mode. The
> + * calling code must be non-instrumentable.  When the function returns all
> + * state is correct and the subsequent functions can be instrumented.
> + *
> + * The function establishes state (lockdep, RCU (context tracking), tracing)
> + */
> +void irqentry_enter_from_user_mode(struct pt_regs *regs);

Unless the rest of the series works differently from what I expect, I
don't love this name.  How about normal_entry_from_user_mode() or
ordinary_entry_from_user_mode()?  After all, this seems to cover IRQ,
all the non-horrible exceptions, and (internally) syscalls.

--Andy
