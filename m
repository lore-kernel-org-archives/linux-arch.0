From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 23/45] sched: add do_sched_yield() helper; remove
 in-kernel call to sched_yield()
Date: Thu, 22 Mar 2018 18:41:43 +0100
Message-ID: <20180322174143.GA2433@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-24-linux@dominikbrodowski.net>
 <20180322172959.GX4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322172959.GX4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 22, 2018 at 06:29:59PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 22, 2018 at 10:00:37AM +0100, Dominik Brodowski wrote:
> > Using the sched-internal do_sched_yield() helper allows us to get rid of
> > the sched-internal call to the sys_sched_yield() syscall.
> > 
> > This patch is part of a series which tries to remove in-kernel calls to
> > syscalls. On this basis, the syscall entry path can be streamlined.
> 
> But why !? Either Cc me on more of the series such that the whole makes
> sense, or better yet, write a proper Changelog.

Well, the summary is right there in the changelog: Kernel code simply should
not pretend to be userspace and call a syscall function. For a more
detailled description, see, for instance, Linus' explanation in
http://lkml.kernel.org/r/CA+55aFwo7yA1gm8AUYMEQA8ZNY-9GGF8Oup09jJFvEa4J7C+jA@mail.gmail.com :

| On x86-64, we'd like to just pass the 'struct pt_regs *' pointer, and
| have the sys_xyz() function itself just pick out the arguments it
| needs from there.
|
| That has a few reasons for it:
| 
| - we can clear all registers at system call entry, which helps defeat
| some of the "pass seldom used register with user-controlled value that
| survives deep into the callchain" things that people used to leak
| information
| 
|  - we can streamline the low-level system call code, which needs to
| pass around 'struct pt_regs *' anyway, and the system call only picks
| up the values it actually needs

I can add such a long description to all these patches, but that seems to
be a bit... longwinded.

Thanks,
	Dominik
