Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDLSQG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 14:16:06 -0400
Date: Fri, 12 Apr 2019 20:15:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"): BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Message-ID: <20190412181557.GC12232@hirez.programming.kicks-ass.net>
References: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
 <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <5890.1555087830@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5890.1555087830@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>
Message-ID: <20190412181557.GGr4QhgDT3QDF9O-OCbRJBi9dYB4ugZdbejv0YRFuTo@z>

On Fri, Apr 12, 2019 at 05:50:30PM +0100, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > We should never have stack alignment bigger than 16 bytes.  And
> > preferably not even that.
> 
> At least one arch I know of (FRV) had instructions that could atomically
> load/store register pairs or register quads, but they had to be pair- or
> quad-aligned (ie. 8- or 16-byte), which made for more efficient code if you
> could use them.
> 
> I don't know whether any arch we currently support has features like this (I
> know some have multi-reg load/stores, but they seem to require only
> word-alignment).

ARC (iirc) has u64 atomics with natural alignment requirements but
alignof(u64)=4 due it being a 32bit arch. Which is awkward.

ARMv7 can also do u64 ops when aligned right, but I forgot if they have
proper alignment or not.
