From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Fri, 15 May 2020 16:16:57 +0200
Message-ID: <20200515141657.GF2940@hirez.programming.kicks-ass.net>
References: <20200515140023.25469-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200515140023.25469-1-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 15, 2020 at 04:00:16PM +0200, Joerg Roedel wrote:
> Joerg Roedel (7):
>   mm: Add functions to track page directory modifications
>   mm/vmalloc: Track which page-table levels were modified
>   mm/ioremap: Track which page-table levels were modified
>   x86/mm/64: Implement arch_sync_kernel_mappings()
>   x86/mm/32: Implement arch_sync_kernel_mappings()
>   mm: Remove vmalloc_sync_(un)mappings()
>   x86/mm: Remove vmalloc faulting
> 
>  arch/x86/include/asm/pgtable-2level_types.h |   2 +
>  arch/x86/include/asm/pgtable-3level_types.h |   2 +
>  arch/x86/include/asm/pgtable_64_types.h     |   2 +
>  arch/x86/include/asm/switch_to.h            |  23 ---
>  arch/x86/kernel/setup_percpu.c              |   6 +-
>  arch/x86/mm/fault.c                         | 176 +-------------------
>  arch/x86/mm/init_64.c                       |   5 +
>  arch/x86/mm/pti.c                           |   8 +-
>  arch/x86/mm/tlb.c                           |  37 ----
>  drivers/acpi/apei/ghes.c                    |   6 -
>  include/asm-generic/5level-fixup.h          |   5 +-
>  include/asm-generic/pgtable.h               |  23 +++
>  include/linux/mm.h                          |  46 +++++
>  include/linux/vmalloc.h                     |  18 +-
>  kernel/notifier.c                           |   1 -
>  kernel/trace/trace.c                        |  12 --
>  lib/ioremap.c                               |  46 +++--
>  mm/nommu.c                                  |  12 --
>  mm/vmalloc.c                                | 109 +++++++-----
>  19 files changed, 204 insertions(+), 335 deletions(-)

I'm thinking this improves the status-quo, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Like Andy, I think I'd like x86_64 to pre-populate, but that can easily
be done on top and should not hold this back.
