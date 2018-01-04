From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 20:32:46 +0000
Message-ID: <20180104203246.5ff65328@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
        <20180104014100.3786e686@alans-desktop>
        <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm>
        <20180104193936.GB10427@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104193936.GB10427@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>
List-Id: linux-arch.vger.kernel.org

> For kernel, we may be able to annonate "tainted" pointers. But then
> there's quite a lot of code in userspace... What will need to be
> modified? Just JITs? Setuid programs?

You never go from one user process to another except via the kernel. We
have no hardware scheduling going on. That means that if the kernel
and/or CPU imposes the correct speculation barriers you can't attack
anyone but yourself.

Sandboxes and JITs are the critical components where the issue matters.
That IMHO is also an argument for why once the basics are in place there
is a good argument for a prctl and maybe cgroup support to run some
groups of processes with different trust levels.

For example there's not much point protecting a user process from root,
or a process from another process that could use ptrace on it instead.

> And we can get part of the performance back by adding more of
> SMT... AFAICT.

The current evidence is not because most workloads are not sufficiently
parallelisable. Likewise doing the speculation in the compiler doesn't
appear to have been the success people hoped for (IA64).

Alan
