From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Thu, 21 Sep 2017 15:09:50 +0200
Message-ID: <20170921130950.nwfbyiil34psoyua@hirez.programming.kicks-ass.net>
References: <20170917223608.GA14577@linux.vnet.ibm.com>
 <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
 <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38379 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdIUNKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2017 09:10:01 -0400
Content-Disposition: inline
In-Reply-To: <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>

On Wed, Sep 20, 2017 at 06:13:50PM +0000, Mathieu Desnoyers wrote:

> > Also, can you elaborate on the PPC issue?  PPC appears to track
> > mm_cpumask more or less just like x86.  Is the issue just that this
> > tracking has no implied barriers?  If so, how does TLB flush on ppc
> > work?  It really does seem impressive to me that an architecture can
> > efficiently support munmap() but not an expedited private membarrier.
> 
> I'll leave this question to the PPC experts :)

IIRC PPC does not keep a tight mm_cpumask, it only sets bit, it never
clears bits. The atomic op required to set bits does not imply any
memory barrier on PPC.

TLB invalidation is a TLBI instruction, it sends TLBI broadcast packets
over the interconnect, it doesn't require IPIs like x86.

The only optimization PPC does is that if the mm_cpumask has only a
single bit set, it uses a TLBI instruction without broadcast, which is
cheaper.
