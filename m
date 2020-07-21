From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 02/15] entry: Provide generic syscall entry
 functionality
Date: Tue, 21 Jul 2020 14:38:16 -0700
Message-ID: <202007211426.B40A7A7BD@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.455350746@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721110808.455350746@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:08PM +0200, Thomas Gleixner wrote:
> On syscall entry certain work needs to be done:
> 
>    - Establish state (lockdep, context tracking, tracing)
>    - Conditional work (ptrace, seccomp, audit...)
> 
> This code is needlessly duplicated and  different in all
> architectures.
> 
> Provide a generic version based on the x86 implementation which has all the
> RCU and instrumentation bits right.
> 
> As interrupt/exception entry from user space needs parts of the same
> functionality, provide a function for this as well.
> 
> syscall_enter_from_user_mode() and irqentry_enter_from_user_mode() must be
> called right after the low level ASM entry. The calling code must be
> non-instrumentable. After the functions returns state is correct and the
> subsequent functions can be instrumented.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

With one suggestion...

> [...]
> --- /dev/null
> +++ b/kernel/entry/common.c
> @@ -0,0 +1,88 @@
> [...]
> +static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
> +{
> +	if (unlikely(audit_context())) {
> +		unsigned long args[6];
> +
> +		syscall_get_arguments(current, regs, args);
> +		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> +	}
> +}

One thing I noticed while doing syscall entry timings for the kernel
stack base offset randomization was that the stack protector was being
needlessly enabled in certain paths (seccomp, audit) due to seeing a
register array being declared on the stack. As part of that series I
suggested down-grading the stack protector. Since then, Peter's changes
entirely disabled the stack protector on the entry code, which I
grudgingly accept (I'd rather have a way to mark a variable as "ignore
this for stack protector detection", but ... there isn't, so fine.)

> [...]
> --- /dev/null
> +++ b/kernel/entry/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_GENERIC_ENTRY) += common.o

But, my point is, let's avoid tripping over this again, and retain the
disabling here:

CFLAGS_common.o += -fno-stack-protector

I can add this again later, but it'd be nice if it was done here to
avoid gaining back the TIF_WORK stack protector overhead penalty (which
we're free of in v5.8 for the first time). ;)

-- 
Kees Cook
