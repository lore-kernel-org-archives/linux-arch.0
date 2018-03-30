From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/7] use struct pt_regs based syscall calling for x86-64
Date: Fri, 30 Mar 2018 12:46:49 +0200
Message-ID: <20180330104649.GB12688@light.dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
 <20180330101602.ongosnigfmdmgayb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330101602.ongosnigfmdmgayb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 30, 2018 at 12:16:02PM +0200, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > A few questions remain, from important stuff to bikeshedding:
> > 
> > 1) Is it acceptable to pass the existing struct pt_regs to the sys_*()
> >    kernel functions in emulate_vsyscall(), or should it use a hand-crafted
> >    struct pt_regs instead?
> 
> I think so: we already have task_pt_regs() which gives access to the real return 
> registers on the kernel stack.
> 
> I think as long as we constify the pointer, we should pass in the real thing.

Good idea. I have updated the patchset accordingly.

> > 2) Is it the right approach to generate the __sys32_ia32_*() names to
> >    include in the syscall table on-the-fly, or should they all be listed
> >    in arch/x86/entry/syscalls/syscall_32.tbl ?
> 
> I think as a general principle all system call tables should point to the 
> first-hop wrapper symbol name (i.e. __sys32_ia32_*() in this case), not to the 
> generic symbol name - even though we could generate the former from the latter.
> 
> The more indirection in these tables, the harder to read they become I think.
> 
> > 3) I have chosen to name the default 64-bit syscall stub sys_*(), same as
> >    the "normal" syscall, and the IA32_EMULATION compat syscall stub
> >    compat_sys_*(), same as the "normal" compat syscall. Though this
> >    might cause some confusion, as the "same" function uses a different
> >    calling convention and different parameters on x86, it has the
> >    advantages that
> >         - the kernel *has* a function sys_*() implementing the syscall,
> >           so those curious in stack traces etc. will find it in plain
> >           sight,
> >         - it is easier to handle in the syscall table generation, and
> >         - error injection works the same.
> 
> I don't think there should be a symbol space overlap, that will only lead to 
> confusion. The symbols can be _similar_, with a prefix, underscores or so, but 
> they shouldn't match I think.

OK, I'll wait for a few more opinions on these two related issues, and update
the code accordingly then.

> > The whole series is available at
> > 
> >         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-WIP
> 
> BTW., I'd like all these bits to go through the x86 tree.
> 
> What is the expected merge route of the generic preparatory bits?

My current plan is to push the 109 patch bomb to remove in-kernel calls to syscalls
directly to Linus once v4.16 is released.

For this series of seven patches, I am content with them going upstream through
the x86 tree (once that contains a backmerge of Linus' tree or the syscalls
tree, obviously). IMO, these seven patches should be kept together, and not routed
upstream through different channels.

Thanks,
	Dominik
