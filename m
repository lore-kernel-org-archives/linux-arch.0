Return-Path: <SRS0=5OOM=BG=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WhP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 18:37:15 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65ED820838
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 22:37:14 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id r2so11301985wrs.8
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 15:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200721105706.030914876@linutronix.de> <20200721110808.562407874@linutronix.de>
In-Reply-To: <20200721110808.562407874@linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 27 Jul 2020 15:37:01 -0700
Message-ID: <CALCETrVwrQ6oCxwEraxLF8ia8P8HUR2czrfqYtgQEdm8DM=RLQ@mail.gmail.com>
Subject: Re: [patch V4 03/15] entry: Provide generic syscall exit function
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200727223701.1zs8etPlLKlGnTBlEu_JM9gCCH8GL0j3bAAnNgg_va0@z>

On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Like syscall entry all architectures have similar and pointlessly different
> code to handle pending work before returning from a syscall to user space.
>
>   1) One-time syscall exit work:
>       - rseq syscall exit
>       - audit
>       - syscall tracing
>       - tracehook (single stepping)
>
>   2) Preparatory work
>       - Exit to user mode loop (common TIF handling).
>       - Architecture specific one time work arch_exit_to_user_mode_prepare()
>       - Address limit and lockdep checks
>
>   3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
>      arch_exit_to_user_mode() to handle e.g. speculation mitigations
>
> Provide a generic version based on the x86 code which has all the RCU and
> instrumentation protections right.
>
> Provide a variant for interrupt return to user mode as well which shares
> the above #2 and #3 work items.

I still don't love making the syscall exit path also do the
non-syscall stuff.  Do you like my suggestion of instead having a
generic function to do the syscall complete with all the entry and
exit stuff?

The singlestep handling is a mess.  I'm not convinced that x86 does
this sensibly.  Right now, I *think* we are quite likely to not send
SIGTRAP on the way out of syscalls if TF is set, and we'll actually
execute one more user instruction before sending the signal.  One
might reasonably debate whether this is a bug, but we should probably
figure it out at some point.

That latter bit is relevant to your patch because the fix might end up
being something like this:

void do_syscall_64(...)
{
  unsigned long orig_flags;
  idtentry_enter();
  instrumentation_begin();
  generic_do_syscall(regs, regs->orig_ax, AUDIT_ARCH_X86_64);
  if (unlikely(orig_flags & regs->flags & X86_EFLAGS_TF))
    raise SIGTRAP -- pretend we got #DB.
  instrumentation_end();
  idtentry_exit(); <-- signal is delivered here
}

That logic is probably all kinds of buggy, but the point is that the
special handling probably wants to be done between the generic syscall
code and the exit code.
