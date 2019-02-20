Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTU7g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Feb 2019 15:59:36 -0500
Date: Wed, 20 Feb 2019 12:59:30 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190220205930.GL12668@bombadil.infradead.org>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
 <20190219222828.GA68281@google.com>
 <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
 <20190220202244.GA80497@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220202244.GA80497@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190220205930.6bEhXgP2BPOzw55jCTwA7HfnGU8KSLJS-wda3XdWPQE@z>

On Wed, Feb 20, 2019 at 01:22:44PM -0700, Yu Zhao wrote:
> On Wed, Feb 20, 2019 at 03:57:59PM +0530, Anshuman Khandual wrote:
> > Using pgtable_pmd_page_ctor() during PMD level pgtable page allocation
> > as suggested in the patch breaks pmd_alloc_one() changes as per the
> > previous proposal. Hence we all would need some agreement here.
> > 
> > https://www.spinics.net/lists/arm-kernel/msg701960.html
> 
> A proposal that requires all page tables to go through a same set of
> ctors on all archs is not only inefficient (for kernel page tables)
> but also infeasible (for arches use kmem for page tables). I've
> explained this clearly.
> 
> The generalized page table functions must recognize the differences
> on different levels and between user and kernel page tables, and
> provide unified api that is capable of handling the differences.

The two architectures I'm aware of (s390 and power) which use sub-page
allocations for page tables do so by allocating entire pages and then
implementing their own allocators.  It shouldn't be a huge problem to
use a ctor for the pages.  We can probably even implement a dtor for them.

Oh, another corner-case I've just remembered is x86-32's PAE with four
8-byte entries in the PGD.  That should also go away and be replaced
with a shared implementation of sub-page allocations which can also be
marked as PageTable.

Ideally PTEs, PMDs, etc, etc would all be accounted to the individual
processes causing them to be allocated.  This isn't really feasible
with the x86 PGD; by definition there's only one per process.  I'm OK
with failing to account this 32-byte allocation to the task though.
So maybe the pgd_cache can remain separate from the hypothetical unified
ppc/s390 code.
