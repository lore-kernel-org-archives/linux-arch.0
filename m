Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33542 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeIMX7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2018 19:59:30 -0400
Date: Thu, 13 Sep 2018 20:48:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 03/11] x86/mm: Page size aware flush_tlb_mm_range()
Message-ID: <20180913184836.GN24142@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.012757318@infradead.org>
 <f89e61a3-0eb0-3d00-fbaa-f30c2cf60be3@linux.intel.com>
 <20180913184230.GD24124@hirez.programming.kicks-ass.net>
 <20180913184632.GM24142@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913184632.GM24142@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180913184836.XmfDwD5T4uJmIh6PN9xNPG4xZ-8mbDDDIP333TC51AU@z>

On Thu, Sep 13, 2018 at 08:46:32PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 13, 2018 at 08:42:30PM +0200, Peter Zijlstra wrote:
> > > > +#define flush_tlb_range(vma, start, end)			\
> > > > +		flush_tlb_mm_range((vma)->vm_mm, start, end,	\
> > > > +				(vma)->vm_flags & VM_HUGETLB ? PMD_SHIFT : PAGE_SHIFT)
> > > 
> > > This is safe.  But, Couldn't this PMD_SHIFT also be PUD_SHIFT for a 1G
> > > hugetlb page?
> > 
> > It could be, but can we tell at that point?
> 
> I had me a look in higetlb.h, would something like so work?
> 
> #define flush_tlb_range(vma, start, end)			\
> 	flush_tlb_mm_range((vma)->vm_mm, start, end,		\
> 			   huge_page_shift(hstate_vma(vma)))
> 

D'uh

#define flush_tlb_range(vma, start, end)			\
	flush_tlb_mm_range((vma)->vm_mm, start, end,		\
	   (vma)->vm_flags & VM_HUGETLB ? huge_page_shift(hstate_vma(vma)) : PAGE_SHIFT)
