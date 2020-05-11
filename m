From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Mon, 11 May 2020 21:14:14 +0200
Message-ID: <20200511191414.GY8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
 <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
 <20200511074243.GE2957@hirez.programming.kicks-ass.net>
 <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 11, 2020 at 08:36:31AM -0700, Andy Lutomirski wrote:
> What if we make 32-bit PTI depend on PAE?

It already does, PTI support for legacy paging had to be removed because
there were memory corruption problems with THP. The reason was that huge
PTEs in the user-space area were mapped in two page-tables (kernel and
user), but A/D bits were only fetched from the kernel part. To not make
things more complicated we agreed on just not supporting PTI without
PAE.

> And drop 32-bit Xen PV support?  And make 32-bit huge pages depend on
> PAE?  Then 32-bit non-PAE can use the direct-mapped LDT, 32-bit PTI
> (and optionally PAE non-PTI) can use the evil virtually mapped LDT.
> And 32-bit non-PAE (the 2-level case) will only have pointers to page
> tables at the top level.  And then we can preallocate.

Not sure I can follow you here. How can 32-bit PTI with PAE use the LDT
from the direct mapping? I am guessing you want to get rid of the
SHARED_KERNEL_PMD==0 case for PAE kernels. This would indeed make
syncing unneccessary on PAE, but pre-allocation would still be needed
for 2-level paging. Just the amount of memory needed for the
pre-allocated PTE pages is half as big as it would be with PAE.

> Or maybe we don't want to defeature this much, or maybe the memory hit
> from this preallocation will hurt little 2-level 32-bit systems too
> much.

It will certainly make Linux less likely to boot on low-memory x86-32
systems, whoever will be affected by this.


	Joerg
