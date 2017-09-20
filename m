From: Andy Lutomirski <luto@kernel.org>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Wed, 20 Sep 2017 09:02:15 -0700
Message-ID: <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170917223608.GA14577@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Andrew Lutomirski <luto@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, Maged Michael <maged.michael@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Sep 17, 2017 at 3:36 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> Hello!
>
> Rough notes from our discussion last Thursday.  Please reply to the
> group with any needed elaborations or corrections.
>
> Adding Andy and Michael on CC since this most closely affects their
> architectures.  Also adding Dave Watson and Maged Michael because
> the preferred approach requires that processes wanting to use the
> lightweight sys_membarrier() do a registration step.

Not to be too much of a curmudgeon, but I think that there should be a
real implementation of the isync membarrier before this get merged.
This series purports to solve two problems, ppc barriers and x86
exit-without-isync, but it's very hard to evaluate whether it actually
solves the latter problem given the complete lack of x86 or isync code
in the current RFC.

It still seems to me that you won't get any particular advantage for
using this registration mechanism on x86 even when you implement
isync.  Unless I've misunderstood, the only real issue on x86 is that
you need a helper like arch_force_isync_before_usermode(), and that
helper doesn't presently exist.  That means that this whole patchset
is standing on very dangerous ground: you'll end up with an efficient
implementation that works just fine without even requesting
registration on every architecture except ppc.  That way lies
userspace bugs.

Also, can you elaborate on the PPC issue?  PPC appears to track
mm_cpumask more or less just like x86.  Is the issue just that this
tracking has no implied barriers?  If so, how does TLB flush on ppc
work?  It really does seem impressive to me that an architecture can
efficiently support munmap() but not an expedited private membarrier.

--Andy
