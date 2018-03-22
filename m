From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 23/45] sched: add do_sched_yield() helper; remove
 in-kernel call to sched_yield()
Date: Thu, 22 Mar 2018 10:44:54 -0700
Message-ID: <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-24-linux@dominikbrodowski.net> <20180322172959.GX4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322172959.GX4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> But why !? Either Cc me on more of the series such that the whole makes
> sense, or better yet, write a proper Changelog.

This is a common issue. We should encourage people to always send at
least the cover-page to everybody who gets cc'd, even if they don't
get the whole series.

Anyway, to repeat: the calling convention for x86-64 system call
wrappers will be to just pass in "struct pt_regs", and the system call
wrapper itself will take the arguments from there.

That means that we won't have random user space contents in registers
that can leak deep down the call chain. The registers are cleared at
system call entry, and only the actual real arguments are reloaded.

(It also makes do_syscall_64() generate better code, natch).

Anyway, that means that you *CANNOT* call "sys_xyz() from kernel code.
Not that you really should have anyway, but there are tons of
historical reasons why we do. But now it fundamentally won't work,
because you'd need to literally do

    { struct pt_regs regs;
       regs.rdi = (unsigned long) firstarg;
       regs.rsi = (unsigned long) second;
      ...
      sys_xyz(&regs); }

to do it on x86-64.

Anyway, there's a longer discussion about why this is the case
elsewhere, and why we want to do it, but just take it as granted: you
will not be able to call sys_xyz() directly, and that's just a fact.

Making people able to do it would make real system calls (that are a
hell of a lot more important) slower. So it's simply not going to be
allowed.

               Linus
