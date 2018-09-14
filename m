Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726966AbeINPm2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 11:42:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EAJmQa062985
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 06:28:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mg9hs4hqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 06:28:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 14 Sep 2018 11:28:32 +0100
Date: Fri, 14 Sep 2018 12:28:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
In-Reply-To: <20180913123937.GX24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
        <20180913092811.894806629@infradead.org>
        <20180913123014.0d9321b8@mschwideX1>
        <20180913105738.GW24124@hirez.programming.kicks-ass.net>
        <20180913141827.1776985e@mschwideX1>
        <20180913123937.GX24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <20180914122824.181d9778@mschwideX1>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180914102824.-8smsjGMmXtNR0EpTjczm1ozWpYuI1C9wt8LNV9TBAM@z>

On Thu, 13 Sep 2018 14:39:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 13, 2018 at 02:18:27PM +0200, Martin Schwidefsky wrote:
> > We may get something working with a common code mmu_gather, but I fear the
> > day someone makes a "minor" change to that subtly break s390. The debugging of
> > TLB related problems is just horrible..  
> 
> Yes it is, not just on s390 :/
> 
> And this is not something that's easy to write sanity checks for either
> AFAIK. I mean we can do a few multi-threaded mmap()/mprotect()/munmap()
> proglets and catch faults, but that doesn't even get close to covering
> all the 'fun' spots.
> 
> Then again, you're more than welcome to the new:
> 
>   MMU GATHER AND TLB INVALIDATION
> 
> section in MAINTAINERS.

I spent some time to get s390 converted to the common mmu_gather code.
There is one thing I would like to request, namely the ability to
disable the page gather part of mmu_gather. For my prototype patch
see below, it defines the negative HAVE_RCU_NO_GATHER_PAGES Kconfig
symbol that if defined will remove some parts from common code.
Ugly but good enough for the prototype to convey the idea.
For the final solution we better use a positive Kconfig symbol and
add that to all arch Kconfig files except for s390.

The code itself is less hairy than I feared, it worked on the first
try and survived my fork/munmap/mprotect TLB stress test. But as
this is TLB flushing there probably is some subtle problem left..

Here we go:
--
