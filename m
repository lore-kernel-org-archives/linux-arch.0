From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry function
Date: Mon, 23 Sep 2019 10:31:14 +0200
Message-ID: <20190923083114.GF2349@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150808.724554170@linutronix.de>
 <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 20, 2019 at 04:41:03PM -0700, Andy Lutomirski wrote:
> On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Replace the syscall entry work handling with the generic version, Provide
> > the necessary helper inlines to handle the real architecture specific
> > parts, e.g. audit and seccomp invocations.
> 
> > -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> > -               ret = tracehook_report_syscall_entry(regs);
> > -               if (ret || (work & _TIF_SYSCALL_EMU))
> > -                       return -1L;
> > -       }
> 
> Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.

IIUC that's actually in patch #1.
