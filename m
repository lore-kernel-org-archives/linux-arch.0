From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Wed, 13 May 2020 09:01:04 -0700
Message-ID: <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
References: <20200513152137.32426-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200513152137.32426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 13, 2020 at 8:21 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi,
>
> here is the next post of this series with these changes to the first
> version:
>
>         - Rebased to v5.7-rc5
>
>         - As a result of the rebase, also removed the
>           vmalloc_sync_mappings() call from tracing code
>
>         - Added a comment that we rely on the compiler optimizing calls
>           to arch_syn_kernel_mappings() away when
>           ARCH_PAGE_TABLE_SYNC_MASK is 0
>
> The first version can be found here:
>
>         https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/
>
> The cover letter of the first post also has more details on the
> motivation for this patch-set.
>
> Please review.
>

Assuming the missing cleanup at the end gets done:

Acked-by: Andy Lutomirski <luto@kernel.org>

grumpily acked, anyway.

I would love to see a followup patch that preallocates the vmalloc
region on 64-bit and compiles out pgd_list and all of the associated
gunk.
