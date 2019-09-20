From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry function
Date: Fri, 20 Sep 2019 16:41:03 -0700
Message-ID: <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
References: <20190919150314.054351477@linutronix.de> <20190919150808.724554170@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919150808.724554170@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Replace the syscall entry work handling with the generic version, Provide
> the necessary helper inlines to handle the real architecture specific
> parts, e.g. audit and seccomp invocations.

> -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> -               ret = tracehook_report_syscall_entry(regs);
> -               if (ret || (work & _TIF_SYSCALL_EMU))
> -                       return -1L;
> -       }

Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.
