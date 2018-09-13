Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbeIMR1y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Sep 2018 13:27:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DCIcWw056554
        for <linux-arch@vger.kernel.org>; Thu, 13 Sep 2018 08:18:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mfnvsmqb7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Sep 2018 08:18:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 13 Sep 2018 13:18:32 +0100
Date: Thu, 13 Sep 2018 14:18:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
In-Reply-To: <20180913105738.GW24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
        <20180913092811.894806629@infradead.org>
        <20180913123014.0d9321b8@mschwideX1>
        <20180913105738.GW24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <20180913141827.1776985e@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180913121827.0mtln8fjTZzSEYgfXpjfmcKS0ET8n0F3lqpnOYoP2Q0@z>

On Thu, 13 Sep 2018 12:57:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 13, 2018 at 12:30:14PM +0200, Martin Schwidefsky wrote:
> 
> > > + * The mmu_gather data structure is used by the mm code to implement the
> > > + * correct and efficient ordering of freeing pages and TLB invalidations.
> > > + *
> > > + * This correct ordering is:
> > > + *
> > > + *  1) unhook page
> > > + *  2) TLB invalidate page
> > > + *  3) free page
> > > + *
> > > + * That is, we must never free a page before we have ensured there are no live
> > > + * translations left to it. Otherwise it might be possible to observe (or
> > > + * worse, change) the page content after it has been reused.
> > > + *  
> > 
> > This first comment already includes the reason why s390 is probably better off
> > with its own mmu-gather implementation. It depends on the situation if we have
> > 
> > 1) unhook the page and do a TLB flush at the same time
> > 2) free page
> > 
> > or
> > 
> > 1) unhook page
> > 2) free page
> > 3) final TLB flush of the whole mm  
> 
> that's the fullmm case, right?

That includes the fullmm case but we use it for e.g. munmap of a single-threaded
program as well.
 
> > A variant of the second order we had in the past is to do the mm TLB flush first,
> > then the unhooks and frees of the individual pages. The are some tricky corners
> > switching between the two variants, see finish_arch_post_lock_switch.
> > 
> > The point is: we *never* have the order 1) unhook, 2) TLB invalidate, 3) free.
> > If there is concurrency due to a multi-threaded application we have to do the
> > unhook of the page-table entry and the TLB flush with a single instruction.  
> 
> You can still get the thing you want if for !fullmm you have a no-op
> tlb_flush() implementation, assuming your arch page-table frobbing thing
> has the required TLB flush in.

We have a non-empty tlb_flush_mmu_tlbonly to do a full-mm flush for two cases
1) batches of page-table entries for single-threaded programs
2) flushing of the pages used for the page-table structure itself

In fact only the page-table pages are added to the mmu_gather batch, the target
page of the virtual mapping is always freed immediately.
 
> Note that that's not utterly unlike how the PowerPC/Sparc hash things
> work, they clear and invalidate entries different from others and don't
> use the mmu_gather tlb-flush.

We may get something working with a common code mmu_gather, but I fear the
day someone makes a "minor" change to that subtly break s390. The debugging of
TLB related problems is just horrible..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
