From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3] membarrier: provide core serialization
Date: Fri, 6 Oct 2017 23:08:25 +0200
Message-ID: <20171006210825.GA6524@worktop.programming.kicks-ass.net>
References: <20170901161007.2661-1-mathieu.desnoyers@efficios.com>
 <20170901162547.GA20313@arm.com>
 <1051991998.1330.1504285238477.JavaMail.zimbra@efficios.com>
 <20170901171048.GA20817@arm.com>
 <238182999.1493.1504291547065.JavaMail.zimbra@efficios.com>
 <CAMOCf+jjy2hjqdmrqFuVvnS8p-i+3Z3ZLubk4ymnRfsdT_F8PA@mail.gmail.com>
 <20170918170129.GF11343@arm.com>
 <CAMOCf+gqMFmw9WCYqE_dXG3J+K=qBVT3Pv=z6CyrbppU6Y5qig@mail.gmail.com>
 <2063294388.33291.1507323476486.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdJFVJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2017 17:09:12 -0400
Content-Disposition: inline
In-Reply-To: <2063294388.33291.1507323476486.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Hans Boehm <hboehm@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Andy Lutomirski <luto@kernel.org>, "Russell King, ARM Linux" <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, ralf@linux-mips.org

On Fri, Oct 06, 2017 at 08:57:56PM +0000, Mathieu Desnoyers wrote:
> Hi Hans, 
> 
> I'm currently making sure the
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED command makes its way into
> the 4.14 kernel before the end of the release candidates.  Once that
> is done, I plan to post a patch adding a new MEMBARRIER_FLAG_SYNC_CORE
> flag for the 4.15 merge window. 
> 
> I have done a bit of research on the various architecture requirements
> for core serialization.  Here are my findings so far about
> instructions providing core serialization on the main architectures
> supported by Linux. 
> 
> There are two places where we need it: in the interrupt handler for
> the membarrier IPI, and between scheduler execution (which can change
> the current "mm") and return to user-space. 
> 
> Please let me know if I missed anything. 
> 
> x86: iret, cpuid, wbinvd -> iret currently provides core serialization
> when going back to userspace and at the end of the IPI. There are
> plans to implement a return path without iret in the future, in which
> case I would need to issue an explicit "cpuid" instruction
> (sync_core()) in switch_mm() if the process is registered with
> MEMBARRIER_FLAG_SYNC_CORE. 

I would much prefer setting a TIF flag that forces the IRET path instead
of doing additional work in switch_mm().

> arm32: returning to user-space provides core serialization. Same at
> the end of membarrier IPI (to be confirmed).  aarch64: ERET
> instruction used when returning to user-space provides core sync. Same
> at the end of membarrier IPI (to be confirmed). 

I thought Will already confirmed ERET did what we need, no?

> parisc: core serialization is ensured by issuing at least 7
> instructions. We should have at least that when going back to
> user-space (to be confirmed). Similar for IPI. 
> [ https://parisc.wiki.kernel.org/images-parisc/6/68/Pa11_acd.pdf | 
>   https://parisc.wiki.kernel.org/images-parisc/6/68/Pa11_acd.pdf ] 5-152 
> 
> mips: eret instruction used when going back to user-space provides
> core sync on all SMP architectures. Probably same for IPI (to be
> confirmed). 
> [ https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf | 
>   https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf ] p. 121 
> on R3k and TX39XX, rfe is used instead, but those are uniprocessor, so
> they do not matter. 
> [ http://os161.eecs.harvard.edu/documentation/sys161/mips.html |
>   http://os161.eecs.harvard.edu/documentation/sys161/mips.html ] 

> sparc: seems to require an explicit "flush" instruction followed by at
> most 5 instructions to perform core serialization. Not sure if implied
> by return to user-space in any way. 

We still have the problem with the virtually indexed archs that we need
to flush I$ on all CPUs.

Some archs have an instruction for this, others do not (or botched it).
So while some archs have a syscall to affect this, it is an integral
part of the use-case for MEMBAR_SYNC_CORE and I feel we must not gloss
over it.
