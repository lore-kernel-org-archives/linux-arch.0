Return-Path: <SRS0=nPx+=65=kvack.org=owner-linux-mm@kernel.org>
From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Fri, 15 May 2020 16:00:16 +0200
Message-ID: <20200515140023.25469-1-joro@8bytes.org>
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org
Cc: hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515140016.F74loBAfQA0FwSQAYZ3gN3T6S8kPbP_ljTkvhXM4c5o@z>

Hi,

here is the updated version of this series with these
changes:

	- Removed sync_current_stack_to_mm() too.

	- Added Acked-by's from Andy Lutomirski

The previous versions can be found here:

	v1: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/

	v2: https://lore.kernel.org/lkml/20200513152137.32426-1-joro@8bytes.org/

The cover-letter of v1 has more details on the motivation
for this patch-set.

Please review.

Regards,

	Joerg

Joerg Roedel (7):
  mm: Add functions to track page directory modifications
  mm/vmalloc: Track which page-table levels were modified
  mm/ioremap: Track which page-table levels were modified
  x86/mm/64: Implement arch_sync_kernel_mappings()
  x86/mm/32: Implement arch_sync_kernel_mappings()
  mm: Remove vmalloc_sync_(un)mappings()
  x86/mm: Remove vmalloc faulting

 arch/x86/include/asm/pgtable-2level_types.h |   2 +
 arch/x86/include/asm/pgtable-3level_types.h |   2 +
 arch/x86/include/asm/pgtable_64_types.h     |   2 +
 arch/x86/include/asm/switch_to.h            |  23 ---
 arch/x86/kernel/setup_percpu.c              |   6 +-
 arch/x86/mm/fault.c                         | 176 +-------------------
 arch/x86/mm/init_64.c                       |   5 +
 arch/x86/mm/pti.c                           |   8 +-
 arch/x86/mm/tlb.c                           |  37 ----
 drivers/acpi/apei/ghes.c                    |   6 -
 include/asm-generic/5level-fixup.h          |   5 +-
 include/asm-generic/pgtable.h               |  23 +++
 include/linux/mm.h                          |  46 +++++
 include/linux/vmalloc.h                     |  18 +-
 kernel/notifier.c                           |   1 -
 kernel/trace/trace.c                        |  12 --
 lib/ioremap.c                               |  46 +++--
 mm/nommu.c                                  |  12 --
 mm/vmalloc.c                                | 109 +++++++-----
 19 files changed, 204 insertions(+), 335 deletions(-)

-- 
2.17.1
