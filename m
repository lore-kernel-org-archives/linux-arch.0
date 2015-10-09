From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 00/12] THP support for ARC
Date: Fri, 9 Oct 2015 15:03:26 +0530
Message-ID: <561789E6.9090800@synopsys.com>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <560CCC73.9080705@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <560CCC73.9080705@synopsys.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew
 Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Thursday 01 October 2015 11:32 AM, Vineet Gupta wrote:
> On Tuesday 22 September 2015 04:04 PM, Vineet Gupta wrote:
>> > Hi,
>> > 
>> > This series brings THP support to ARC. It also introduces an optional new
>> > thp hook for arches to possibly optimize the TLB flush in thp regime.
>> > 
>> > Please review !
>> > 
>> > Changes Since v1 [*]
>> >    - Rebased against v4.3-rc2
>> >    - Switched ARC pgtable_t to pte_t * 		(Kiril)
>> >    - Removed stub implementations for		(Andrew)
>> > 	pmdp_set_access_flags, pmdp_test_and_clear_young, pmdp_set_wrprotect,
>> > 	pmdp_collapse_flush, pmd_same
>> > 
>> > [*] http://lkml.kernel.org/r/1440666194-21478-1-git-send-email-vgupta@synopsys.com
>> > 
>> > Vineet Gupta (12):
>> >   ARC: mm: switch pgtable_to to pte_t *
>> >   ARC: mm: pte flags comsetic cleanups, comments
>> >   ARC: mm: Introduce PTE_SPECIAL
>> >   Documentation/features/vm: pte_special now supported by ARC
>> >   ARCv2: mm: THP support
>> >   ARCv2: mm: THP: boot validation/reporting
>> >   Documentation/features/vm: THP now supported by ARC
>> >   mm: move some code around
>> >   mm,thp: reduce ifdef'ery for THP in generic code
>> >   mm,thp: introduce flush_pmd_tlb_range
>> >   ARCv2: mm: THP: Implement flush_pmd_tlb_range() optimization
>> >   ARCv2: Add a DT which enables THP
>> > 
>> >  Documentation/features/vm/THP/arch-support.txt     |  2 +-
>> >  .../features/vm/pte_special/arch-support.txt       |  2 +-
>> >  arch/arc/Kconfig                                   |  4 +
>> >  arch/arc/boot/dts/hs_thp.dts                       | 59 +++++++++++++
>> >  arch/arc/include/asm/hugepage.h                    | 82 ++++++++++++++++++
>> >  arch/arc/include/asm/page.h                        |  5 +-
>> >  arch/arc/include/asm/pgalloc.h                     |  6 +-
>> >  arch/arc/include/asm/pgtable.h                     | 60 +++++++------
>> >  arch/arc/mm/tlb.c                                  | 76 ++++++++++++++++-
>> >  arch/arc/mm/tlbex.S                                | 21 +++--
>> >  include/asm-generic/pgtable.h                      | 49 ++++-------
>> >  mm/huge_memory.c                                   |  2 +-
>> >  mm/pgtable-generic.c                               | 99 ++++++++++------------
>> >  13 files changed, 345 insertions(+), 122 deletions(-)
>> >  create mode 100644 arch/arc/boot/dts/hs_thp.dts
>> >  create mode 100644 arch/arc/include/asm/hugepage.h
> Andrew, Kirill, could you please review/ack the generic mm bits atleast so I can
> proceed with moving the stuff into linux-next !

Ping 2 ! Can I please get some acks on the generic mm bits. Some of the changes
will likely collide Kirill's THP rework !

Given people rebase off of mmtomm would it be better if generic patches went thru
Andrew and probably included sooner for 4.4 target ?

-Vineet

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
