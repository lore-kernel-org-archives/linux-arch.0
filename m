Return-Path: <SRS0=W/Kb=6W=kvack.org=owner-linux-mm@kernel.org>
Date: Fri, 8 May 2020 21:10:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/7] mm/vmalloc: Track which page-table levels were
 modified
Message-ID: <20200508191048.GA2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508144043.13893-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508144043.13893-3-joro@8bytes.org>
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200508191048.SMbrYFTGzQAxMsUYGZV1pOKqxA04PIZPk7dFI9KFp0w@z>

On Fri, May 08, 2020 at 04:40:38PM +0200, Joerg Roedel wrote:

> +/*
> + * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> + * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> + * needs to be called.
> + */
> +#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> +#define ARCH_PAGE_TABLE_SYNC_MASK 0
> +#endif
> +
> +void arch_sync_kernel_mappings(unsigned long start, unsigned long end);


> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> +		arch_sync_kernel_mappings(start, end);

So you're relying on the compiler DCE'ing the call in the 'normal' case.

Works I suppose, but I went over the patches twice to look for a default
implementation of it before I figured that out ...
