From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: mips octeon memory model questions
Date: Tue, 4 Feb 2014 11:51:31 -0800
Message-ID: <52F144C3.1080705@caviumnetworks.com>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:30737
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932188AbaBDTvs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Feb 2014 14:51:48 -0500
In-Reply-To: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 02/04/2014 10:41 AM, Peter Zijlstra wrote:
> Hi all,
>
> I have a number of questions in regards to commit 6b07d38aaa520ce.
>
> Given that the octeon doesn't reorder reads; the following:
>
> "      sync
>         ll ...
>         .
>         .
>         .
>         sc ...
>         .
>         .
>         sync
>
>    The second SYNC was redundant, but harmless.  "
>
> Still doesn't make sense, because if we need the first sync to stop
> writes from being re-ordered with the ll-sc, we also need the second
> sync to avoid the same.
>
> Suppose:
>     STORE a
>     sync
>     LL-SC b
>     (not a sync)
>     STORE c
>
> What avoids this becoming visible as:
>
>    a
>    c
>    b

On OCTEON, SC implies a SYNC operation for the target memory location. 
So the "SC b" is ordered before any writes that come after the SC.


>
> ?
>
> Then there is:
>
> "       syncw;syncw
>          ll
>          .
>          .
>          .
>          sc
>          .
>          .
>
>      Has identical semantics to the first sequence, but is much faster.
>      The SYNCW orders the writes, and the SC will not complete successfully
>      until the write is committed to the coherent memory system.  So at the
>      end all preceeding writes have been committed.  Since Octeon does not
>      do speculative reads, this functions as a full barrier."
>
> Read Documentation/memory-barrier.txt:TRANSITIVITY, the above doesn't
> sound like syncw is actually multi-copy atomic, and therefore doesn't
> provide transitivity, and therefore is not a valid sequence for
> operations that are supposed to imply a full memory-barrier.
>
> Please as to explain.
>

It makes my head hurt.

The sequence:

    SYNCW
    LL a
    <other instructions that are not stores>
    SC a


Should function as a "<general barrier>".


I can try to explain why I think this is so:

Coherency is managed by the L2 Cache controller.

Each CPU has an n-entry write buffer.  The SYNCW insures that all 
preceding stores will commit before the store of the SC.  the 
instruction after the SC will not execute until the SC's store is committed.

The full SYNC instruction functions in a similar manner to the above 
sequence.  The only difference is that it doesn't have the side effect 
of modifying the target of the SC instruction.

In both cases all the stores are committed, and following loads are 
delayed until the commit is acknowledged.

Note:  All this is based on my understanding of the OCTEON 
micro-architecture.  I have not done any exhaustive testing Transitivity 
principle with respect to SYNCW/LL/SC as described above.

David Daney
