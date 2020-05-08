From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Fri, 8 May 2020 21:20:00 +0200
Message-ID: <20200508192000.GB2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 08, 2020 at 04:40:36PM +0200, Joerg Roedel wrote:

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
>  drivers/acpi/apei/ghes.c                    |   6 -
>  include/asm-generic/5level-fixup.h          |   5 +-
>  include/asm-generic/pgtable.h               |  23 +++
>  include/linux/mm.h                          |  46 +++++
>  include/linux/vmalloc.h                     |  13 +-
>  kernel/notifier.c                           |   1 -
>  lib/ioremap.c                               |  46 +++--
>  mm/nommu.c                                  |  12 --
>  mm/vmalloc.c                                | 109 +++++++-----
>  17 files changed, 199 insertions(+), 286 deletions(-)

The only concern I have is the pgd_lock lock hold times.

By not doing on-demand faults anymore, and consistently calling
sync_global_*(), we iterate that pgd_list thing much more often than
before if I'm not mistaken.
